#!/bin/sh
read -p 'GitHub Username: ' uservar
read -sp 'GitHub Token: ' tokenvar
echo

echo "Removing any previous login for $uservar.."

echo "\
protocol=https
host=github.com
username=$uservar" | git credential-osxkeychain erase

echo 'Creating Keychain access login...'

echo "\
protocol=https
host=github.com
username=$uservar
password=$tokenvar" | git credential-osxkeychain store

grep -q "GITHUB_TOKEN=" "$1" &&  sed -i '' 's/GITHUB_TOKEN=.*/GITHUB_TOKEN='"$tokenvar"'/g' "$1" || echo "GITHUB_TOKEN=$tokenvar" >> "$1"
export "GITHUB_TOKEN=$tokenvar"


