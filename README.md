# Tor Server

Tor is free and open-source software for enabling anonymous communication. The name is derived from an acronym for the original software project name "The Onion
Router".

Tor directs Internet traffic through a free, worldwide, volunteer overlay network consisting of more than seven thousand relays to conceal a user's location and usage from anyone conducting network surveillance or traffic analysis.

## Prerequisites

- Kubernetes 1.7+

## Installing the Chart

Full installation instructions, including details on how to configure extra
functionality in tor can be found in the [getting started docs](https://helm-tor.readthedocs.io/en/latest/getting-started/).

To install the chart with the release name `my-release`:

```console

## Install the tor server helm chart
$ helm install tor .
```
> **Tip**: List all releases using `helm list`

Upgrading the Chart

Special considerations may be required when upgrading the Helm chart, and these
are documented in our full [upgrading guide](https://tor server.readthedocs.io/en/latest/admin/upgrading/index.html).
Please check here before perform upgrades!

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

# Hidden Ingresses


##

## Configuration

The following table lists the configurable parameters of the tor server chart and their default values.


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml .
```
> **Tip**: You can use the default [values.yaml](values.yaml)


hardware accel
grep aes /proc/cpuinfo > /dev/null; echo $?

## Contributing

This chart is maintained at [github.com/](https://github.com/).


