SHELL = /bin/bash
package = shagen/piipaa

.DEFAULT_GOAL := all
isort = isort src test
black = black -S -l 120 --target-version py38 src test

.PHONY: bui8ld
build: clean
	@pyproject-build
	@unzip -l dist/*.whl
	@echo "## Checksums"
	@echo "### Source Archive"
	@echo '```'
	@md5sum dist/*.tar.gz | sed "s/^/md5:/g;" 
	@shasum dist/*.tar.gz | sed "s/^/sha1:/g;" 
	@sha256sum dist/*.tar.gz | sed "s/^/sha256:/g;" 
	@sha384sum dist/*.tar.gz | sed "s/^/sha384:/g;" 
	@sha512sum dist/*.tar.gz | sed "s/^/sha512:/g;" 
	@echo '```'
	@echo "### Wheel"
	@echo '```'
	@md5sum dist/*.whl | sed "s/^/md5:/g;"
	@shasum dist/*.whl | sed "s/^/sha1:/g;"
	@sha256sum dist/*.whl | sed "s/^/sha256:/g;"
	@sha384sum dist/*.whl | sed "s/^/sha384:/g;"
	@sha512sum dist/*.whl | sed "s/^/sha512:/g;"
	@echo '```'
	@printf "Release name is: %s\n" "$$(git-release-name $$(git rev-parse HEAD))"
	@cat src/pipa/_version.py

.PHONY: install
install:
	pip install -U pip wheel
	pip install -r test/requirements.txt
	pip install -U .

.PHONY: install-all
install-all: install
	pip install -r test/requirements-dev.txt

.PHONY: isort
format:
	$(isort)
	$(black)

.PHONY: init
init:
	pip install -r test/requirements.txt
	pip install -r test/requirements-dev.txt

.PHONY: lint
lint:
	python setup.py check -ms
	flake8 src/ test/
	$(isort) --check-only --df
	$(black) --check --diff

.PHONY: mypy
mypy:
	mypy src

.PHONY: test
test: clean install
	pytest --cov=piipaa --log-format="%(levelname)s %(message)s" --asyncio-mode=strict

.PHONY: testcov
testcov: test
	@echo "building coverage html"
	@coverage html

.PHONY: all
all: lint mypy testcov

.PHONY: clean
clean:
	@rm -rf `find . -name __pycache__`
	@rm -f `find . -type f -name '*.py[co]' `
	@rm -f `find . -type f -name '*~' `
	@rm -f `find . -type f -name '.*~' `
	@rm -rf .cache htmlcov *.egg-info src/*.egg-info build dist/*
	@rm -f .coverage .coverage.*
	@python setup.py clean
