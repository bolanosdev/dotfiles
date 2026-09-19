# gh-auth-test — validate that a GitHub token can be piped in from
# 1Password rather than pasted or exported by hand.
#
# EDIT THE op:// PATH BELOW to match your actual vault/item/field once
# you've created a GitHub token item in 1Password.
#
# Usage: gh-auth-test
function gh-auth-test --description "Test piping a GitHub token from 1Password into gh auth login"
    op read "op://Private/GitHub PAT/credential" | gh auth login --with-token
    and gh auth status
end
