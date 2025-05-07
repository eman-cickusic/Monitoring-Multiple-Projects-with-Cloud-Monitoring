#!/bin/bash
# Script to create a VM instance in Project 2

# Set variables (replace with your specific values)
PROJECT_ID="YOUR_PROJECT_2_ID"
INSTANCE_NAME="instance2"
REGION="us-central1"
ZONE="us-central1-a"
MACHINE_TYPE="e2-medium"

# Ensure we're using the correct project
gcloud config set project ${PROJECT_ID}

# Create the VM instance
echo "Creating VM instance '${INSTANCE_NAME}' in project '${PROJECT_ID}'..."
gcloud compute instances create ${INSTANCE_NAME} \
    --project=${PROJECT_ID} \
    --zone=${ZONE} \
    --machine-type=${MACHINE_TYPE} \
    --network-interface=network-tier=PREMIUM,subnet=default \
    --metadata=enable-oslogin=true \
    --create-disk=auto-delete=yes,boot=yes,device-name=${INSTANCE_NAME},image=projects/debian-cloud/global/images/debian-11-bullseye-v20230206,mode=rw,size=10,type=pd-balanced

echo "VM creation completed!"
echo "You can now proceed with setting up Cloud Monitoring."
