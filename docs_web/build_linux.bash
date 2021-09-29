#!/usr/bin/bash

flutter build linux --verbose --release
rm -rf ~/opt/desktop_docs
mkdir -p ~/opt/desktop_docs
cp -r build/linux/x64/release/bundle/* ~/opt/desktop_docs/
cp assets/icon_transparent.svg ~/opt/desktop_docs/icon.svg
echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Terminal=false
Type=Application
Name=Desktop Docs" >> ~/.local/share/applications/desktop_docs.desktop
echo "" >> ~/.local/share/applications/desktop_docs.desktop
echo "Exec=$HOME/opt/desktop_docs/docs_web" >> ~/.local/share/applications/desktop_docs.desktop
echo "Icon=$HOME/opt/desktop_docs/icon.svg" >> ~/.local/share/applications/desktop_docs.desktop