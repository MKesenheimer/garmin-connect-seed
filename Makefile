include properties.mk

#appName = $(shell grep --color=never entry manifest.xml | sed -n 's/.*entry="\([^"]*\).*/\1/')
appName = $(shell ./appName.sh)
#devices = $(shell grep --color=never 'iq:product id' manifest.xml | sed 's/.*iq:product id="\([^"]*\).*/\1/')
devices = $(shell ./devices.sh)

#JAVA_OPTIONS = JDK_JAVA_OPTIONS="--add-modules=java.xml.bind"
JAVA_OPTIONS = JDK_JAVA_OPTIONS=""

build:
	$(SDK_HOME)/bin/monkeyc \
	--jungles ./monkey.jungle \
	--device $(DEVICE) \
	--output bin/$(appName).prg \
	--private-key $(PRIVATE_KEY) \
	--warn

buildall:
	@for device in $(devices); do \
		echo "-----"; \
		echo "Building for" $$device; \
    $(SDK_HOME)/bin/monkeyc \
		--jungles ./monkey.jungle \
		--device $$device \
		--output bin/$(appName)-$$device.prg \
		--private-key $(PRIVATE_KEY) \
		--warn; \
	done

run: build
	@$(SDK_HOME)/bin/connectiq &&\
	sleep 3 &&\
	$(JAVA_OPTIONS) \
	$(SDK_HOME)/bin/monkeydo bin/$(appName).prg $(DEVICE)

deploy: build
	@cp bin/$(appName).prg $(DEPLOY)

package:
	@$(SDK_HOME)/bin/monkeyc \
	--jungles ./monkey.jungle \
	--package-app \
	--release \
	--output bin/$(appName).iq \
	--private-key $(PRIVATE_KEY) \
	--warn
