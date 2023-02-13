#!/bin/bash

echo "Starting init script for Ubuntu"
echo "${public_key}" >> ~/.ssh/authorized_keys
echo "${public_key}" >> /home//ec2-user/.ssh/authorized_keys
