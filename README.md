# DevOps Project 4 Brief – Use Python to Create 2-Tier Deployment

## Description

Python app to deploy a virtualised application using on either an AWS or Azure cloud platform.

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