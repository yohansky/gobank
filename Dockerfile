# Build stage
FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# Run stage
FROM alpine
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .

EXPOSE 8080
CMD ["/app/main"]

# RUN go install github.com/air-verse/air@latest

# COPY go.mod go.sum ./
# RUN go mod download

# COPY . .

# CMD ["air","-c",".air.toml"]