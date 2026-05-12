sudo swapoff /swap.img # disable only this swap file
sudo fallocate -l 32G /swap.img # overwrite it with 32GB version
sudo chmod 0600 /swap.img # permissions (likely already correct)
sudo mkswap /swap.img # set up swap filesystem
sudo swapon /swap.img # re-enable
