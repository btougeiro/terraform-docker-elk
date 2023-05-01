# -----------------------------------------------------------------------------
# MAIN
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# BACKEND
# -----------------------------------------------------------------------------

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">=3.0.2"
    }
  }
}

# -----------------------------------------------------------------------------
# DOCKER NETWORK
# -----------------------------------------------------------------------------

resource "docker_network" "this" {
  name = var.network_name
}

# -----------------------------------------------------------------------------
# ELASTICSEARCH
# -----------------------------------------------------------------------------

resource "docker_image" "elasticsearch" {
  name         = format("%s:%s", var.elasticsearch_image, var.elasticsearch_version)
  keep_locally = var.keep_locally
}

resource "docker_container" "elasticsearch" {
  count = var.elasticsearch_num_of_containers
  name  = var.elasticsearch_container_name

  env = var.elasticsearch_env_vars

  restart = var.restart
  image   = docker_image.elasticsearch.image_id

  networks_advanced {
    name = docker_network.this.name
  }

  dynamic "ports" {
    for_each = var.elasticsearch_ports
    content {
      internal = lookup(ports.value, "internal", null)
      external = lookup(ports.value, "external", null)
      ip       = lookup(ports.value, "ip", null)
      protocol = lookup(ports.value, "protocol", null)
    }
  }

  dynamic "labels" {
    for_each = var.elasticsearch_labels
    content {
      label = lookup(labels.value, "label", null)
      value = lookup(labels.value, "value", null)
    }
  }

  dynamic "volumes" {
    for_each = var.elasticsearch_volumes
    content {
      container_path = lookup(volumes.value, "container_path", null)
      from_container = lookup(volumes.value, "from_container", null)
      host_path      = lookup(volumes.value, "host_path", null)
      read_only      = lookup(volumes.value, "read_only", null)
      volume_name    = lookup(volumes.value, "volume_name", null)
    }
  }

  dynamic "mounts" {
    for_each = var.elasticsearch_mounts
    content {
      target = lookup(mounts.value, "target", null)
      type   = lookup(mounts.value, "type", null)

      dynamic "bind_options" {
        for_each = lookup(mounts.value, "bind_options", [])
        content {
          propagation = lookup(bind_options.value, "propagation", null)
        }
      }

      read_only = lookup(mounts.value, "read_only", null)
      source    = lookup(mounts.value, "source", null)

      dynamic "tmpfs_options" {
        for_each = lookup(mounts.value, "tmpfs_options", [])
        content {
          mode       = lookup(tmpfs_options.value, "mode", null)
          size_bytes = lookup(tmpfs_options.value, "size_bytes", null)
        }
      }

      dynamic "volume_options" {
        for_each = lookup(mounts.value, "volume_options", [])
        content {
          driver_name    = lookup(volume_options.value, "driver_name", null)
          driver_options = lookup(volume_options.value, "driver_options", null)
          dynamic "labels" {
            for_each = lookup(volume_options.value, "labels", [])
            content {
              label = lookup(labels.value, "label", null)
              value = lookup(labels.value, "value", null)
            }
          }
        }
      }
    }
  }

  command = var.elasticsearch_command
}

# -----------------------------------------------------------------------------
# LOGSTASH
# -----------------------------------------------------------------------------

resource "docker_image" "logstash" {
  name         = format("%s:%s", var.logstash_image, var.logstash_version)
  keep_locally = var.keep_locally
}

