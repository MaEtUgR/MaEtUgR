wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304.zip -d JetBrainsMono
sudo cp -rv JetBrainsMono/fonts/* /usr/share/fonts
fc-cache -f -v
