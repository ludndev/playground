# Release Notes

## [Version Number] - YYYY-MM-DD

### Commits

<% commits.each do |commit| %>
- **Commit:** [`<%= commit.sha %>`](<%= repository_url %>/commit/<%= commit.sha %>)
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

