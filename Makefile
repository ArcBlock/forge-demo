TOP_DIR=.
VERSION=$(strip $(shell cat version))

PROTOCOLS=blog cert

FORGE_COMPILER_VERSION=$(shell curl -s https://releases.arcblock.io/forge-compiler/latest.json | jq -r .latest)
FORGE_COMPILER=$(shell which forge-compiler)

ifeq ($(FORGE_COMPILER),)
FORGE_COMPILER=/tmp/forge-compiler
endif

build-protocol: clean-protocol
	@echo "Building all tx protocols with $(FORGE_COMPILER)..."
	@for path in $(PROTOCOLS) ; do \
		cd protocols/$$path; $(FORGE_COMPILER) config.yml; cd ../..; \
	done

clean-protocol:
	@echo "Cleaning all tx protocols..."
	@for path in $(PROTOCOLS) ; do \
		cd protocols/$$path; rm -rf beams pipe proto *.itx.json; cd ../..; \
	done

.PHONY: build-protocol clean-protocol
