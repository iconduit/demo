APPLICATIONS := $(notdir $(wildcard input/*))
APPLICATION_OUTPUT_DIRS := $(addprefix artifacts/iconduit/,$(APPLICATIONS))

-include .makefiles/Makefile
-include .makefiles/pkg/js/v1/Makefile
-include .makefiles/pkg/js/v1/with-npm.mk

.makefiles/%:
	@curl -sfL https://makefiles.dev/v1 | bash /dev/stdin "$@"

################################################################################

# ci --- Perform tasks that should be run as part of continuous integration.
.PHONY: ci
ci:: artifacts/site

################################################################################

artifacts/iconduit/%: artifacts/link-dependencies.touch $$(shell find input/$$(notdir $$*) -type f)
	@rm -rf "$@"

	$(JS_EXEC) iconduit "input/$*/iconduit.config.json"

artifacts/site: README.md $(APPLICATION_OUTPUT_DIRS)
	@rm -rf "$@"
	@mkdir -p "$@"

	cp -a $? "$@"
