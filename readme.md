docker build -t gst-docker --cpu-shares 3  .


- error: Failed to connect to github.com port 443: Connection timed out
    changing the /etc/default/docker file to include the line:

    export    DOCKER_OPTS="--mtu=1400"
    sudo systemctl restart docker
