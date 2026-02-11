#!/bin/bash

apt update -y
apt install -y apache2

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <style>
    body {
      font-family: Arial;
      background-color: #f4f4f4;
      text-align: center;
    }
    h1 {
      animation: colorChange 2s infinite;
    }
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Application deployed using Infrastructure as Code</p>
</body>
</html>
EOF

systemctl start apache2
systemctl enable apache2
