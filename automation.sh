# !/bin/bash


#To give the variable name to the bucket and user name  so we can use the variable name while giving bucket details.

s3_bucket="upgrad-sarankumar"
name="sarankumar"


#To Perform an update of the package details  

sudo apt update -y

#To check the apache2 is installed or not

dpkg -s apache2

#To install apache2

if [$? -eq 0]
then 
	echo "apache2 is server is already installed."
else
	echo "Installing apache2"
	sudo apt install apache2 -y
fi

#To Ensure that the apache2 service is running. 

ps -ef|grep apache2

#To Ensure that the apache2 service is enabled.

sudo systemctl is-enabled apache2

if [$? -eq 0]
then 
	echo "apache2 is enabled"
else 
	echo "Enabling "
	sudo service apache2 enable
fi


#To install aws cli 

sudo apt install awscli

#To copy the archive to the s3 bucket

aws s3 \
cp /tmp/sarankumar-httpd-logs-01212021-101010.tar \
s3://upgrad-sarankumar/sarankumar-httpd-logs-01212021-101010.tar

#Update inventory file with archive:

echo "To create inventory file "

psize=$(ls -lh /tmp/sarankumar-httpd-logs-01212021-101010.tar  | awk '{ print $5}')
$psize  >> /Automation_Project/inventory.html


#creating a cron job

printf "0 0 * * * rooot /root/Automation_Project/automation.sh\n" > /etc/cron.d/automation
