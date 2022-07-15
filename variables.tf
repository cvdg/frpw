variable "location" {
  description = "Location of the Azure Cloud"
  default     = "westeurope"
}

variable "prefix" {
  description = "Name prefix"
  default     = "htb"
}

variable "username" {
  description = "Name of the admin user"
  default     = "cvdg"
}

variable "ssh_public_key" {
  description = "Public SSH key in RSA format"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDh7i/cnfg7Kox2N2V/UbpmrboZykA3MmREtVbX+dysFe7X6A7X6623XKoHDbp+G7v14dG5ZBWRwrqYeSoNmQz61Uma1LTfPDPkMV5QRwQK5m9ClWylA17tOPLNXnOzkpACgP9c2tRxBGqjVVQ5YAekXZJtu/A6nP1PW+hLAX3HjrXU8mmLRm4MwAd/WmOXXjRCL2dkAr9tn/JLsFx0B3DuuDlNpshB4n7ewSnikLRKK8mrhBuJZZKiobBhEuzEn7dMqCG9Wlw/oYtyR+hvS6G0NZvnsJM5OMcD97xekrlpp8Rf43wLZWEKf31gHFP+8cthuF+ldbPWFBinVR6ow2clyzMFFDOlFrUI1SJwyGkyZEBo8NTCm4NPVh6y39QHV9dD8ArD4exekzRz6QyJW4+EfJS8p7gSKz9MZfuA8TLu0GsERez32zBbUMmmttzCko46rIMwiiepYYP21ui4njNSxtqtDJ2HBe8TovuChvhhRZh5+0JuwzCeCe92TzBFbgk= cvdg@cvdg.eu"
}

variable "tags" {
  type = map(any)
  default = {
    "environment" = "htb",
    "createdby"   = "terraform"
  }
}
