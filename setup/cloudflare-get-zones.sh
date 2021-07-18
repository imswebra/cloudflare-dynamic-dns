#/usr/bin/env sh

# Returns JSON list of zones matching the domain name, grab the ID from the valid entry

source ./config.txt

echo "Getting Zone ID for domain from Cloudflare API..."
if ! response=$(curl --fail-with-body -s \
    -X GET "https://api.cloudflare.com/client/v4/zones?name=$CLOUDFLARE_DOMAIN_NAME" \
    -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" -H "Content-Type:application/json");
then
    echo "Cloudflare API call failed with the following information:"
    echo $response
    exit 1
fi

id=$(echo $response | grep -Po '"id":"\K.*?(?=")' | head -1)
echo "Got Zone ID: $id"
echo "Writing to config.txt"
sed -i "s/\(^CLOUDFLARE_ZONE_ID=\)\(.*\)/\1$id/" ./config.txt
