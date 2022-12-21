POETRY_RUN := poetry run
FOLDERS= src
NC=\033[0m # No Color

.PHONY: install autolint lint lint-flake8 shell

install:
		poetry install

lint:
		make autolint
		make lint-flake8

autolint:
		@${POETRY_RUN} autopep8 -r -i ${FOLDERS}
		@${POETRY_RUN} unify -r -i ${FOLDERS}
		@${POETRY_RUN} isort ${FOLDERS}

lint-flake8:
		@echo "\n${BLUE}Running flake8...${NC}\n"
		@${POETRY_RUN} flake8 .

shell:
		poetry shell
