gpg --full-generate-key # 1, 3072, 1y, y, name, mail, no comment, O
gpg --list-secret-keys --keyid-format=long # copy ID after "sec   rsa3072/"
gpg --armor --export # append previously copied ID if it works otherwise run without which works with a single key
git config --global user.signingkey # paste previously copied ID
git config --global user.signingkey # paste ID which needs to be copied after "ssb   rsa3072/"
git config --global commit.gpgsign true
git config --global tag.gpgSign true
