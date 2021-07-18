#/usr/bin/env sh

# Returns JSON list of zones matching the domain name, grab the ID from the valid entry

# Variables:
#   CLOUDFLARE_API_TOKEN   - Cloudflare API token from Cloudflare dashboard (Authentication tab)
#   CLOUDFLARE_DOMAIN_NAME - Domain name e.g. github.com

curl -X GET "https://api.cloudflare.com/client/v4/zones?name=$CLOUDFLARE_DOMAIN_NAME" -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" -H "Content-Type:application/json"
