# Create COSTeam IAM Users

Creates an IAM Group and Users for the COSTeam and sets their permissions


## Example

```hcl
module "COSTeam" {
  source = "../../modules/OCON/COSTeamAccountTest"

  godess_usernames = [\"firstname1.lastname1\",  \"firstname2.lastname2\"]
  
}
```
## Arguments
| Name | Required | Value Type | Description |
|------|----------|------------|-------------|
| `godess_usernames` | Yes | List(string) | The usernames associated with the godess-like accounts to be created, which are allowed to access the terraform backend, are IAM administrators for the COSTeam account, and are allowed to assume any role that has a trust relationship with the COSTeam account.  The format first.last is recommended.  Example: [\"firstname1.lastname1\",  \"firstname2.lastname2\"]. |

 
## Outputs
| Name | Value Type | Description |
|------|------------|-------------|
| `godess_users` | List(string) | The usernames associated with the godess-like accounts to be created, which are allowed to access the terraform backend, are IAM administrators for the COSTeam account | 