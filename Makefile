SHELL=/bin/bash

up:
	@echo Starting Docker images...
	docker-compose up -d
	@echo Docker images started!

down:
	@echo Stopping docker compose...
	docker-compose down
	@echo Done!

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5438/postgres?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5438/postgres?sslmode=disable" -verbose down

sqlc:
	sqlc generate
	@echo Done!

test:
	go test -v -cover ./...
	@echo Done!

server:
	@echo Initializing Server
	go run main.go

mock:
	@echo Generate mock file
	mockgen -package mockdb -destination db/mock/store.go gobank/db/sqlc Store