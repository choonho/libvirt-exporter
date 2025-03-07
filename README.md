# Prometheus libvirt exporter

Docker image is available at [dockerhub](https://hub.docker.com/r/cloudeco/libvirt-exporter).

 - `Dockerfile` - creates a docker container with dynamically linked libvirt-exporter. Make an image and run with 
```docker run -p9177:9177 -e LIBVIRT_DOMAIN_LABEL=uuid -v /var/run/libvirt:/var/run/libvirt cloudeco/libvirt-exporter
```
 - `build-with` - builds dynamically linked libvirt-exporter in the container based on Dockerfile specified as an argument. Ex.: `build-with ./build_container/Dockerfile.ubuntu2004` will build libvirt-exporter for Ubuntu 20.04.

# Metrics
The following metrics/labels are being exported:

```
...
# TYPE libvirt_domain_vcpu_cpu gauge
libvirt_domain_vcpu_cpu{domain="59bf4250-c4df-4457-b478-df0a7677283b",vcpu="0"} 5
# HELP libvirt_domain_vcpu_delay_seconds_total Amount of CPU time used by the domain's VCPU, in seconds. Vcpu's delay metric. Time the vcpu thread was enqueued by the host scheduler, but was waiting in the queue instead of running. Exposed to the VM as a steal time.
# TYPE libvirt_domain_vcpu_delay_seconds_total counter
libvirt_domain_vcpu_delay_seconds_total{domain="59bf4250-c4df-4457-b478-df0a7677283b",vcpu="0"} 1.247116312
# HELP libvirt_domain_vcpu_state VCPU state. 0: offline, 1: running, 2: blocked
# TYPE libvirt_domain_vcpu_state gauge
libvirt_domain_vcpu_state{domain="59bf4250-c4df-4457-b478-df0a7677283b",vcpu="0"} 1
# HELP libvirt_domain_vcpu_time_seconds_total Amount of CPU time used by the domain's VCPU, in seconds.
# TYPE libvirt_domain_vcpu_time_seconds_total counter
libvirt_domain_vcpu_time_seconds_total{domain="59bf4250-c4df-4457-b478-df0a7677283b",vcpu="0"} 17.51
# HELP libvirt_domain_vcpu_wait_seconds_total Vcpu's wait_sum metric. CONFIG_SCHEDSTATS has to be enabled
# TYPE libvirt_domain_vcpu_wait_seconds_total counter
libvirt_domain_vcpu_wait_seconds_total{domain="59bf4250-c4df-4457-b478-df0a7677283b",vcpu="0"} 0
...
```

## Libvirt/qemu version notice
Some of the above might be exposed only with:

`libvirt >= v7.2.0`:
libvirt_domain_vcpu_delay_seconds_total

# Historical
Project forked from https://github.com/Tinkoff/libvirt-exporter.
Project forked from https://github.com/kumina/libvirt_exporter and substantially rewritten.
Implemented support for several additional metrics, ceph rbd (and network block devices), ovs.
Implemented statistics collection using GetAllDomainStats

And then forked again from https://github.com/rumanzo/libvirt_exporter_improved and rewritten.
Implemented meta metrics and more info about disks, interfaces and domain.

This repository provides code for a Prometheus metrics exporter
for [libvirt](https://libvirt.org/). This exporter connects to any
libvirt daemon and exports per-domain metrics related to CPU, memory,
disk and network usage. By default, this exporter listens on TCP port
9177.

This exporter makes use of
[libvirt-go](https://gitlab.com/libvirt/libvirt-go-module), the official Go
bindings for libvirt. This exporter make use of the
`GetAllDomainStats()`

# Option

ENV LIBVIRT_DOMAIN_LABEL=name | uuid
