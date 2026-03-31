# Scripts

This directory contains utility scripts for managing the IBM BAMOE project.

---

## `generate-new-version-readme.sh`

### Overview

A bash script that automates the versioning of README files across the project. It manages the transition from one version to another by archiving the current version and creating updated documentation for the new version.

### Purpose

When releasing a new version of IBM BAMOE, this script ensures that:
- Historical documentation is preserved by creating versioned README files
- The latest documentation is updated with the new version number
- All component directories maintain consistent version documentation
- The process is automated and error-free across multiple directories

**Use this script when:** You're preparing a new release and need to update version numbers across all README files in the project.

---

### Usage

```bash
./scripts/generate-new-version-readme.sh <base-version> <new-version>
```

#### Arguments

| Argument | Description | Example |
|----------|-------------|---------|
| `base-version` | The current version number in README-latest.md files | `9.3.1-ibm-0006` |
| `new-version` | The new version number to update to | `9.4.0-ibm-0008` |

Both arguments are **required** and cannot be empty.

---

### Behavior

The script performs the following operations:

1. **Validation**
   - Checks that exactly 2 arguments are provided
   - Verifies that neither argument is empty
   - Exits with an error if validation fails

2. **Directory Discovery**
   - Searches the entire project for directories named `readmes`
   - Exits if no `readmes` directories are found

3. **Processing Each Directory**
   
   For each `readmes` directory found, the script:
   
   - **Skips DEPRECATED directories**: Any path containing "DEPRECATED" is ignored
   
   - **Checks for README-latest.md**: Skips directories without this file
   
   - **Reads the header**: Extracts the first line to check version information
   
   - **Applies version logic**:
     - If the header already contains `new-version`: **Skips** (already updated)
     - If the header doesn't contain `base-version`: **Skips** (not applicable)
     - If the header contains `base-version`: **Processes** the file
   
   - **When processing**:
     1. Renames `README-latest.md` to `README-<base-version>.md` (archives current version)
     2. Creates a new `README-latest.md` by copying the archived file
     3. Updates all occurrences of `base-version` with `new-version` in the new latest file
     4. Skips if `README-<base-version>.md` already exists

4. **Output**
   - Provides detailed logging of all operations
   - Reports skipped directories with reasons
   - Confirms successful renames, copies, and updates

---

### Notes and Warnings

#### ⚠️ Important Considerations

- **Run from project root**: The script uses relative paths and should be executed from the project root directory
- **Version format**: Ensure version strings match exactly what appears in the README headers
- **Case sensitivity**: Version matching is case-sensitive
- **Global replacement**: The script replaces ALL occurrences of the base version in the file, not just the header

