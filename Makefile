SOURCE="https://github.com/jgraph/drawio-desktop/releases/download/v13.0.1/draw.io-x86_64-13.0.1.AppImage"
DESTINATION="Drawio.AppImage"

all:
	echo "Building: $(OUTPUT)"
	wget --output-document=$(DESTINATION)  --continue $(SOURCE)
	chmod +x $(DESTINATION)
	./$(DESTINATION) --appimage-extract
	rm -f squashfs-root/drawio.png
	cp -r icon.svg squashfs-root/drawio.svg
	export ARCH=x86_64 && bin/appimagetool.AppImage squashfs-root $(DESTINATION)
	rm -rf squashfs-root
