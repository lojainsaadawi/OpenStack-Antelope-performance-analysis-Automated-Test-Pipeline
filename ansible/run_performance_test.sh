#!/bin/bash
set -e

echo "========================================="
echo "OpenStack Antelope Performance Test "
echo "========================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

source /home/lojain/performance-automation/terraform/performance-auto-openrc.sh

echo "[1/4] Deploying infrastructure with Terraform..."
cd "$SCRIPT_DIR/../terraform"
terraform init
terraform apply -auto-approve
cd "$SCRIPT_DIR"

echo "[2/4] Setting up Prometheus and Node Exporters..."
ansible-playbook -i "$SCRIPT_DIR/inventory/openstack_nodes.ini" "$SCRIPT_DIR/playbooks/01-setup-monitoring.yml"

echo "[3/4] Running performance tests scenario by scenario..."

ansible-playbook -i "$SCRIPT_DIR/../hosts.ini" "$SCRIPT_DIR/playbooks/03-run-scenarios.yml"

echo "[4/4] Generating final report..."
ansible-playbook "$SCRIPT_DIR/playbooks/04-generate-report.yml"

echo "========================================="
echo "Tests completed. Results are in the results/ directory."
echo "========================================="
