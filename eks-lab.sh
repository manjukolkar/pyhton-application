#!/bin/bash

CLUSTER_NAME="flask-lab"
REGION="us-west-2"
NODE_TYPE="t3.small"
NODE_COUNT=2

function create_cluster() {
    echo "🔧 Creating EKS Cluster: $CLUSTER_NAME in $REGION..."
    eksctl create cluster \
      --name $CLUSTER_NAME \
      --region $REGION \
      --nodes $NODE_COUNT \
      --node-type $NODE_TYPE \
      --managed

    echo "✅ EKS Cluster created!"
    echo "⛅ Updating kubeconfig..."
    aws eks --region $REGION update-kubeconfig --name $CLUSTER_NAME

    echo "🚀 Cluster is ready! You can now deploy your app using kubectl."
}

function delete_cluster() {
    echo "⚠️ Deleting EKS Cluster: $CLUSTER_NAME..."
    eksctl delete cluster --name $CLUSTER_NAME --region $REGION
    echo "🧹 Cluster deleted. Billing stopped!"
}

function help_menu() {
    echo "Usage: ./eks-lab.sh [create|delete]"
}

case "$1" in
    create)
        create_cluster
        ;;
    delete)
        delete_cluster
        ;;
    *)
        help_menu
        ;;
esac