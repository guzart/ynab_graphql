docker:
	docker build . -t ynab_graphql
	docker build -f Dockerfile.dev -t ynab_graphql_dev .

.PHONY: all
