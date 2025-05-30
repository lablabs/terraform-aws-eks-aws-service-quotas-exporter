/**
 * # AWS EKS AWS Service Quota Exporter Terraform module
 *
 * A Terraform module to deploy the [aws-service-quotas-exporter](https://github.com/lablabs/aws-service-quotas-exporter) on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-aws-service-quotas-exporter/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-aws-service-quotas-exporter/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-aws-service-quotas-exporter/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-aws-service-quotas-exporter/actions/workflows/pre-commit.yaml)
 */
locals {
  addon = {
    name = "aws-service-quotas-exporter"

    helm_chart_name    = "aws-service-quotas-exporter"
    helm_chart_version = "0.0.3"
    helm_repo_url      = "ghcr.io/lablabs/aws-service-quotas-exporter"
  }

  addon_irsa = {
    (local.addon.name) = {}
  }

  addon_values = yamlencode({
    serviceAccount = {
      create = var.service_account_create != null ? var.service_account_create : true
      name   = var.service_account_name != null ? var.service_account_name : local.addon.name
      annotations = module.addon-irsa[local.addon.name].irsa_role_enabled ? {
        "eks.amazonaws.com/role-arn" = module.addon-irsa[local.addon.name].iam_role_attributes.arn
      } : tomap({})
    }
    exporter = {
      config = var.exporter_config
    }
  })

  addon_depends_on = []
}
