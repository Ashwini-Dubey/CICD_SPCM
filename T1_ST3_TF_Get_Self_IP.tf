######################################################################################
#Detecting the Self IP automatically , to be passed on to the ingress for Bastion    #
#Host SG & Public Web SG.                                                            #
######################################################################################
data "http" "self_ip" {
  url = "http://ipv4.icanhazip.com"
}

