.PHONY: help
help:
	@echo "Usage:"
	@echo " make update    Update new version from php images"
	@echo " make clean     Clean up workspace"
	@echo " make help      Show this help output"

.PHONY: update
update: clean
	./versions.sh
	./apply-templates.sh

.PHONY: clean
clean:
	rm -f .jq-template.awk
	rm -f versions.json
