# -----------------------------------------------------------------------------
# BACKEND
# -----------------------------------------------------------------------------

terraform {
  backend "local" {}
  required_version = ">=1.4.4"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">=3.0.2"
    }
  }
}

# -----------------------------------------------------------------------------
# PROVIDER
# -----------------------------------------------------------------------------

# Docker Desktop on Windows
# provider "docker" {
#   host = "npipe:////./pipe/dockerDesktopLinuxEngine"
# }

# Docker on Unix
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Docker over SSH
# provider "docker" {
#   host = "ssh://user@remote-host:22"
#   ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
# }

# -----------------------------------------------------------------------------
# LOCALS
# -----------------------------------------------------------------------------

locals {
  elasticsearch_version = "8.6.2"
  logstash_version      = "8.6.2"
  kibana_version        = "8.6.2"
}

# -----------------------------------------------------------------------------
# MODULE
# -----------------------------------------------------------------------------

module "docker_elk" {
  source = "../"

  /* DEFAULT VARS */

  keep_locally = true
  network_name = "terraform-docker-elk"
  restart      = "always"

  /* ELASTICSEARCH */

  elasticsearch_container_name = "elasticsearch"

  elasticsearch_env_vars = [
    "http.host=0.0.0.0",
    "transport.host=localhost",
    "network.host=0.0.0.0",
    "ES_JAVA_OPTS=-Dlog4j2.formatMsgNoLookups=true -Xms512m -Xmx512m",
    "discovery.type=single-node"
  ]

  elasticsearch_image   = "elasticsearch"
  elasticsearch_version = local.elasticsearch_version

  elasticsearch_labels = [
    {
      label = "SearchEngine"
      value = "Elasticsearch"
    },
    {
      label = "Version"
      value = local.elasticsearch_version
    }
  ]

  elasticsearch_num_of_containers = 1

  elasticsearch_ports = [
    {
      internal = 9200
      external = 9200
    },
    {
      internal = 9300
      external = 9300
    }
  ]

  elasticsearch_mounts = [
    {
      source = "/data/elasticsearch"
      target = "/usr/share/elasticsearch/data"
      type   = "bind"
    }
  ]

  /* LOGSTASH */

  logstash_container_name = "logstash"
  logstash_image          = "logstash"
  logstash_version        = local.logstash_version

  logstash_labels = [
    {
      label = "LogCollector"
      value = "Logstash"
    },
    {
      label = "Version"
      value = local.logstash_version
    }
  ]

  logstash_env_vars = [
    "LS_JAVA_OPTS=-Dlog4j2.formatMsgNoLookups=true -Xms512m -Xmx512m"
  ]

  logstash_num_of_containers = 1

  logstash_ports = [
    {
      internal = 9600
      external = 9600
    }
  ]

  logstash_mounts = [
    {
      source = "/data/logstash"
      target = "/logstash_dir"
      type   = "bind"
    }
  ]

  logstash_command = ["logstash", "-f", "/logstash_dir/logstash.conf"]

  /* KIBANA */

  kibana_container_name = "kibana"

  kibana_env_vars = [
    "ELASTICSEARCH_URL=http://elasticsearch:9200"
  ]

  kibana_image   = "kibana"
  kibana_version = local.kibana_version

  kibana_labels = [
    {
      label = "DataVisualization"
      value = "Kibana"
    },
    {
      label = "Version"
      value = local.kibana_version
    }
  ]
  kibana_num_of_containers = 1

  kibana_ports = [
    {
      internal = 5601
      external = 5601
    }
  ]
}
