#!/usr/bin/env python3

"""Link Nessus Agent to Tenable/Nessus server.

This file is a template.  It must be processed by Terraform.
"""

# Standard Python Libraries
import subprocess

# Third-Party Libraries
import boto3

# Inputs from terraform
NESSUS_GROUPS = "${nessus_groups}"
NESSUS_HOSTNAME_KEY = "${nessus_hostname_key}"
NESSUS_KEY_KEY = "${nessus_key_key}"
NESSUS_PORT_KEY = "${nessus_port_key}"
SSM_READ_ROLE_ARN = "${ssm_read_role_arn}"

# Create STS client
sts_client = boto3.client("sts")

# Assume the role that can read the SSM Parameter Store parameters
stsresponse = sts_client.assume_role(
    RoleArn=SSM_READ_ROLE_ARN, RoleSessionName="nessus_agent_linking"
)
newsession_id = stsresponse["Credentials"]["AccessKeyId"]
newsession_key = stsresponse["Credentials"]["SecretAccessKey"]
newsession_token = stsresponse["Credentials"]["SessionToken"]

# Create a new client to access SSM Parameter Store using the
# temporary credentials
ssm_client = boto3.client(
    "ssm",
    aws_access_key_id=newsession_id,
    aws_secret_access_key=newsession_key,
    aws_session_token=newsession_token,
)

# Get the values of the SSM Parameter Store parameters
nessus_hostname_response = ssm_client.get_parameter(
    Name=NESSUS_HOSTNAME_KEY,
    WithDecryption=True,
)
nessus_hostname = nessus_hostname_response["Value"]

nessus_key_response = ssm_client.get_parameter(
    Name=NESSUS_KEY_KEY,
    WithDecryption=True,
)
nessus_key = nessus_key_response["Value"]

nessus_port_response = ssm_client.get_parameter(
    Name=NESSUS_PORT_KEY,
    WithDecryption=True,
)
nessus_port = nessus_port_response["Value"]

# Link the Nessus Agent
link_cmd = [
    "/opt/nessus/sbin/nessuscli",
    "agent",
    "link",
    f"--key={nessus_key}",
    f"--host={nessus_hostname}",
    f"--port={nessus_port}",
    f"--groups={NESSUS_GROUPS}",
]
subprocess.run(link_cmd)
