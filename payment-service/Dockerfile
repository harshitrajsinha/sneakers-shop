FROM golang:1.24.6-alpine3.22 AS builder

# Set up working dir
WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./

COPY . .

# Build layer 1
RUN go build -buildvcs=false -o payment-service.exe
# GOOS=windows GOARCH=amd64 go build -buildvcs=false -o payment-service.exe ./


FROM alpine:latest

# Set working directory
WORKDIR /app

# Copy binary file from build stage
COPY --from=builder /app/payment-service.exe .

EXPOSE 8081

# Run the app
CMD ["./payment-service.exe"]
