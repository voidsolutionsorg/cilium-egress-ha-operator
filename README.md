# cilium-egress-ha-operator

## Description

[cilium-egress-ha-operator](https://github.com/tminaorg/cilium-egress-ha-operator) is a simple k8s operator based on [Flant shell-operator](https://github.com/flant/shell-operator) for HA-mode of Cilium egress feature.

[Cilium](https://cilium.io/) has an awesome feature called [egress](https://docs.cilium.io/en/stable/network/egress-gateway/), that allows you to redirect outbound traffic from specific pods to specific nodes (via labels).

As you know, in Kubernetes nodes can appear and disappear just like pods. But you can allocate a pool of nodes for outbound traffic for some (or all) apps with this Cilium feature. This is a very common case, for example, if you need to send a whitelist of IPs to your third parties.

Unfortunately, [community version of Cilium doesn't have HA-mode for egress](https://github.com/cilium/cilium/issues/18230).

This operator implements a simple HA-mode for egress. Let's assume that you have 2 "low workload" or "empty" nodes for egress with label `node.kubernetes.io/role: "egress"`: egress-1 & egress-2. By default the node for egress outbound traffic is egress-1. If this node goes into state "Not Ready", this operator will override all manifests for egress and replace this node there with reserve egress-2.

This process takes about 30s.

## Deployment

Use provided Helm chart repo: `https://tmina.github.io/cilium-egress-ha-operator/` and chart name: `cilium-egress-ha-operator`

## Acknowledgments

This repo is a fork of nikatar's [egress-cilium-node-ha-operator](https://github.com/nikatar/egress-cilium-node-ha-operator) with a few notable changes:

- Helm chart for easier deployment

- Github Container registry docker image (`ghcr.io/tminaorg/cilium-egress-ha-operator`) for amd64 & arm64

- Label: `node.kubernetes.io/role: "egress"` instead of `node-role.kubernetes.io/egress: "true"`

- Less K8s ClusterRole permissions:
  - removed "patch" for nodes (remaining: "get", "watch", "list")
  - removed "watch", "list", "create" for ciliumegressgatewaypolicies (remaining: "get", "patch")
