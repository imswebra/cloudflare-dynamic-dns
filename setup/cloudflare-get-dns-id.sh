#/usr/bin/env sh

# Returns JSON list of DNS entries matching the subdomain, grab the ID from the valid entry

# Variables:
#   CLOUDFLARE_API_TOKEN - Cloudflare API token from Cloudflare dashboard (Authentication tab)
#   CLOUDFLARE_ZONE_ID   - Zone ID from cloudflare-get-zones.sh script
#   CLOUDFLARE_SUBDOMAIN - Subdomain w/ the root domain for the record to edit e.g. dynamic.github.com

curl -X GET "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records?name=$CLOUDFLARE_SUBDOMAIN" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type:application/json"
