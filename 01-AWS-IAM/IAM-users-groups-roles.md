# IAM Users, Groups, and Roles

## Why I wrote this
Access in AWS comes from humans and services. Understanding the difference avoids major security mistakes.

## Core idea in 5 lines
- Users represent people
- Groups manage permissions for users
- Roles provide temporary access
- Services always use roles
- Roles are safer than access keys

## How AWS actually works here
- Users can have passwords or access keys
- Groups only attach policies
- Roles are assumed, not logged into

## When I should use this
- User → human login
- Group → permission management
- Role → EC2, Lambda, cross-account access

## Common mistakes I must avoid
- Using users for EC2 or Lambda
- Assigning permissions directly to users
- Creating duplicate policies
  

## Main points
- Roles have no permanent credentials
- Roles are preferred over access keys
