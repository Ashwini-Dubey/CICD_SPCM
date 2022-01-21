**Documentation-cum-Guide for PGC DevOps Course Project**

**Objective: **
To create an Infrastructure on AWS with IAC(Terraform) , with configuration management using Ansible.
To create a CI/CD Pipeline using Jenkins , which can checkout the Node Application code from a private repository on Github , then build out an image using the Dockerfile and push that image to ECR.
To deploy the Node Application on a remote server by connecting the server with SSH and pulling the Docker Image from ECR.

**Concepts Covered:**
Continuous Integration
Continuous Delivery
System Provisioning
Configuration Management


Execution Steps:

Note : Ensure that the current directory is ~/PGC_DevOps_CICDSPCMProject/Scripts/ and sudo user has been set.

Step 1: Terraform Installation

Command : bash PR_Terraform_Installation.sh

Output : Terraform should be installed on the local system.

Step 2: AWS CLI Installation

Command : bash T1_ST1_AWSCLI_Installation.sh

Output : AWS CLI will be installed on the local system & users will be prompted to enter the AWS Access Key ID , Secret Access Key , Default Region & Default Output Format.

Note : Ensure that AWS CLI Configuration has been done correctly.

Step 3: AWS Key Generation (project_key.pem) file

Command : bash T1_ST4_Key_Generation.sh

Output : ‘project_key.pem’ file should be generated in the ~/PGC_DevOps_CICDSPCMProject/Scripts/  directory.

Step 4: Updating the absolute path for the ‘project_key.pem’ file.

Instructions : Manually update the absolute path of the pem file (ansible_ssh_private_key variable)in the code base , in the T2_ST1_Ansible_Inventory_Template.tmpl , this will ensure correct path of pem file to be added in the inventory file , which will be required to execute the Ansible Playbook files.

Step 5: Updating the absolute path for the Ansible Playbook file (.yaml)

Instructions: Manually update the absolute path of Ansible Playbook file in the ‘T2_Docker_Jenkins_Installation.sh’ . This will ensure that Ansible Playbooks are executed successfully.

Step 6: Initialization of Terraform Working Directory

Command : terraform init

Step 7: Provisioning of Resources with Terraform

