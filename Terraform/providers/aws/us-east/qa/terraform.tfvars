net_cidr = "10.141.0.0/16"

net_ranges = {
  public_cidr_ranges = [
    "10.141.100.0/24",
    "10.141.101.0/24",
  ]
  private_cidr_ranges = [
    "10.141.110.0/24",
    "10.141.111.0/24",
  ]
}


# webhook secret
webhook_secret = "0127957427501013311425330563"
