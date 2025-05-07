#!/bin/bash
# Script to help set up Cloud Monitoring across multiple projects

# Set variables (replace with your specific values)
PROJECT_1_ID="YOUR_PROJECT_1_ID"
PROJECT_2_ID="YOUR_PROJECT_2_ID"
MONITORING_PROJECT_ID="${PROJECT_2_ID}"  # Project where monitoring will be configured

# Print instructions for manual steps
echo "============================================="
echo "Cloud Monitoring Multi-Project Setup Helper"
echo "============================================="
echo
echo "This script will guide you through setting up Cloud Monitoring for multiple projects."
echo "Some steps require manual intervention in the Google Cloud Console."
echo

# Switch to the monitoring project
echo "Step 1: Switching to the monitoring project"
gcloud config set project ${MONITORING_PROJECT_ID}
echo "Current project set to: $(gcloud config get-value project)"
echo

# Create Monitoring Workspace
echo "Step 2: Creating a Monitoring Workspace"
echo "Please follow these manual steps in the Google Cloud Console:"
echo "  1. Navigate to: Navigation menu > Observability > Monitoring"
echo "  2. Wait for the Monitoring Overview page to load completely"
echo "  3. Go to Settings > Metric Scope"
echo "  4. Click '+Add projects'"
echo "  5. Select Project ID: ${PROJECT_1_ID}"
echo "  6. Click 'Add projects'"
echo
read -p "Press Enter when you've completed this step..." dummy
echo

# Create Monitoring Group
echo "Step 3: Creating a Monitoring Group"
echo "Please follow these manual steps in the Google Cloud Console:"
echo "  1. In Monitoring, click 'Groups' in the left menu"
echo "  2. Click '+Create group'"
echo "  3. Name your group 'DemoGroup'"
echo "  4. Set criteria:"
echo "     - Type: Name"
echo "     - Operator: Contains"
echo "     - Value: 'instance'"
echo "  5. Click 'Done', then 'Create'"
echo
read -p "Press Enter when you've completed this step..." dummy
echo

# Create Uptime Check
echo "Step 4: Creating an Uptime Check"
echo "Please follow these manual steps in the Google Cloud Console:"
echo "  1. In Monitoring, click 'Uptime checks' in the left menu"
echo "  2. Click '+Create uptime check'"
echo "  3. Configure with the following settings:"
echo "     - Protocol: TCP"
echo "     - Resource Type: Instance"
echo "     - Applies To: Group (select 'DemoGroup')"
echo "     - Port: 22"
echo "     - Check frequency: 1 minute"
echo "  4. Enable 'Create an alert' option"
echo "  5. Name it 'DemoGroup uptime check'"
echo "  6. Click 'Test' to verify connectivity"
echo "  7. Click 'Create'"
echo
read -p "Press Enter when you've completed this step..." dummy
echo

# Create Alert Policy
echo "Step 5: Creating an Alert Policy"
echo "Please follow these manual steps in the Google Cloud Console:"
echo "  1. In Monitoring, click 'Uptime checks' in the left menu"
echo "  2. Find your 'DemoGroup uptime check'"
echo "  3. Click the three dots menu at the end of the row"
echo "  4. Select 'Add alert policy'"
echo "  5. Click '+Add alert condition'"
echo "  6. Delete any pre-selected conditions"
echo "  7. Create new condition:"
echo "     - Search for 'check_passed' metric"
echo "     - Select 'VM Instance > Uptime_check > Check passed'"
echo "     - Add filter: check_id = demogroup-uptime-check-id"
echo "  8. Configure trigger with 'Metric absence' as condition type"
echo "  9. Name the policy 'Uptime Check Policy'"
echo "  10. Create the policy"
echo
read -p "Press Enter when you've completed this step..." dummy
echo

# Create Custom Dashboard
echo "Step 6: Creating a Custom Dashboard"
echo "Please follow these manual steps in the Google Cloud Console:"
echo "  1. In Monitoring, click 'Dashboards' in the left menu"
echo "  2. Click '+Create dashboard'"
echo "  3. Name your dashboard"
echo "  4. Click '+Add Widget' and select 'Line'"
echo "  5. Configure metric:"
echo "     - Search for 'uptime' (compute.googleapis.com/instance/uptime)"
echo "     - Select 'VM Instance > Instance > Uptime'"
echo "  6. Click 'Apply'"
echo
read -p "Press Enter when you've completed this step..." dummy
echo

echo "============================================="
echo "Setup guidance complete!"
echo "You can now test your monitoring by stopping and starting VMs to trigger alerts."
echo "Remember to clean up alert policies when you're done to avoid unwanted notifications."
echo "============================================="
