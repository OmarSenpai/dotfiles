cp -r Wallpapers ~/Downloads
cp -r Assets/fonts /usr/share/fonts

#enables RPM fusion repositories
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#enables cisco media repos containing the h264 codec + installs it alongside other codes + ffmpeg
#(--allowerasing) flag to resolve conflicting packages
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
sudo dnf group install multimedia --allowerasing
sudo dnf install ffmpeg --allowerasing

sudo dnf install fastfetch
