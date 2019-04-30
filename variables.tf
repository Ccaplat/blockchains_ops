variable "AWS_REGION" {
  default = "us-east-2"
}
variable "private_key" {
  default = "chainkey"
}
variable "public_key" {
  default = "chainkey.pub"
}
## Email provided if we want to setup cloudwatch alarms and sns monitoring.
# This will be use in another project
#variable "alarms_email" {
#  default = "youremail@email.com"
#}

### IT is very important to use ubuntu 16.04, sawtooth and fabric installations
### and tests do not run well in 18.04
variable "AMIS" {
  type = "map"
  default = {
    us-east-2 = "ami-0653e888ec96eab9b" # aws 16.04 instances
  }
}
