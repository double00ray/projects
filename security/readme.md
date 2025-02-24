# Security Notes

All of my security notes go in here.

## Best Practices

- Use environment variables for passing API keys.
- Do not store API keys in plain text files.
- Save Terraform state to an S3 bucket in the same account as API keys.
- Lock down the account and bucket.
- Encrypt disk:
  - Use BitLocker for Windows.
  - Find an alternative for Mac.
- If storing locally, use a password-protected file and do not leave the computer unlocked.

## Useful Links

- [Protecting Sensitive Data in Terraform State](https://docs.aws.amazon.com/prescriptive-guidance/latest/secure-sensitive-data-secrets-manager-terraform/terraform-state-file.html)
- [Creating Short Term Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-short-term.html)