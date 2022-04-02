SHELL = /bin/bash
package = shagen/piipaa

.DEFAULT_GOAL := all
isort = isort src test
black = black -S -l 120 --target-version py38 src test

.PHONY: build
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
	@cat src/piipaa/_version.py

.PHONY: install
install:
	python -m pip install -U pip wheel
	python -m pip install -r test/requirements.txt
	python -m pip install -U .

.PHONY: install-all
install-all: install
	python -m pip install -r test/requirements-dev.txt

.PHONY: isort
format:
	$(isort)
	$(black)

.PHONY: init
init:
	python -m pip install -r test/requirements.txt
	python -m pip install -r test/requirements-dev.txt

.PHONY: lint
lint: build
	twine check --strict dist/*
	flake8 src/ test/
	$(isort) --check-only --df
	$(black) --check --diff

.PHONY: mypy
mypy:
	mypy src

.PHONY: test
test: clean install
	tox -- --cov=piipaa --log-format="%(levelname)s %(message)s"
#	pytest --cov=piipaa --log-format="%(levelname)s %(message)s" --asyncio-mode=strict

.PHONY: testcov
testcov: test
	@echo "building coverage html"
	@coverage html

.PHONY: all
all: lint mypy test

.PHONY: clean
clean:
	@rm -rf `find . -name __pycache__`
	@rm -f `find . -type f -name '*.py[co]' `
	@rm -f `find . -type f -name '*~' `
	@rm -f `find . -type f -name '.*~' `
	@rm -rf .cache htmlcov *.egg-info src/*.egg-info build dist/*
	@rm -f .coverage .coverage.*
	@python -m pip uninstall -y piipaa
