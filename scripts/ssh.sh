ssh-keygen -t rsa -b 4096 -C "maetugr@gmail.com"
ssh-add ~/.ssh/id_rsa
cat < ~/.ssh/id_rsa.pub