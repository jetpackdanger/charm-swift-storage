#!/usr/bin/make
PYTHON := /usr/bin/env python

lint:
	@tox -e pep8

test:
	@echo Starting unit tests...
	@tox -e py27

functional_test:
	@echo Starting Amulet tests...
	@tox -e func27

bin/charm_helpers_sync.py:
	@mkdir -p bin
	@curl -o bin/charm_helpers_sync.py https://raw.githubusercontent.com/juju/charm-helpers/master/tools/charm_helpers_sync/charm_helpers_sync.py

sync: bin/charm_helpers_sync.py
	@$(PYTHON) bin/charm_helpers_sync.py -c charm-helpers-hooks.yaml
	@$(PYTHON) bin/charm_helpers_sync.py -c charm-helpers-tests.yaml

publish: lint test
	bzr push lp:charms/swift-storage
	bzr push lp:charms/trusty/swift-storage

.PHONY: lint test functional_test sync publish
