Usage:

bash ./user_mgmt.sh <purpose> <username> <ar2> <arg...>

purpose types:
    create -> ./user_mgmt.sh create <username> <optional: password> <optional: homedirectory> <optional: shell directory>
        creates a new user. arg2 is the password, arg3 is the home directory, arg4 is the shell directory.

    delete -> ./user_mgmt.sh delete <username> <optional: delete dir>
        deletes the specified user. arg2 is a check whether the user wants to delete the home directory and mail spool. accepts value 'true.'
    info -> ./user_mgmt.sh info <username>
        gives information on the specified user.
