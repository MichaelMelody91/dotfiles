#!/bin/sh

clone_repo()
{
	OWNER_REPO=$1
	OWNER="$(cut -d'/' -f1 <<<"$OWNER_REPO")"
	REPO="$(cut -d'/' -f2 <<<"$OWNER_REPO")"
	mkdir -p $2/$OWNER
	git clone https://github.com/$OWNER_REPO.git $2/$OWNER/$REPO
}

REPOS_WITH_OWNERS=$(gh api graphql --paginate -f query='query($endCursor: String) {
        viewer {
                repositories(isFork: false, first: 100, after: $endCursor, affiliations: [OWNER, ORGANIZATION_MEMBER, COLLABORATOR], ownerAffiliations: [OWNER, ORGANIZATION_MEMBER, COLLABORATOR]) {
                        nodes { nameWithOwner }
                        pageInfo {
                                hasNextPage
                                endCursor
                        }
                }
        }
}' | jq '.data.viewer.repositories.nodes[].nameWithOwner')

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
names=($REPOS_WITH_OWNERS) # split to array $names
IFS=$SAVEIFS   # Restore IFS

for repoowner in "${names[@]}"; do
	# https://stackoverflow.com/a/9733456/6110082
	trimmed_repo_owner=$(sed -e 's/^"//' -e 's/"$//' <<< "$repoowner")
	clone_repo $trimmed_repo_owner $1
done
