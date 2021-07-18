# Cloudflare Dynamic DNS
cURL-based shell scripts which call Cloudflare's v4 API to update the IP of an A record, allowing for DDNS functionality.
- Lightweight and readable
- Simple setup
- Uses [Cloudflare's Patch DNS Record](https://api.cloudflare.com/#dns-records-for-a-zone-patch-dns-record) endpoint
- Only hits Cloudflare's API if the IP has changed (caches last known IP)

## Setup
1. Create an A record to be updated by this script if you do not have one already. Set the IP to a bogus value so we can confirm the script worked.
1. Create a [Cloudflare API token](https://developers.cloudflare.com/api/tokens/create) with Zone Read and DNS Edit permissions.
1. Edit the top portion of `config.txt`, adding your API token, root domain name, and name of the record.
1. Run the setup script (`./setup.sh`) to fetch the other required values from Cloudflare, verify that they have been written to `config.txt`.
1. Run the main script (`./cloudflare-ddns.sh`) and verify its success based on the API response and if the record's IP was updated in the Cloudflare dashboard. If so, setup a cron job or equivalent to run this script every X minutes/hours/days.
