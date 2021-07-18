#/usr/bin/env sh

# Main script which updates the A record, should be used with cron or equivalent

source ./config.txt

# Fetch the current public IP address
if ! PUBLIC_IP=$(curl -fs https://api.ipify.org); then
    echo "Curl to public IP service failed"
    exit 1
fi

# Compare the current public IP address to the last recorded public IP address
IP_RECORD="/tmp/cloudflare-dynamic-dns-ip-record"
if [ "$PUBLIC_IP" = "$(cat $IP_RECORD)" ]; then
    exit 0 # Public IP has not changed, exit
fi
echo $PUBLIC_IP > $IP_RECORD # Record new IP

# Record the new public IP address on Cloudflare using API v4
DATA=$(printf '{"content":"%s"}' "$PUBLIC_IP")
response=$(curl -s \
    -X PATCH "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records/$CLOUDFLARE_RECORD_ID" \
    -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
    -H "Content-Type: application/json" \
    -d "$DATA")
echo $response
echo $response | grep -q '"success":true' # Sets exit code
