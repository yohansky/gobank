SHELL=/bin/bash

up:
	@echo Starting Docker images...
	docker-compose up --build
	@echo Docker images started!

down:
	@echo Stopping docker compose...
	docker-compose down
	@echo Done!

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5438/postgres?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5438/postgres?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5438/postgres?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5438/postgres?sslmode=disable" -verbose down 1

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

proto:
	@echo remove Existing Proto file
	rm -f pb/*.go
	@echo Generating proto
	protoc \
	-I="/c/aplikasi/protoc-3.20.0-win64/include" \
	--proto_path=proto --go_out=pb --go_opt=paths=source_relative \
	--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	proto/*.proto

evans:
	@echo running evans CLI
	evans --host localhost --port 9090 -r repl

.PHONY: proto evans