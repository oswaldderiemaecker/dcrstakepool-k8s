# **Experimental - Under Development - Use at your own risk**

# Decred Kubernetes

This repo is to deploy the various Decred software using Kubernetes to provide development and hopefully in production environments when everything is settle.

The current deployments are currently available:

* [cold-wallet](https://github.com/oswaldderiemaecker/dcrstakepool-k8s/tree/master/cold-wallet)
* [dcrstakepool](https://github.com/oswaldderiemaecker/dcrstakepool-k8s/tree/master/dcrstakepool)
* [dcrdata](https://github.com/oswaldderiemaecker/dcrstakepool-k8s/tree/master/dcrdata)
* politeia (ongoing)

# Deploying the infrastructure on AWS

Follow the [AWS](https://github.com/oswaldderiemaecker/dcrstakepool-k8s/blob/master/AWS.md) instructions.

# Contribution

All comments and contribution are welcome. You can contact me at oswald@continuous.lu

# Next Steps

* When there is sleep, implement state verification instead
* Adding monitoring and alerting
* Adding Backup and Restore

# Issue Tracker

The integrated [github issue](https://github.com/oswaldderiemaecker/dcrstakepool-k8s/issues) tracker is used for this project.

# Version History

* 0.1.1  Changed to Statefulset
* 0.1.0  Initial release for development in testnet operations
