POETRY_RUN := poetry run
FOLDERS= src
NC=\033[0m # No Color

.PHONY: install autolint lint lint-flake8 shell precommit poetry-precommit \
		install-dev

test:
		${POETRY_RUN} coverage erase
		${POETRY_RUN} coverage run --branch -m pytest tests ${PROJ} \
				--junitxml=junit/test-results.xml -v

install: install-dev
		poetry install

lint:
		make autolint
		make lint-flake8

install-dev:
		cp tools/pre-commit .git/hooks
		chmod +x .git/hooks/pre-commit

autolint:
		@${POETRY_RUN} autopep8 -r -i ${FOLDERS}
		@${POETRY_RUN} unify -r -i ${FOLDERS}
		@${POETRY_RUN} isort ${FOLDERS}

lint-flake8:
		@echo "\n${BLUE}Running flake8...${NC}\n"
		@${POETRY_RUN} flake8 .

shell:
		poetry shell

precommit: poetry-precommit lint

poetry-precommit:
		poetry run pre-commit run --all-files
