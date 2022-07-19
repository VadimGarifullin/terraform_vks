variable pod_count {
  type        = number
  default     = 1
  description = "number of pods"
}

variable username {
  type        = string
  default     = ""
  description = "username vk cloud"
}

variable password {
  type        = string
  default     = ""
  description = "password from account vk cloud"
}

variable project_id { 
  type        = string
  default     = ""
  description = "your id of project"
}

variable private_key {
  type        = string
  default     = ""
  description = "your ssh rsa key"
}