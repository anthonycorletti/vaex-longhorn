# eks

This directory contains definitions for deploying EKS clusters via eksctl.

To create this cluster, you must first [create an ec2 keypair](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs) named `vaex-longhorn` in the correct region (by default we are creating this cluster in `us-east-1`).

Once you have created the keypair, from this project's root directory, run the following command.

```shell
eksctl create cluster -f eks/cluster.yaml
```
