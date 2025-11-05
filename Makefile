SHELL=cmd.exe

up:
	@echo Starting Docker images...
	docker-compose up -d
	@echo Docker images started!

down:
	@echo Stopping docker compose...
	docker-compose down
	@echo Done!

sqlc:
	sqlc generate
	@echo Done!

# .PHONY: 