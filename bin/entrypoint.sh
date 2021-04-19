# References
# https://www.thegeekdiary.com/how-to-correctly-change-the-uid-and-gid-of-a-user-group-in-linux/
# https://askubuntu.com/questions/16700/how-can-i-change-my-own-user-id
# https://www.cyberciti.biz/faq/linux-change-user-group-uid-gid-for-all-owned-files/

#!/bin/bash
set -e

# If "-e uid={custom/local user id}" flag is not set for "docker run" command, use 9999 as default
CURRENT_UID=${uid:-9999}
CURRENT_GID=${gid:-9999}

# If "-e docker_user={custom/local user id}" flag is not set for "docker run" command, use docker_user as default
DOCKER_USER=${DOCKER_USER:-vscode}

# TODO: How to add user without passwords?
CONTAINER_PASSWORD=1234

# Create user called "docker" with selected UID
# useradd --shell /bin/bash -p $(openssl passwd -1 $CONTAINER_PASSWORD) -u $CURRENT_UID -o -c "" -m $DOCKER_USER
# groupmod -g $CURRENT_GID $USER_GID
usermod -u $CURRENT_UID -g $CURRENT_GID $DOCKER_USER

# Execute process
exec gosu $DOCKER_USER "$@"