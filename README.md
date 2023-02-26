# Deploy webapp application with Ansible and terraform

To deploy the application: 
- Configure AWS account : ```aws configure```
- Add ssh key pair named 'ansible' on your AWS account (us-east-1) and copy your ansible.pem file in ```ansible/``` folder
- Install terraform
- Initialize and apply terraform script in ```terraform/``` folder : ```terraform init & terraform apply``` 
- SSH into the ansible controller VM (public ip of the controller into 'controller_public_ip' output : ```terraform output```) : ```ssh ubuntu@<Your-IP> -i ansible/ansible.pem```
- Into webapp folder : ```ansible-playbook playbook.yml -i inventory```
- Your application is successfully installed ! 
