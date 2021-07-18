#!/usr/bin/env sh

# Queries the Cloudflare API for the Zone ID of the domain name, writes result to config.txt

source ./config.txt

echo "Getting Zone ID for domain from Cloudflare API..."
response=$(curl -s \
    -X GET "https://api.cloudflare.com/client/v4/zones?name=$CLOUDFLARE_DOMAIN_NAME" \
    -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" -H "Content-Type:application/json")
if echo $response | grep -q '"success":false'; then
    echo "Cloudflare API call failed with the following information:"
    echo $response
    exit 1
fi

id=$(echo $response | grep -Po '"id":"\K.*?(?=")' | head -1)
echo "Got Zone ID: $id"
echo "Writing to config.txt"
sed -i "s/\(^CLOUDFLARE_ZONE_ID=\)\(.*\)/\1$id/" ./config.txt
