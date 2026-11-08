resource "libvirt_network" "kube_network" {
  name = "k8snet"
  autostart = true
  bridge = {
    name = "virbr-k8s"
  }

  forward = {
    mode = "nat"
  }

  ips = [
    {
      address = "10.10.10.1"
      netmask = "255.255.255.0"
      dhcp = {
        ranges = [
          {
            start = "10.10.10.100"
            end   = "10.10.10.200"
          }
        ]
      }
    }
  ]

}
