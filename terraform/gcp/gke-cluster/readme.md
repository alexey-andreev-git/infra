# gke-cluster

## Project Description

The `gke-cluster` project is designed to create a Google Kubernetes Engine (GKE) cluster in Google Cloud Platform (GCP) with a public network configuration. This setup allows the GKE cluster to be accessible over the internet, enabling external traffic to reach the cluster's services.

## Features

- **GKE Cluster Creation**: Automates the creation of a GKE cluster in GCP.
- **Public Network Configuration**: Configures the cluster to use a public network, making it accessible from the internet.
- **Scalability**: Supports scaling of the cluster to handle varying workloads.
- **Security**: Implements necessary security measures to protect the cluster and its resources.

## Prerequisites

Before you begin, ensure you have the following:

- A Google Cloud Platform account with necessary permissions to create and manage GKE clusters.
- Google Cloud SDK installed and configured on your local machine.
- Kubernetes command-line tool (`kubectl`) installed.

## Setup Instructions

1. **Authenticate with GCP**:
    ```sh
    gcloud auth login
    ```

2. **Set the desired GCP project**:
    ```sh
    gcloud config set project [PROJECT_ID]
    ```

3. **Create the GKE cluster**:
    ```sh
    gcloud container clusters create [CLUSTER_NAME] --zone [COMPUTE_ZONE] --network [NETWORK_NAME] --subnetwork [SUBNETWORK_NAME]
    ```

4. **Get authentication credentials for the cluster**:
    ```sh
    gcloud container clusters get-credentials [CLUSTER_NAME] --zone [COMPUTE_ZONE]
    ```

5. **Deploy your applications to the cluster using `kubectl`**:
    ```sh
    kubectl apply -f [YOUR_DEPLOYMENT_FILE].yaml
    ```

## Usage

Once the GKE cluster is set up, you can deploy, manage, and scale your containerized applications using Kubernetes commands. The public network configuration allows your services to be accessible from the internet, making it suitable for web applications, APIs, and other internet-facing services.

## Security Considerations

- Ensure that your cluster is configured with appropriate firewall rules to restrict access to only necessary IP addresses.
- Regularly update your cluster and its components to the latest versions to mitigate security vulnerabilities.
- Use Kubernetes secrets to manage sensitive information such as API keys and passwords.

## Conclusion

The `gke-cluster` project simplifies the process of creating and managing a GKE cluster with a public network in GCP. By following the setup instructions and adhering to security best practices, you can efficiently deploy and manage your applications in a scalable and secure environment.