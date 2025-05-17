#!/bin/bash

# Function to add a user
add_user(){
    echo "ADDING A NEW USER"
    read -p "Enter the username you want to add: " USERNAME

    if [ -z "$USERNAME" ]; then
        echo "Username cannot be empty. Aborting..."
        return 1
    fi

    if id "$USERNAME" &>/dev/null; then
        echo "User '$USERNAME' already exists. Aborting..."
        return 1
    fi

    sudo useradd -m "$USERNAME" && sudo passwd "$USERNAME"
    echo "User '$USERNAME' has been added."
}

# Function to delete a user
delete_user(){
    echo "DELETING A USER"
    read -p "Enter the username you want to delete: " USERNAME

    if [ -z "$USERNAME" ]; then
        echo "Username cannot be empty. Aborting..."
        return 1
    fi

    if ! id "$USERNAME" &>/dev/null; then
        echo "User '$USERNAME' does not exist. Aborting..."
        return 1
    fi

    sudo userdel -r "$USERNAME"
    echo "User '$USERNAME' has been deleted."
}

# Function to reset a user's password
reset_password(){
    echo "RESET USER PASSWORD"
    read -p "Enter the username whose password you want to reset: " USERNAME

    if [ -z "$USERNAME" ]; then
        echo "Username cannot be empty. Aborting..."
        return 1
    fi

    if ! id "$USERNAME" &>/dev/null; then
        echo "User '$USERNAME' does not exist. Aborting..."
        return 1
    fi

    sudo passwd "$USERNAME"
    echo "Password reset for user '$USERNAME'."
}

# Function to list all users
list_users(){
    echo "LISTING USERS ON THE SYSTEM"
    echo "----------------------------"
    awk -F: '{ print $1 }' /etc/passwd
}

# Function to create a group and add a user
create_group(){
    echo "CREATE GROUP AND ADD USER"
    read -p "Enter the name of the group you want to create: " GROUPNAME

    if [ -z "$GROUPNAME" ]; then
        echo "Group name cannot be empty. Aborting..."
        return 1
    fi

    if getent group "$GROUPNAME" > /dev/null; then
        echo "Group '$GROUPNAME' already exists. Skipping creation."
    else
        sudo groupadd "$GROUPNAME"
        echo "Group '$GROUPNAME' has been created."
    fi

    read -p "Enter the username you want to add to the group: " USERNAME

    if ! id "$USERNAME" &>/dev/null; then
        echo "User '$USERNAME' does not exist. Aborting..."
        return 1
    fi

    sudo usermod -aG "$GROUPNAME" "$USERNAME"
    echo "User '$USERNAME' has been added to group '$GROUPNAME'."
}

# Function to take a backup of a directory
backup(){
    echo "TAKE A BACKUP"

    read -p "Enter source directory to back up: " src_dir
    read -p "Enter destination directory for backup: " tgt_dir

    if [ ! -d "$src_dir" ]; then
        echo "Source directory does not exist. Aborting..."
        return 1
    fi

    mkdir -p "$tgt_dir"

    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILENAME="backup_${TIMESTAMP}.tar.gz"

    tar -czvf "${tgt_dir}/${BACKUP_FILENAME}" "$src_dir" &&     echo "Backup created successfully: ${tgt_dir}/${BACKUP_FILENAME}"
}

# Main menu loop
while true; do
    echo
    echo "USER MANAGEMENT MENU"
    echo "-----------------------"
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. Reset User Password"
    echo "4. List Users"
    echo "5. Create Group and Add User"
    echo "6. Take a Backup"
    echo "7. Exit"
    read -p "Enter your choice [1-7]: " OPTION

    case "$OPTION" in
        1) add_user ;;
        2) delete_user ;;
        3) reset_password ;;
        4) list_users ;;
        5) create_group ;;
        6) backup ;;
        7) echo "Exiting. Goodbye!"; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done

