wget https://d13lb3tujbc8s0.cloudfront.net/onlineinstallers/qt-unified-linux-x64-4.5.1-online.run
chmod +x qt-unified-linux-x64-4.5.1-online.run
./qt-unified-linux-x64-4.5.1-online.run
# Leave path and everything else default
# On the "Select Components" tab choose Qt > Qt 5.15.2 > Desktop gcc 64-bit & Qt Charts
# Next, next, install

sudo apt install speech-dispatcher libudev-dev libsdl2-dev patchelf build-essential curl

git clone git@github.com:mavlink/qgroundcontrol.git --recursive -j8
cd qgroundcontrol
mkdir build
cd build
/home/$USER/Qt/5.15.2/gcc_64/bin/qmake ../
cd ..
make build/ -j12 && ./build/staging/QGroundControl # roughly 9 minutes build time
