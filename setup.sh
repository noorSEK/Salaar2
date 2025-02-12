#!/bin/bash

set -e  # Exit script on error

# Function to install system dependencies
install_packages() {
    echo "[+] Installing System Dependencies..."
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install -y net-tools speedtest-cli lolcat figlet \
        python3 python3-pip python3-venv git php curl wget unzip jq \
        dnsutils whois nmap masscan tmux npm build-essential cmake make gcc
}

# Function to install Go
install_golang() {
    echo "[+] Installing Go..."
    wget -q https://go.dev/dl/go1.23.4.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
    rm go1.23.4.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    echo "Go version: $(go version)"
}

# Function to install Go tools
install_go_tools() {
    echo "[+] Installing Go-based tools..."
    go install github.com/tomnomnom/assetfinder@latest
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    go install -v github.com/owasp-amass/amass/v3/...@master
    go install github.com/tomnomnom/waybackurls@latest
    go install github.com/projectdiscovery/katana/cmd/katana@latest
    go install github.com/lc/gau/v2/cmd/gau@latest
    go install github.com/bp0lr/gauplus@latest
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    go install github.com/tomnomnom/httprobe@latest
    go install github.com/tomnomnom/qsreplace@latest
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    go install -v github.com/projectdiscovery/urlfinder/cmd/urlfinder@latest
    go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
    go install github.com/hakluke/hakrawler@latest
    go install github.com/Brosck/mantra@latest

    # Move Go binaries to system path
    mkdir -p ~/go/bin
    sudo cp ~/go/bin/* /usr/local/bin/ 2>/dev/null || true
}

# Function to install non-Go tools
install_other_tools() {
    echo "[+] Installing Other Security Tools..."
    
    echo "[+] Installing Findomain..."
    curl -LO https://github.com/findomain/findomain/releases/latest/download/findomain-linux.zip
    unzip findomain-linux.zip && rm findomain-linux.zip
    chmod +x findomain
    sudo mv findomain /usr/bin/findomain
    
    echo "[+] Installing Sublist3r..."
    git clone https://github.com/aboul3la/sublist3r.git /opt/sublist3r
    pip3 install -r /opt/sublist3r/requirements.txt

    echo "[+] Installing ParamSpider..."
    git clone https://github.com/devanshbatham/paramspider.git /opt/paramspider
    pip3 install -r /opt/paramspider/requirements.txt

    echo "[+] Installing SQLmap..."
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap

    echo "[+] Installing Nuclei Fuzzing Templates..."
    git clone https://github.com/projectdiscovery/fuzzing-templates.git /opt/fuzzing-templates
}

# Execute functions
install_packages
setup_python_env
install_golang
install_go_tools
install_other_tools

echo "[+] Setup Completed Successfully! Python virtual environment is activated."