Command : 
terraform plan (to check the changes which will be provisioned via Terraform.
												
	terraform apply (to provision the resources via Terraform)

Output : After the success of terraform apply command , resources will be provisioned on the AWS (VPC , S3 Bucket , Subnets , Instances , Route Tables, IGW/NAT-GW etc.) alongwith Ansible Installation on local system , AWS CLI Installation on Instances , creation of Ansible Hosts/Inventory file on local system.

Step 8 : Add AWS-Secret-Access-Key , AWS-Access-Key-ID & ECR-Docker Login command.

Instructions : Manually update the AWS Secret Access Key by replacing <AWS-Secret-Access-Key> & AWS Access Key ID by replacing the <AWS-Access-Key-ID>. Also , get the ECR-Docker Login Command (ECR has already been created with Terraform) from AWS Console & put it in the Line 18 of the codebase , in the file T2_ST4_Playbook_ECR_Authentication.yaml

Step 9 : Configuration Management using Ansible

Command : bash T2_Docker_Jenkins_Installation.sh

Output : This script will install Docker on the Jenkins & App host , Jenkins on the Jenkins host & will ensure that IAM roles are correctly assigned to Jenkins & App host with ECR Authentication.

Step 10 : Target Group & ALB Creation.

Instructions for Target Group Creation:

Login to the AWS Management Console & redirect to EC2.
Select Target Group & Click on ‘Create Target Group’.



Select the following configuration :
Target Type : Instances
Target Group Name : Jenkins-Host-TG
Protocol & Port : HTTP & 8080
VPC : Select the VPC created via Terraform (VPC Name : Course-Project-VPC)
Click Next
Select the ‘Jenkins’ Instance from the List of Available Instances & Click on ‘Include as pending below’ (Ensure that port is 8080).
Click on Target Group.
Repeat the above steps for ‘App-Host-TG’ creation and select ‘App’ instance from the Available Instances with port 8080.

Instructions for Load Balancer Creation:

Login to the AWS Management Console & redirect to EC2.
Select Load Balancer & Click on ‘Create Load Balancer’.
Select the ‘Application Load Balancer’ as Load Balancer Type.
Select the following configuration :
Load Balancer Name : Project-ALB
Scheme : Internet Facing
IP Address Type : IPv4
Network Mapping : ‘Course-Project-VPC’ & Public Subnets of both the AZs(us-east-1a & us-east-1b)
Security Groups : Default Security Group & Public Web SG (created via Terraform)
Listener & Routing : 
Protocol : HTTP
Port : 80
Target Group : ‘Jenkins-Host-TG’
Click on ‘Create Load Balancer’.

Step 11 : ALB Listener Rules Modification.

Instructions:
Navigate to ‘Listener’ of provisioned ALB.
Click on ‘View/edit rules’ for the Listener (HTTP:80)
Click on Add Icon on ‘Rules’ screen
Add the path-based routing 
/jenkins or /jenkins/* and forward it to ‘Jenkins-Host-TG’ 
/app or /app/* and forward it to ‘App-Host-TG’
Save the changes.



Step 12 : Configuring the Jenkins Host & App Host , to generate key-pair for Github/Jenkins Authentication & SSH tunneling to App Host.

Instructions :

SSH to the Bastion Host and then SSH to Jenkins Host.

Jenkins Host Terminal:

Run the following commands , uncomment the ‘StrictHostKeyChecking’ line & update its value from ‘ask’ to ‘no’ and save the changes.
Command : sudo nano /etc/ssh/ssh_config 
Execute the ‘sudo su jenkins’ command.
Execute ‘ssh-keygen’ command and tap enter until the key is generated.
Run the following command , copy the output of the command & keep it in a notepad. (This public key will be added to ‘App Host’ , so that for Jenkins Pipeline ‘Jenkins Host’ can SSH to ‘App Host’.)
Command: cat /var/lib/jenkins/.ssh/id_rsa.pub
Run the following command , copy the output of the command & keep it in a notepad. (This private key will be added to ‘Jenkins’ , so that ‘Jenkins’ can connect to GitHub , for checking out the Codebase from the Private Repo.)
Command: cat /var/lib/jenkins/.ssh/id_rsa
Run the following command and at the last line add ‘--prefix=/jenkins’ before the closing quotation in the ‘JENKINS_ARGS’ and save the changes.
sudo nano /etc/default/jenkins


App Host Terminal:

With the new terminal window, SSH to the Bastion Host and then to App Host.
Run the following command , paste the ‘public key’ copied in the ‘Step 5’ in a new line (if any already exists) and save the changes.
Command: sudo nano ~/.ssh/authorized_keys

Jenkins UI :

Get the initialAdminPassword.
Command : cat /var/lib/jenkins/secrets/initialAdminPassword
Install all the recommended plugins.
Once logged in , Navigate to ‘Manage Jenkins -> Manage Plugins’ and search for Docker & Docker pipeline plugin and install it.
Restart the Jenkins.
Once the Jenkins is restarted , Navigate to ‘Manage Jenkins -> Manage Credentials’ . Add the Credentials for the ‘Jenkins Server’ i.e., private key copied in Step 6.


GitHub Repository :

Login to the GitHub & Create a private repository.
Push the codebase , Jenkinsfile & Dockerfile to the GitHub Repository.
Add the AWS_ACCOUNT_ID in the Jenkinsfile.s
Go the GitHub Repositories Settings , click on ‘Deploy Keys’
Click on ‘Add deploy key’ , Enter the Title & Add the public key copied in the step 5.

Step 13 : Jenkins Job Setup :

Instructions:
Copy the ALB DNS and paste it in the browser and add ‘/jenkins’ or ‘/jenkins/*’ at the end.
Login to the Jenkins
Click on ‘New Item’
Enter the Item Name , Select the ‘Pipeline’ and Click OK.
Enter the Description
Under the Pipeline section :
Select the ‘Pipeline script from SCM’ option as the Definition
Select ‘Git’ as SCM
Enter the Git Repo’s SSH Clone URL in the Repository URL (Eg. git@github.com:Ashwini-Dubey/Course_Project.git)
In the Credentials , select the credentials created earlier while setting up the Jenkins.
In the ‘Branches to build’ option , enter the Branch in which the codebase + Jenkinsfile + Dockerfile is pushed.
In Script Path , enter the name of Jenkinsfile. Ignore , if Jenkinsfile name is unchanged.
Save the changes.
Click on Build Now , to run the build.





	



	


		










