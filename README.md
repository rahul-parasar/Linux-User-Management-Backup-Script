# 🛠️ Linux User Management & Backup Script

This Bash script provides a simple, menu-driven interface to manage users and groups on a Linux system, along with the ability to create backups of important directories.

## ✨ Features

- 👤 **Add a User** – Create a new system user with a home directory and prompt for a secure password.
- ❌ **Delete a User** – Remove a user along with their home directory.
- 🔑 **Reset Password** – Update or reset the password for an existing user.
- 📜 **List Users** – Display a list of all system user accounts.
- 👥 **Create Group & Add User** – Create a new group and assign a user to it.
- 💾 **Take Backup** – Archive and compress a specific directory into a timestamped ".tar.gz" file.

## 📦 Backup Details

- **Source Directory:** User-defined  
- **Target Directory:** User-defined  
- **Format:** " backup_YYYYMMDD_HHMMSS.tar.gz "

## ⚙️ Requirements

- Must be run with root/sudo privileges.
- Bash shell environment
- Tested on Ubuntu-based distributions.

## 🚀 How to Use

1. Make the script executable:
   chmod +x user_mgmt.sh

2. Run the script with sudo:
   sudo ./user_mgmt.sh

3. Follow the on-screen menu to perform actions.
