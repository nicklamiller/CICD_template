POETRY_RUN := poetry run
FOLDERS= cicd_template
PROJ= cicd_template
NC=\033[0m # No Color

.PHONY: install autolint lint lint-ruff shell precommit poetry-precommit \
		install-dev test report-coverage

test:
		${POETRY_RUN} coverage erase
		${POETRY_RUN} coverage run --branch -m pytest tests ${PROJ} \
				--junitxml=junit/test-results.xml -v

install: install-dev
		poetry install --with dev

lint:
		make autolint
		make lint-ruff
		make lint-mypy

install-dev:
		cp tools/pre-commit .git/hooks
		chmod +x .git/hooks/pre-commit

autolint:
		@${POETRY_RUN} ruff format ${FOLDERS}

lint-ruff:
		@echo "\n${BLUE}Running ruff...${NC}\n"
		@${POETRY_RUN} ruff check . --fix

lint-mypy:
		@echo "\n${BLUE}Running mypy...${NC}\n"
		${POETRY_RUN} mypy --show-error-codes ${PROJ}

shell:
		poetry shell

precommit: poetry-precommit lint

poetry-precommit:
		poetry run pre-commit run --all-files

report-coverage:
		${POETRY_RUN} coverage report
		${POETRY_RUN} coverage html
		${POETRY_RUN} coverage xml
