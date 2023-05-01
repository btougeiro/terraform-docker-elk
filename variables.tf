# -----------------------------------------------------------------------------
# VARIABLES
# -----------------------------------------------------------------------------

variable "network_name" {
  type        = string
  description = "Name given to docker network to link the applications."
  default     = null
}

variable "keep_locally" {
  type        = bool
  description = "(Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation."
  default     = false
}

variable "restart" {
  type        = string
  description = "(String) The restart policy for the container. Must be one of 'no', 'on-failure', 'always', 'unless-stopped'. Defaults to no."
  default     = "no"
}

# -----------------------------------------------------------------------------
#  ELASTICSEARCH
# -----------------------------------------------------------------------------

variable "elasticsearch_container_name" {
  type        = string
  description = "Name given to elasticsearch container."
  default     = "elasticsearch"
}

variable "elasticsearch_ports" {
  type        = list(any)
  description = "List of ports to allow connection on Elasticsearch."
  default     = []
}

variable "elasticsearch_image" {
  type        = string
  description = "Official Elasticsearch Docker image name."
  default     = "elasticsearch"
}

variable "elasticsearch_version" {
  type        = string
  description = "Official Elasticsearch Docker image version."
  default     = "8.2.2"
}

variable "elasticsearch_num_of_containers" {
  type        = number
  description = "Specify number of containers for Elasticsearch."
  default     = 1
}

variable "elasticsearch_labels" {
  type        = list(any)
  description = "List of labels to attach to Elasticsearch."
  default     = []
}

variable "elasticsearch_env_vars" {
  type        = set(string)
  description = "(Set of String) Environment variables to set in the form of KEY=VALUE, e.g. DEBUG=0"
  default     = null
}

variable "elasticsearch_volumes" {
  type        = list(any)
  description = "(Block Set) Spec for mounting volumes in the container."
  default     = []
}

variable "elasticsearch_command" {
  type        = list(string)
  description = "(List of String) The command to use to start the container. For example, to run /usr/bin/myprogram -f baz.conf set the command to be [\"/usr/bin/myprogram\",\"-\",\"baz.con\"]."
  default     = []
}

variable "elasticsearch_mounts" {
  type        = list(any)
  description = "(Block Set) Specification for mounts to be added to containers created as part of the service."
  default     = []
}

# -----------------------------------------------------------------------------
# LOGSTASH
# -----------------------------------------------------------------------------

variable "logstash_container_name" {
  type        = string
  description = "Name given to logstash container."
  default     = "logstash"
}

variable "logstash_ports" {
  type        = list(any)
  description = "List of ports to allow connection on Logstash."
  default     = []
}

variable "logstash_image" {
  type        = string
  description = "Official Logstash Docker image name."
  default     = "logstash"
}

variable "logstash_version" {
  type        = string
  description = "Official Logstash Docker image version."
  default     = "8.2.2"
}

variable "logstash_num_of_containers" {
  type        = number
  description = "Specify number of containers for Logstash."
  default     = 1
}

variable "logstash_labels" {
  type        = list(any)
  description = "List of labels to attach to Logstash."
  default     = []
}

variable "logstash_env_vars" {
  type        = set(string)
  description = "(Set of String) Environment variables to set in the form of KEY=VALUE, e.g. DEBUG=0"
  default     = null
}

variable "logstash_volumes" {
  type        = list(any)
  description = "(Block Set) Spec for mounting volumes in the container."
  default     = []
}

variable "logstash_command" {
  type        = list(string)
  description = "(List of String) The command to use to start the container. For example, to run /usr/bin/myprogram -f baz.conf set the command to be [\"/usr/bin/myprogram\",\"-\",\"baz.con\"]."
  default     = []
}

variable "logstash_mounts" {
  type        = list(any)
  description = "(Block Set) Specification for mounts to be added to containers created as part of the service."
  default     = []
}

# -----------------------------------------------------------------------------
# KIBANA
# -----------------------------------------------------------------------------

variable "kibana_container_name" {
  type        = string
  description = "Name given to kibana container."
  default     = "kibana"
}

variable "kibana_ports" {
  type        = list(any)
  description = "List of ports to allow connection on Kibana."
  default     = []
}

variable "kibana_image" {
  type        = string
  description = "Official Kibana Docker image name."
  default     = "kibana"
}

variable "kibana_version" {
  type        = string
  description = "Official Kibana Docker image version."
  default     = "8.2.2"
}

variable "kibana_num_of_containers" {
  type        = number
  description = "Specify number of containers for Kibana."
  default     = 1
}

variable "kibana_labels" {
  type        = list(any)
  description = "List of labels to attach to Kibana."
  default     = []
}

variable "kibana_env_vars" {
  type        = set(string)
  description = "(Set of String) Environment variables to set in the form of KEY=VALUE, e.g. DEBUG=0"
  default     = null
}

variable "kibana_volumes" {
  type        = list(any)
  description = "(Block Set) Spec for mounting volumes in the container."
  default     = []
}

variable "kibana_command" {
  type        = list(string)
  description = "(List of String) The command to use to start the container. For example, to run /usr/bin/myprogram -f baz.conf set the command to be [\"/usr/bin/myprogram\",\"-\",\"baz.con\"]."
  default     = []
}

variable "kibana_mounts" {
  type        = list(any)
  description = "(Block Set) Specification for mounts to be added to containers created as part of the service."
  default     = []
}
