# Configure the Packet Provider. 
provider "packet" {
   auth_token = "${var.auth_token}"
}

# Declare your project ID
#
# You can find ID of your project form the URL in the Packet web app.
# For example, if you see your devices listed at
# https://app.packet.net/projects/352000fb2-ee46-4673-93a8-de2c2bdba33b
# .. then 352000fb2-ee46-4673-93a8-de2c2bdba33b is your project ID.
locals {
  project_id = "e3123b01-0047-48ef-989e-c34a7bb6b9c3"
}

# If you want to create a fresh project, you can create one with packet_project
# 
# resource "packet_project" "cool_project" {
#   name           = "My First Terraform Project"
# }

# Create a device and add it to tf_project_1
resource "packet_device" "test-gns3" {
  hostname         = "test-gns3"
  plan             = "c1.small.x86"
  facilities       = ["ewr1"]
  operating_system = "ubuntu_18_04"
  billing_cycle    = "hourly"
  project_id       = "${local.project_id}"
  user_data        = "${file("install_gns3.sh")}"

  # if you have created project with packet_project resource, refer to its ID
  # project_id       = "${packet_project.cool_project.id}"
}