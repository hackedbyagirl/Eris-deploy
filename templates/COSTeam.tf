terraform {
  required_version = ">= 0.11.0"
}

module "COSTeam" {
  source = "../../modules/OCON/COSTeamAccountTest"

  godess_usernames = ["firstname1.lastname1",  "firstname2.lastname2"]

}

# ------------------------------------------------------------------------------
# Display awesomeness of Users Created
#   - Godess IAM Users
#   - Goddesses IAM Group
# ------------------------------------------------------------------------------
output "users" {
    value = "${module.COSTeam.godess_users}"  
}  

output "IAM Group" {
    value = "${module.COSTeam.godesses_group}"
}
