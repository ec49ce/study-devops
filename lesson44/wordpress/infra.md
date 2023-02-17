# Wordpress
1. VPC (AZ все в регионе)
- subnets: public и private в каждом AZ
- IGW для public
- NGW для private
2. bastion
3. Services:
- RDS mysql для wordpress
- EFS для wordpress
4. AMI
- back (packer)
- front (packer)
5. Launch-Template
- back
- front
6. ALB
- back
- front
7. ASG
- back
- front
