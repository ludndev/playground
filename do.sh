#!/bin/bash

# Set variables
GITHUB_DIR=".github"
PR_TEMPLATE_DIR="${GITHUB_DIR}/PULL_REQUEST_TEMPLATE"
RELEASES_FILE="RELEASES.md"

# Create .github directory
mkdir -p "${PR_TEMPLATE_DIR}"

# Create single pull request template file
cat <<EOL > "${GITHUB_DIR}/PULL_REQUEST_TEMPLATE.md"
## Description

Please include a summary of the change and which issue is fixed. Please also include relevant motivation and context.

Fixes # (issue)

## Type of change

Please delete options that are not relevant.

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] This change requires a documentation update

## Commit Details

<% commits.each do |commit| %>
- **Commit:** [\`<%= commit.sha %>\`](<%= repository_url %>/commit/<%= commit.sha %>)
  - **Message:** <%= commit.message %>
  <% if commit.body %>
  - **Details:** <%= commit.body %>
  <% end %>
  
  <% if commit.issues_references.any? %>
  - **Issues Referenced:**
    <% commit.issues_references.each do |issue| %>
    - [#<%= issue.number %>](<%= repository_url %>/issues/<%= issue.number %>) - <%= issue.title %>
    <% end %>
  <% end %>
  
  <% if commit.pr_references.any? %>
  - **Pull Requests Referenced:**
    <% commit.pr_references.each do |pr| %>
    - [#<%= pr.number %>](<%= repository_url %>/pull/<%= pr.number %>) - <%= pr.title %>
    <% end %>
  <% end %>
<% end %>

## How Has This Been Tested?

Please describe the tests that you ran to verify your changes. Provide instructions so we can reproduce. Please also list any relevant details for your test configuration.

- [ ] Test A
- [ ] Test B

**Test Configuration**:
* Firmware version:
* Hardware:
* Toolchain:
* SDK:

## Checklist:

- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] Any dependent changes have been merged and published in downstream modules
EOL

# Create separate feature pull request template file
cat <<EOL > "${PR_TEMPLATE_DIR}/feature.md"
## Description

Please include a summary of the change and which issue is fixed. Please also include relevant motivation and context.

Fixes # (issue)

## Type of change

Please delete options that are not relevant.

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] This change requires a documentation update

## Commit Details

<% commits.each do |commit| %>
- **Commit:** [\`<%= commit.sha %>\`](<%= repository_url %>/commit/<%= commit.sha %>)
  - **Message:** <%= commit.message %>
  <% if commit.body %>
  - **Details:** <%= commit.body %>
  <% end %>
  
  <% if commit.issues_references.any? %>
  - **Issues Referenced:**
    <% commit.issues_references.each do |issue| %>
    - [#<%= issue.number %>](<%= repository_url %>/issues/<%= issue.number %>) - <%= issue.title %>
    <% end %>
  <% end %>
  
  <% if commit.pr_references.any? %>
  - **Pull Requests Referenced:**
    <% commit.pr_references.each do |pr| %>
    - [#<%= pr.number %>](<%= repository_url %>/pull/<%= pr.number %>) - <%= pr.title %>
    <% end %>
  <% end %>
<% end %>

## How Has This Been Tested?

Please describe the tests that you ran to verify your changes. Provide instructions so we can reproduce. Please also list any relevant details for your test configuration.

- [ ] Test A
- [ ] Test B

**Test Configuration**:
* Firmware version:
* Hardware:
* Toolchain:
* SDK:

## Checklist:

- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] Any dependent changes have been merged and published in downstream modules
EOL

# Create separate bug fix pull request template file
cat <<EOL > "${PR_TEMPLATE_DIR}/bug_fix.md"
## Description

Please include a summary of the change and which issue is fixed. Please also include relevant motivation and context.

Fixes # (issue)

## Type of change

Please delete options that are not relevant.

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] This change requires a documentation update

## Commit Details

<% commits.each do |commit| %>
- **Commit:** [\`<%= commit.sha %>\`](<%= repository_url %>/commit/<%= commit.sha %>)
  - **Message:** <%= commit.message %>
  <% if commit.body %>
  - **Details:** <%= commit.body %>
  <% end %>
  
  <% if commit.issues_references.any? %>
  - **Issues Referenced:**
    <% commit.issues_references.each do |issue| %>
    - [#<%= issue.number %>](<%= repository_url %>/issues/<%= issue.number %>) - <%= issue.title %>
    <% end %>
  <% end %>
  
  <% if commit.pr_references.any? %>
  - **Pull Requests Referenced:**
    <% commit.pr_references.each do |pr| %>
    - [#<%= pr.number %>](<%= repository_url %>/pull/<%= pr.number %>) - <%= pr.title %>
    <% end %>
  <% end %>
<% end %>

## How Has This Been Tested?

Please describe the tests that you ran to verify your changes. Provide instructions so we can reproduce. Please also list any relevant details for your test configuration.

- [ ] Test A
- [ ] Test B

**Test Configuration**:
* Firmware version:
* Hardware:
* Toolchain:
* SDK:

## Checklist:

- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] Any dependent changes have been merged and published in downstream modules
EOL

# Create release notes file
cat <<EOL > "${RELEASES_FILE}"
# Release Notes

## [Version Number] - YYYY-MM-DD

### Commits

<% commits.each do |commit| %>
- **Commit:** [\`<%= commit.sha %>\`](<%= repository_url %>/commit/<%= commit.sha %>)
  - **Message:** <%= commit.message %>
  <% if commit.body %>
  - **Details:** <%= commit.body %>
  <% end %>
  
  <% if commit.issues_references.any? %>
  - **Issues Referenced:**
    <% commit.issues_references.each do |issue| %>
    - [#<%= issue.number %>](<%= repository_url %>/issues/<%= issue.number %>) - <%= issue.title %>
    <% end %>
  <% end %>
  
  <% if commit.pr_references.any? %>
  - **Pull Requests Referenced:**
    <% commit.pr_references.each do |pr| %>
    - [#<%= pr.number %>](<%= repository_url %>/pull/<%= pr.number %>) - <%= pr.title %>
    <% end %>
  <% end %>
<% end %>

### Summary of Changes

- **Added:**
  - [Feature] - Brief description of the new feature.
  - [Feature] - Brief description of another new feature.

- **Changed:**
  - [Change] - Brief description of the change.
  - [Change] - Brief description of another change.

- **Fixed:**
  - [Bug] - Brief description of the bug fix.
  - [Bug] - Brief description of another bug fix.

- **Deprecated:**
  - [Deprecation] - Brief description of the deprecated feature.

- **Removed:**
  - [Removal] - Brief description of the removed feature.

- **Security:**
  - [Security] - Brief description of the security update.

EOL

echo "Templates and release notes file created successfully."

