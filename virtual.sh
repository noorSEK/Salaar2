# Function to install and activate Python virtual environment
setup_python_env() {
    echo "[+] Setting up Python Virtual Environment..."
    mkdir -p /opt/bb-env
    python3 -m venv /opt/bb-env
    source /opt/bb-env/bin/activate
    echo "Python Virtual Environment Activated: $(which python)"
}
