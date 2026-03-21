FROM golang:1.24.6-alpine3.22 AS builder

# Set up working dir
WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Build layer 1
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go build -o payment-service ./main.go
# GOOS=windows GOARCH=amd64 go build -buildvcs=false -o payment-service.exe ./


FROM alpine:latest

# Set working directory
WORKDIR /app

RUN addgroup -S nonroot && adduser -S nonroot -G nonroot

# Copy binary file from build stage
COPY --from=builder /app/payment-service .

EXPOSE 8081

USER nonroot

# Run the app
CMD ["./payment-service"]
