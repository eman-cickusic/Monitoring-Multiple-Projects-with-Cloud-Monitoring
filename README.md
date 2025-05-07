# Monitoring Multiple Projects with Cloud Monitoring

## Overview
This repository demonstrates how to monitor multiple Google Cloud projects using Cloud Monitoring. The walkthrough shows how to set up a centralized monitoring dashboard that provides visibility across different projects, create uptime checks, configure alerting policies, and build custom dashboards.

## Project Goals
- Create a Cloud Monitoring account spanning multiple Google Cloud projects
- Set up cross-project monitoring from a single monitoring interface
- Configure uptime checks for resource groups
- Implement alerting policies for service availability
- Build custom dashboards for visualizing critical metrics

## Video

https://youtu.be/x7lOZQzi9co

## Prerequisites
- Google Cloud Platform account with billing enabled
- At least two Google Cloud projects
- Basic understanding of Google Cloud resources and services

## Implementation Steps

### 1. Project Setup
- Configure two Google Cloud projects
- Create VM instances in each project (one per project)

### 2. Cloud Monitoring Configuration
- Create a Monitoring Metrics Scope
- Add both projects to the metrics scope

### 3. Resource Grouping
- Create a monitoring group "DemoGroup" based on instance name pattern
- Configure dynamic membership criteria to include all instances with "instance" in their name

### 4. Uptime Monitoring
- Create TCP-based uptime check for the instance group
- Configure check to run every minute on port 22
- Setup automatic alerting for uptime issues

### 5. Alert Policy Configuration
- Create alert policy based on uptime check results
- Configure metric absence condition to detect when checks fail
- Set appropriate notification channels (optional)

### 6. Custom Dashboard
- Design custom dashboard to visualize VM instance metrics
- Add line charts to track instance uptime
- Configure dashboard for monitoring both projects simultaneously

## File Structure
```
.
├── README.md
├── scripts/
│   ├── create_vm.sh
│   └── setup_monitoring.sh
├── configs/
│   ├── uptime_check.json
│   ├── alert_policy.json
│   └── dashboard.json
└── docs/
    ├── screenshots.md
    └── troubleshooting.md
```

## Usage

### Setting Up VMs
Run the script to create a VM in your second project:
```bash
./scripts/create_vm.sh
```

### Configuring Monitoring
Follow these steps to set up monitoring:
```bash
./scripts/setup_monitoring.sh
```

Alternatively, follow the step-by-step instructions in the detailed walkthrough section below.

## Detailed Walkthrough

### Creating Project 2's Virtual Machine
1. Switch to Project 2 using the project dropdown menu
2. Navigate to Compute Engine > VM instances
3. Click "Create Instance"
4. Configure the VM with:
   - Name: instance2
   - Region: [YOUR_REGION]
   - Zone: [YOUR_ZONE]
5. Click "Create"

### Creating a Monitoring Metrics Scope
1. Navigate to Monitoring via the sidebar (Navigation menu > Observability > Monitoring)
2. Once in Monitoring, go to Settings > Metric Scope
3. Click "+Add projects"
4. Select Project 1 and add it to your metrics scope

### Creating a Cloud Monitoring Group
1. In Monitoring, click "Groups" from the sidebar
2. Click "+Create group"
3. Name the group "DemoGroup"
4. Configure the criteria:
   - Type: Name
   - Operator: Contains
   - Value: "instance"
5. Click "Done", then "Create"

### Creating an Uptime Check
1. In Monitoring, click "Uptime checks"
2. Click "+Create uptime check"
3. Configure the check:
   - Protocol: TCP
   - Resource Type: Instance
   - Applies To: Group (select "DemoGroup")
   - Port: 22
   - Check frequency: 1 minute
4. Enable the "Create an alert" option
5. Name the check "DemoGroup uptime check"
6. Test the connection and click "Create"

### Configuring an Alert Policy
1. Go to "Uptime checks"
2. Click the three dots menu for your uptime check and select "Add alert policy"
3. Click "+Add alert condition"
4. Delete any pre-selected conditions
5. Create a new condition:
   - Search for "check_passed" metric
   - Select "VM Instance > Uptime_check > Check passed"
   - Add a filter for check_id = demogroup-uptime-check-id
6. Configure the trigger using "Metric absence" as the condition type
7. Name the policy "Uptime Check Policy"
8. Create the policy

### Building a Custom Dashboard
1. Navigate to "Dashboards"
2. Click "+Create Custom dashboard"
3. Name your dashboard
4. Add a line chart widget
5. Configure it to display the "compute.googleapis.com/instance/uptime" metric

### Testing the Setup
1. Stop one of your VM instances
2. Wait for the alert to trigger
3. Restart the VM and observe the incident resolution

## Troubleshooting
- If the metric `demogroup-uptime-check-id` isn't immediately available, wait a few minutes for it to appear
- Ensure both projects are properly added to the metrics scope
- Check that your VM instances are correctly tagged for inclusion in the monitoring group

## Cleaning Up
To avoid continued alerts after completion:
1. Navigate to Alerting
2. Find and delete any created alert policies

## License
This project is licensed under the MIT License - see the LICENSE file for details.
