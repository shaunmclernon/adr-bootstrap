#
# Makefile to automate tasks for generating ADRs
# 
.PHONY: help adr adr-new adr-init pre-init
default: help

BASE_DIR ?= $(PWD)

# Where you want the decisions to be recorded!
ADR_DOCS_BASE=doc
ADR_DOCS=$(ADR_DOCS_BASE)/architecture/decisions

# Check for dependencies
DOT := $(shell command -v dot 2> /dev/null)
ADR_TOOLS := $(shell command -v adr 2> /dev/null)

# NOTE: By default, ADR uses American date formats. If you want dates in 
# British format either export the environment value of ADR_DATE or 
# supply it prior to running the command.
BRITISH_DATE := $(shell date +%d-%m-%Y)

# Display the help text dynamically.
# Any line with a ## will be rendered as part of the help text.
help: Makefile
	@echo "Architectural Decision Record (ADRs) task generator"
	@echo ""
	@echo "Options:"
	@sed -n 's/^##//p' $<

# Check to see if the required dependencies are installed, if not then fail fast.
pre-init:
ifndef DOT
	$(error "ERROR: dot is not available please install graphviz - ie. brew install graphviz")
endif
ifndef ADR_TOOLS
	$(error "ERROR: adr is not available please install adr-tools - ie. brew install adr-tools")
endif
	@echo "Dependencies installed!"

# This task will initialise the adr folder (if it doesn't exist)
adr-init: pre-init
	@if [ ! -d "$(ADR_DOCS)" ]; then ADR_DATE=$(BRITISH_DATE) adr init $(ADR_DOCS); fi

## adr                            : Generate a new ADR index, graph and README.md
adr: adr-init adr-graph adr-readme
	@echo "\n$(ADR_DOCS)/README.md has been regenerated"

## adr-new DECISON="new decision" : Generate a new decision record
DECISION?=rename_this_decision
adr-new: adr-init
	ADR_DATE=$(BRITISH_DATE) adr new $(DECISION)

## adr-graph (optional)           : Dynamically generate the visual graph of the ADRs
adr-graph:
	adr generate graph > $(ADR_DOCS)/graph.dot
	dot -Tpng $(ADR_DOCS)/graph.dot -o $(ADR_DOCS)/graph.png

## adr-readme (optional)          : Dynamically generate the ADR readme
adr-readme:
	adr generate toc > $(ADR_DOCS)/README.md
	@echo "\nVisualise the above records in the graph form below:" >> $(ADR_DOCS)/README.md
	@echo "\n![graph](graph.png)" >> $(ADR_DOCS)/README.md

clean:
	@rm -rf $(ADR_DOCS_BASE)

test: clean
	bats tests