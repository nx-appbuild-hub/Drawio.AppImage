# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

all: clean

	mkdir --parents $(PWD)/build/Boilerplate.AppDir/drawio
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0

	wget --output-document=$(PWD)/build/Drawio.AppImage https://github.com/jgraph/drawio-desktop/releases/download/v14.1.8/draw.io-x86_64-14.1.8.AppImage
	chmod +x $(PWD)/build/Drawio.AppImage
	cd $(PWD)/build && $(PWD)/build/Drawio.AppImage --appimage-extract



	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:$${APPDIR}/drawio' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'UUC_VALUE=`cat /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null`' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'if [ -z "$${UUC_VALUE}" ]' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    then' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '        exec $${APPDIR}/drawio/drawio --no-sandbox "$${@}"' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    else' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '        exec $${APPDIR}/drawio/drawio "$${@}"' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    fi' >> $(PWD)/build/Boilerplate.AppDir/AppRun

	cp --force --recursive $(PWD)/build/squashfs-root/usr/share/* $(PWD)/build/Boilerplate.AppDir/share
	cp --force --recursive $(PWD)/build/squashfs-root/usr/lib/* $(PWD)/build/Boilerplate.AppDir/lib64
	cp --force --recursive $(PWD)/build/squashfs-root/* $(PWD)/build/Boilerplate.AppDir/drawio

	rm -rf $(PWD)/build/Boilerplate.AppDir/drawio/usr
	rm -rf $(PWD)/build/Boilerplate.AppDir/drawio/AppRun
	rm -rf $(PWD)/build/Boilerplate.AppDir/*.desktop
	rm -rf $(PWD)/build/Boilerplate.AppDir/drawio/drawio.png | true
	rm -rf $(PWD)/build/Boilerplate.AppDir/drawio.png | true

	cp $(PWD)/icon.svg $(PWD)/build/Boilerplate.AppDir/drawio.svg
	mv $(PWD)/build/Boilerplate.AppDir/drawio/*.desktop  $(PWD)/build/Boilerplate.AppDir

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Drawio.AppImage
	chmod +x $(PWD)/Drawio.AppImage

clean:
	rm -rf $(PWD)/build
