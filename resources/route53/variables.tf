variable "elb_dns_name" {
  description = "The DNS name of the Elastic Load Balancer"
  type        = string
}

variable "elb_zone_id" {
  description = "The zone ID of the Elastic Load Balancer"
  type        = string
}

variable "zone_name" {
  description = "The name of the Route 53 hosted zone"
  type        = string
}

variable "zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
}
