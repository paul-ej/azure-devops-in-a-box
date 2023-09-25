variable "project_name" {
  type = string
}

variable "description" {
  type = string
}

variable "visibility" {
  type = string
}

variable "version_control" {
  type = string
}

variable "work_item_template" {
  type = string
}

variable "repo_name" {
  type = string
  default = "cfp_demo_repo"
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
  default = "UK South"
}

variable "kv_name" {
  type = string
  default = "cfg_demo_kv"
}

variable "kv_sku_name" {
  type = string
  default = "standard"
}