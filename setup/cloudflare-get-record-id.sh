#/usr/bin/env sh

# Queries the Cloudflare API for the Record ID of the subdomain, writes result to config.txt

source ./config.txt

echo "Getting Record ID for subdomain from Cloudflare API..."
response=$(curl -s \
    -X GET "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records?name=$CLOUDFLARE_RECORD_NAME" \
    -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" -H "Content-Type:application/json")
if echo $response | grep -q '"success":false'; then
    echo "Cloudflare API call failed with the following information:"
    echo $response
    exit 1
fi

id=$(echo $response | grep -Po '"id":"\K.*?(?=")' | head -1)
echo "Got Record ID: $id"
echo "Writing to config.txt"
sed -i "s/\(^CLOUDFLARE_RECORD_ID=\)\(.*\)/\1$id/" ./config.txt
