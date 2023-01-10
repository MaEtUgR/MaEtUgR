sudo swapoff -a # disable old swap file
sudo dd if=/dev/zero of=/swapfile bs=1G count=32 # create 32GB file
sudo chmod 0600 /swapfile # permissions
sudo mkswap /swapfile # filesystem
sudo swapon /swapfile # enable new swap file
