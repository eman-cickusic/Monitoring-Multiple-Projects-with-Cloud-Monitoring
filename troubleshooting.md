# Troubleshooting Guide

This document provides solutions to common issues that might arise when setting up multi-project monitoring in Google Cloud.

## Common Issues and Solutions

### Project Access Issues

**Problem**: Unable to add a project to the metrics scope.

**Solution**:
1. Ensure you have the `Monitoring Admin` role in both projects
2. Verify that the Monitoring API is enabled in both projects
3. If using service accounts, ensure they have proper permissions

### VM Instance Not Appearing in Group

**Problem**: VM instances don't show up in the "DemoGroup" even though they have "instance" in their name.

**Solution**:
1. Verify the instance name contains "instance" (case sensitive)
2. Check if the group creation has completed processing (may take a few minutes)
3. Refresh the Cloud Monitoring console
4. Verify that both projects are successfully added to the metrics scope

### Uptime Check Failures

**Problem**: Uptime checks are failing even though VMs are running.

**Solution**:
1. Verify that port 22 (SSH) is open on the VM's firewall rules
2. Check if the VM is actually running and not in a terminated or stopping state
3. Ensure the VM has a public IP address if you're using default uptime check configurations
4. Try increasing the timeout value for the uptime check

### Missing Metrics in Dashboard

**Problem**: Some metrics aren't showing up in the custom dashboard.

**Solution**:
1. Verify that the VM instances have been running long enough to generate metrics
2. Check that the time range in the dashboard is appropriate
3. Ensure the metrics scope includes all relevant projects
4. Verify that the metric names are correct (they are case-sensitive)
5. Some metrics may have a delay before appearing in Cloud Monitoring

### Alert Policy Not Triggering

**Problem**: Alert policy isn't triggering when a VM is stopped.

**Solution**:
1. Verify the alert policy configuration is correctly set up
2. Check that the metric absence duration is appropriate (e.g., 300s might be too long for testing)
3. Ensure that notification channels are properly configured
4. Check for any errors in the alerting policy status

### "Check_id" Not Available

**Problem**: The specific `demogroup-uptime-check-id` isn't available when setting up the alert policy.

**Solution**:
1. Wait for a few minutes after creating the uptime check
2. Refresh the Cloud Monitoring console
3. Try creating the uptime check again with a different name
4. Check the uptime check status to ensure it's running properly

## Advanced Troubleshooting

### Using Cloud Monitoring API Directly

If the UI is giving you trouble, you can use the Cloud Monitoring API to diagnose issues:

```bash
# List all uptime checks
gcloud monitoring uptime-check-configs list

# List all monitoring groups
gcloud monitoring groups list

# View recent incidents
gcloud monitoring incidents list

# Check if a specific metric exists
gcloud monitoring metrics list --filter="metric.type=compute.googleapis.com/instance/uptime"
```

### Viewing Monitoring Logs

To get more information about monitoring issues:

1. Navigate to Logging in the Google Cloud Console
2. Create a query to view monitoring-related logs:

```
resource.type="monitoring"
```

## Common Error Messages

### "No data is available for the selected time frame"

This usually means:
- The resource is too new and hasn't generated metrics yet
- The resource isn't properly included in your metrics scope
- The metric may not apply to your specific VM type

### "You don't have permission to create a metrics scope"

Make sure you have the following roles:
- Monitoring Admin
- Project IAM Admin (to modify permissions if needed)

## Getting Further Help

If you're still experiencing issues:
1. Check the [Cloud Monitoring documentation](https://cloud.google.com/monitoring/docs)
2. Search the [Google Cloud Community forums](https://stackoverflow.com/questions/tagged/google-cloud-monitoring)
3. Contact Google Cloud Support if you have a support package
