#!/bin/bash

rsync -avz -e "ssh -p 221 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /home/sherlock/notes/ wangzhou@114.119.4.74:/home/wangzhou/backup/notes --delete

rsync -avz -e "ssh -p 221 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /home/sherlock/Documents/ wangzhou@114.119.4.74:/home/wangzhou/backup/Documents --delete

rsync -avz -e "ssh -p 221 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /home/sherlock/scripts/ wangzhou@114.119.4.74:/home/wangzhou/backup/scripts --delete

rsync -avz -e "ssh -p 221 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /home/sherlock/Mail/ wangzhou@114.119.4.74:/home/wangzhou/backup/Mail --delete

rsync -avz -e "ssh -p 221 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /home/sherlock/repos/kernel-pegas/ wangzhou@114.119.4.74:/home/wangzhou/repos/kernel-pegas --delete
