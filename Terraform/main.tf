# Network Structura
resource "libvirt_network" "kube_network" {
  name      = "k8snet"
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
# Storage Pool
resource "libvirt_pool" "kube_pool" {
  name = "k8spool"
  type = "dir"
  target = {
    path = "/var/lib/libvirt/storage/images/pool_img/"
    permissions = {
      group = "0"
      mode  = "0711"
      owner = "0"
    }
  }
  create = {
    autostart = true
    build     = true
    start     = true
  }
  destroy = {
    delete = false
  }
}

# Volume from HTTP URL upload
resource "libvirt_volume" "ubuntu_base" {
  name   = "ubuntu-22.04.qcow2"
  pool   = "k8spool"
  target = {
    format = {
      type = "qcow2"
    }
  }

  create = {
    content = {
      url = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
    }
  }
  # capacity is automatically computed from Content-Length when available
}
