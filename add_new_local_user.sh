#!/bin/bash
#
# This script creates a new user on the local system
# You must supply a username as an argument to the script
# Any argument after the username argument will be count as a comment
# A password will be generated for the account
# The username, password and host of the account will be displayed at the end

# Check if script is executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then 
	echo 'Access denied. You need to be admin to use this script'
	exit 1
else
	echo 'Access Granted'
fi

#  If the user doesn't supply at least one argument, then give them help
if [[ "${#}" -lt 1 ]]
then
	echo 'Please type the username you want to use for this script'
	echo "Example: ${0} USERNAME [COMMENT]..."
	exit 1
fi

# The first parameter is the user name
USER_NAME="${1}"

# The rest of the parameters are for the account comments
shift
COMMENT="${@}" 

# Generate a password
SP_CHARACTER=$(echo '!@#$%^&*()_+-=' | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c10)
PASSWORD_ENHANCED=$(echo "${PASSWORD}${SP_CHARACTER}" | fold -w1 | shuf | tr -d '\n' )
#echo "${PASSWORD_ENHANCED}"

# Create the user with the password
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded
if [[ "${?}" -ne 0 ]]
then 
	echo 'The account could not be created'
	exit 1
fi

# Set the password
echo ${PASSWORD_ENHANCED} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded
if [[ "${?}" -ne 0 ]]
then
	echo 'The password for the account could not be created'
	exit 1
fi

# Force password change on first login
passwd -e ${USER_NAME}

# Display the username, password and the host where the user was created
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD_ENHANCED}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0



