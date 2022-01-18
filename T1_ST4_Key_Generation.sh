##################################################################################################
# Script to generate key-pair 'project_key.pem' for SSH Authentication across all the Instances. #
##################################################################################################
#!/bin/sh
aws ec2 create-key-pair \
    --key-name project_key \
    --key-type rsa \
    --query "KeyMaterial" \
    --output text > project_key.pem
chmod 400 project_key.pem
