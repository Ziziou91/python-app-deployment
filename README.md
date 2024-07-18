# DevOps Project 4 Brief – Use Python to Create 2-Tier Deployment

## Description

Python app to deploy a virtualised application using on either an AWS or Azure cloud platform.


[Trello board](https://trello.com/invite/b/66979dd34ef978b944fec84f/ATTI3d27e0656fd0ed093fe31c8a9c4fc8d1F306E3CD/devops-project-4-brief-use-python-to-create-2-tier-deployment)

## Project components

### main.py

Lightweight server made with flask. Listens to requests from github repo and Jenkins server. When it recives one of these requests it validates and then launches next stage in pipeline.

Hosted on an Azure virtual machine. I wanted to use an Azure function for this, but company policy didn't allow.

### Azure architecture



## Instructions

### Launching the virtual network
Azure gives us the option of creating a virtual network to let our virtual machines securely communicate with each other. We're going to start by creating a virtual network.

1) Open the resource group the SSH key is stored in to create a new virtual network.
2) Choose an appropiate name for the virtual network and make sure it's being deployed in the same region we're going to deploy our virtual machines in.
3) Address space: if it isn't already populated the fields with it then add 10.0.0.0/16
4) Just below this create our two subnets:
   1)  public-subnet, Address range: 10.0.2.0/24
   2)  private-subnet, Address range: 10.0.3.0/24
5) Review and create


### Launching the virtual machine
If required, creaet a public SSH to use with any virtual machines we are using.

1) Open the resource group the SSH key is stored in to create a new virtual network.
2) Choose an appropiate name for the virtual network and make sure it's being deployed in the same region we're going to deploy our virtual machines in.
```
tech258-joshg-webhook-listener-app

```
3) Set security to standard and choose the desired VM image - this example uses Ubuntu 22.04 Pro - Gen 2
   ![virtual machine security and image details](./images/azure_security_image.png)
4) Set size to B1S before pressing scrolling down for more options
   ![virtual machine size](./images/azure_size.png)
5) Username. Change this to `adminuser`
   
6) SSH key. Use the key discussed at the top of this README
7) Disk. Change type to standard SSD
   ![virtual machine disk](./images/azure_disk.png)
8) Networking. Choose the virtual network we created a moment ago and make sure the following ports are open to incoming connections:
     - port 22 open for ssh. This will allow us to config the server
     - port 80 open for http.
     - port 5000 for flask.
9)  Review settings and then launch the instance
    ![virtual machine overview](./images/azure_vm_overview.png)


### Installing main.py on the virtual machine
1) Run updates and upgrade.
    `sudo apt-get update && sudo apt-get upgrade`
2) Check python is installed with `python3 --version`
3) Check if flask module is installed with `python3 -m flask --version`
4) Install pip `sudo apt install python3-pip -y`
5) Check it's installed correctly with `pip --version`
6) Install flask `pip install Flask`
7) Add python file to the virtual machine. 
8) Launch the web server with `python main.py`


### Add webhook to the Github repo and test.
1) Go to the github repo > settings > webhook
2) Under `payload URL` add the VM ip address, flask port and webhook route. It should look something like:
```
0.0.0.0:5000/webhook
```
3) Test by sening a post request. If everything is working property the server should respond with a 200 response.




The Python scipt/app should:
1.	Listen so it can receive webhook notification when there is code change on dev branch, then
2.	Trigger the Jenkins pipeline, which should do CI part of CICD. If CI passes, then the Python script will continue to do CD part
3.	Control the CD part of CICD
a.	Use Terraform to create the 2-tier deployment architecture
b.	Use Ansible to configure each instance
4.	Test to make sure the deployment was successful and send an email notification

(Optional) Terraform State files can be placed in AWS S3 or Azure blob storage. Terraform could be configured to reference them there rather than store them locally.

## Project Components:
•	Terraform Scripts to create: 
o	Virtual Network or VPC
o	Security groups 
o	Separate virtual machines for the app and database
•	Ansible playbooks to configure the app and database virtual machines
•	Python integration with cloud services for seamless deployment and management
•	GitHub repo containing everything needed for the above, and a README File with
o	Detailed setup instructions
o	User guide 
o	Diagrams showing your architecture and pipelines
o	Contribution guidelines for future developers
o	Blockers – Suggestion: what was the issue, reason for the issue, solution
o	What you learnt
o	Benefits you saw personally from the project
•	Project Management: Maintain a project board (e.g., Trello, Jira or GitHub Project) to manage tasks

python -m flask --version



























## Unable to create

### Azure function

Serverless Function App to run main.py

### Creating an Azure Function App

1) From the Azure portal menu or the Home page, select Create a resource.
2) In the New page, select Compute > Function App.
3) Under Select a hosting option, select Consumption to create your app in the default Consumption plan. 
    As this option is serverless I only pay for the time the function is running.
4) Ensure the function app is in the right Subscription and Resource Group
5) Instance details should be the following

**Create Function App** launches 3 resources
- App secrive plan
- Function App
- Storage Account



https://learn.microsoft.com/en-us/azure/azure-functions/functions-create-function-app-portal?pivots=programming-language-csharp
http://127.0.0.1:5000/webhook