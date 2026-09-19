# glab-auth-test — validate that a GitLab token can be piped in from
# 1Password rather than pasted or exported by hand.
#
# EDIT THE op:// PATH BELOW to match your actual vault/item/field once
# you've created a GitLab token item in 1Password.
#
# Usage: glab-auth-test
function glab-auth-test --description "Test piping a GitLab token from 1Password into glab auth login"
    op read "op://Private/GitLab PAT/credential" | glab auth login --hostname gitlab.com --stdin
    and glab auth status
end