resource "docker_container" "logstash" {
  count = var.logstash_num_of_containers
  name  = var.logstash_container_name

  env = var.logstash_env_vars

  restart = var.restart
  image   = docker_image.logstash.image_id

  dynamic "ports" {
    for_each = var.logstash_ports
    content {
      internal = lookup(ports.value, "internal", null)
      external = lookup(ports.value, "external", null)
      ip       = lookup(ports.value, "ip", null)
      protocol = lookup(ports.value, "protocol", null)
    }
  }

  networks_advanced {
    name = docker_network.this.name
  }

  dynamic "labels" {
    for_each = var.logstash_labels
    content {
      label = lookup(labels.value, "label", null)
      value = lookup(labels.value, "value", null)
    }
  }

  dynamic "volumes" {
    for_each = var.logstash_volumes
    content {
      container_path = lookup(volumes.value, "container_path", null)
      from_container = lookup(volumes.value, "from_container", null)
      host_path      = lookup(volumes.value, "host_path", null)
      read_only      = lookup(volumes.value, "read_only", null)
      volume_name    = lookup(volumes.value, "volume_name", null)
    }
  }

  dynamic "mounts" {
    for_each = var.logstash_mounts
    content {
      target = lookup(mounts.value, "target", null)
      type   = lookup(mounts.value, "type", null)

      dynamic "bind_options" {
        for_each = lookup(mounts.value, "bind_options", [])
        content {
          propagation = lookup(bind_options.value, "propagation", null)
        }
      }

      read_only = lookup(mounts.value, "read_only", null)
      source    = lookup(mounts.value, "source", null)

      dynamic "tmpfs_options" {
        for_each = lookup(mounts.value, "tmpfs_options", [])
        content {
          mode       = lookup(tmpfs_options.value, "mode", null)
          size_bytes = lookup(tmpfs_options.value, "size_bytes", null)
        }
      }

      dynamic "volume_options" {
        for_each = lookup(mounts.value, "volume_options", [])
        content {
          driver_name    = lookup(volume_options.value, "driver_name", null)
          driver_options = lookup(volume_options.value, "driver_options", null)
          dynamic "labels" {
            for_each = lookup(volume_options.value, "labels", [])
            content {
              label = lookup(labels.value, "label", null)
              value = lookup(labels.value, "value", null)
            }
          }
        }
      }
    }
  }

  command = var.logstash_command
}

# -----------------------------------------------------------------------------
# KIBANA
# -----------------------------------------------------------------------------

resource "docker_image" "kibana" {
  name         = format("%s:%s", var.kibana_image, var.kibana_version)
  keep_locally = var.keep_locally
}

resource "docker_container" "kibana" {
  count = var.kibana_num_of_containers
  name  = var.kibana_container_name

  env = var.kibana_env_vars

  restart = var.restart
  image   = docker_image.kibana.image_id

  networks_advanced {
    name = docker_network.this.name
  }

  dynamic "ports" {
    for_each = var.kibana_ports
    content {
      internal = lookup(ports.value, "internal", null)
      external = lookup(ports.value, "external", null)
      ip       = lookup(ports.value, "ip", null)
      protocol = lookup(ports.value, "protocol", null)
    }
  }

  dynamic "labels" {
    for_each = var.kibana_labels
    content {
      label = lookup(labels.value, "label", null)
      value = lookup(labels.value, "value", null)
    }
  }

  dynamic "volumes" {
    for_each = var.kibana_volumes
    content {
      container_path = lookup(volumes.value, "container_path", null)
      from_container = lookup(volumes.value, "from_container", null)
      host_path      = lookup(volumes.value, "host_path", null)
      read_only      = lookup(volumes.value, "read_only", null)
      volume_name    = lookup(volumes.value, "volume_name", null)
    }
  }

  dynamic "mounts" {
    for_each = var.kibana_mounts
    content {
      target = lookup(mounts.value, "target", null)
      type   = lookup(mounts.value, "type", null)

      dynamic "bind_options" {
        for_each = lookup(mounts.value, "bind_options", [])
        content {
          propagation = lookup(bind_options.value, "propagation", null)
        }
      }

      read_only = lookup(mounts.value, "read_only", null)
      source    = lookup(mounts.value, "source", null)

      dynamic "tmpfs_options" {
        for_each = lookup(mounts.value, "tmpfs_options", [])
        content {
          mode       = lookup(tmpfs_options.value, "mode", null)
          size_bytes = lookup(tmpfs_options.value, "size_bytes", null)
        }
      }

      dynamic "volume_options" {
        for_each = lookup(mounts.value, "volume_options", [])
        content {
          driver_name    = lookup(volume_options.value, "driver_name", null)
          driver_options = lookup(volume_options.value, "driver_options", null)
          dynamic "labels" {
            for_each = lookup(volume_options.value, "labels", [])
            content {
              label = lookup(labels.value, "label", null)
              value = lookup(labels.value, "value", null)
            }
          }
        }
      }
    }
  }

  command = var.kibana_command
}
