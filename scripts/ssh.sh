ssh-keygen -t ed25519 -C "maetugr@gmail.com"
# eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519
cat < ~/.ssh/id_ed25519.pub
