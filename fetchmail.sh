#!/bin/bash

# just run fetchmail
# 

echo
fetchmail

while [[ $? != 0 ]]
do
	fetchmail
done

echo
echo "============================="
echo "= fetch new mails finished! ="
echo "============================="
echo
