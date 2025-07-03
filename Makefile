UV_RUN := uv run
FOLDERS= cicd_template
PROJ= cicd_template
NC=\033[0m # No Color

.PHONY: install autolint lint lint-ruff shell precommit uv-precommit \
		install-dev test report-coverage

test:
		${UV_RUN} coverage erase
		${UV_RUN} coverage run --branch -m pytest tests ${PROJ} \
				--junitxml=junit/test-results.xml -v

install: install-dev
		uv sync

lint:
		make autolint
		make lint-ruff
		make lint-mypy

install-dev:
		cp tools/pre-commit .git/hooks
		chmod +x .git/hooks/pre-commit

autolint:
		@${UV_RUN} ruff format ${FOLDERS}

lint-ruff:
		@echo "\n${BLUE}Running ruff...${NC}\n"
		@${UV_RUN} ruff check . --fix

lint-mypy:
		@echo "\n${BLUE}Running mypy...${NC}\n"
		${UV_RUN} mypy --show-error-codes ${PROJ}

precommit: uv-precommit lint

uv-precommit:
		${UV_RUN} pre-commit run --all-files

report-coverage:
		${UV_RUN} coverage report
		${UV_RUN} coverage html
		${UV_RUN} coverage xml
