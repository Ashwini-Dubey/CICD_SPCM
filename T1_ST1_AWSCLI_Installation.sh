####################################################################################
#Subtask 1 : Installation of AWS Command Line Interface on the local Linux machine.#
####################################################################################

echo "Checking the AWS CLI Installation Status"
if [ ! -e /usr/local/bin/aws ]
then
    echo "AWS CLI Setup not found! Installation in progress..."
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        apt-get install unzip
        unzip awscliv2.zip
        sudo ./aws/install
    echo "AWS CLI Installation Completed!"
else
        echo "AWS CLI setup alredy exists"
fi
echo "To configure AWS CLI ,provide your AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY"
aws configure