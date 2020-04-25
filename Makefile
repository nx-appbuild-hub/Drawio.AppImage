SOURCE="https://github.com/jgraph/drawio-desktop/releases/download/v13.0.1/draw.io-x86_64-13.0.1.AppImage"
DESTINATION="Drawio.AppImage"

all:
	echo "Building: $(OUTPUT)"
	wget --output-document=$(DESTINATION)  --continue $(SOURCE)
	chmod +x $(DESTINATION)
	./$(DESTINATION) --appimage-extract
	mkdir -p AppDir/opt/application
	cp -r squashfs-root/* AppDir/opt/application
	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(DESTINATION)
	rm -rf AppDir/opt
	rm -rf squashfs-root
