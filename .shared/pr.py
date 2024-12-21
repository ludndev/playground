import subprocess
import re

# Configuration
destination_branch = 'main'

# Get the current branch dynamically
def get_current_branch():
    result = subprocess.run(
        ['git', 'rev-parse', '--abbrev-ref', 'HEAD'],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )
    return result.stdout.strip()

# Fetch commits between the destination branch and the current branch
def fetch_commits(current_branch):
    result = subprocess.run(
        ['git', 'log', '--oneline', '--no-merges', f'origin/{destination_branch}..{current_branch}'],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )
    commits = result.stdout.strip().split('\n')

    commit_data = []
    for commit in commits:
        if commit:
            try:
                sha, message = commit.split(' ', 1)
                commit_data.append({"sha": sha, "message": message})
            except ValueError:
                continue
    return commit_data

# Check if the commit message references any issue (e.g., #123)
def check_commit_for_issue(commit_message):
    issue_pattern = r'#(\d+)'  # Match issue references like #123
    issue_matches = re.findall(issue_pattern, commit_message)
    return issue_matches

# Check if an issue references a commit using GitHub CLI
def check_issue_for_commit(issue_number, commit_sha):
    result = subprocess.run(
        ['gh', 'issue', 'view', str(issue_number), '--json', 'body', '--jq', '.body'],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )
    issue_body = result.stdout.strip()
    if commit_sha in issue_body:
        return True
    return False

# Format commit details as requested
def format_commit(commit):
    commit_body = subprocess.run(
        ['git', 'log', '--format=%b', '-n', '1', commit['sha']],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    ).stdout.strip()

    # Check if commit references an issue
    issue_references = check_commit_for_issue(commit['message'])

    formatted_commit = f"- `{commit['sha'][:7]}` {commit['message']}"

    if issue_references:
        formatted_commit += f" (References Issue(s): #{', '.join(issue_references)})"

    if commit_body:
        formatted_commit += f"\n  > {commit_body}"

    return formatted_commit

# Generate the PR commit template
def generate_pr_template(current_branch, commits):
    formatted_commits = []
    for commit in commits:
        formatted_commit = format_commit(commit)
        formatted_commits.append(formatted_commit)

        # Check if the commit references an issue or if any issue references the commit
        issue_references = check_commit_for_issue(commit['message'])
        for issue_number in issue_references:
            issue_referenced = check_issue_for_commit(issue_number, commit['sha'])
            if issue_referenced:
                print(f"Commit {commit['sha']} is referenced in Issue #{issue_number}")

    return "\n".join(formatted_commits)

def main():
    current_branch = get_current_branch()
    commits = fetch_commits(current_branch)
    pr_template = generate_pr_template(current_branch, commits)

    pr_body = ""
    pr_body += f"# Changes from `{current_branch}` to `{destination_branch}`\n\n"
    pr_body += f"## Commit{'s' if len(commits) > 1 else ''} Overview: \n\n"

    print(pr_body)

     # Run the GitHub CLI command to create the PR
    result = subprocess.run(
        [
            'gh', 'pr', 'create',
            '--title', f'Changes from {current_branch} to {destination_branch}',
            '--body', pr_body,
            '--base', destination_branch,
            '--head', current_branch,
            '--assignee', '@me'
        ],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )

    print(result)

    # Output the result of the PR creation
    if result.returncode == 0:
        print("Pull request created successfully!")
    else:
        print(f"Error creating PR: {result.stderr}")


if __name__ == '__main__':
    main()
