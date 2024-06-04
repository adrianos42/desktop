page:
	rm -rf ../docs/*
	mkdir -p ../docs
	flutter build web -v --wasm
	cp -r -v build/web/* ../docs

android:
	flutter build apk
	flutter install --use-application-binary=build/app/outputs/flutter-apk/app-release.apk

linux:
	flutter build linux --verbose --release
	rm -rf ~/opt/desktop_docs
	mkdir -p ~/opt/desktop_docs
	cp -r build/linux/x64/release/bundle/* ~/opt/desktop_docs/
	cp assets/icon_transparent.svg ~/opt/desktop_docs/icon.svg
	rm -f ~/.local/share/applications/desktop_docs.desktop
	@echo "#!/usr/bin/env xdg-open" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "[Desktop Entry]" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "Version=1.0" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "Terminal=false" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "Type=Application" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "Name=Desktop Docs" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "Exec=${HOME}/opt/desktop_docs/desktop" >> ~/.local/share/applications/desktop_docs.desktop
	@echo "Icon=${HOME}/opt/desktop_docs/icon.svg" >> ~/.local/share/applications/desktop_docs.desktop

.PHONY: linux android