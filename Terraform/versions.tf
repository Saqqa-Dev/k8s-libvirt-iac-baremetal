terraform {
  required_version = ">= 1.16.1"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.9.9"
    }
  }
}

# Configure the Libvirt Provider
provider "libvirt" {
  # Connection URI - defaults to qemu:///system if not specified
  uri = "qemu:///system"

  # For user session:
  # uri = "qemu:///session"

  # For remote connections (not yet implemented):
  # uri = "qemu+ssh://user@remote-host/system"
}

