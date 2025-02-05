#!/bin/bash

sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Hello World</h1> <br> <h2> You successfully deployed your first EC2 instance using Terraform</h2>" | sudo tee /var/www/html/index.html
sudo systemctl restart httpd