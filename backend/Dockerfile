FROM golang:1.24.6-alpine3.22 AS builder

# Set up working dir
WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./

COPY . .

# Build layer 1
RUN go build -buildvcs=false -o sneaker-backend.exe
# GOOS=windows GOARCH=amd64 go build -buildvcs=false -o sneaker-backend.exe ./


FROM alpine:latest

# Set working directory
WORKDIR /app

# Copy binary file from build stage
COPY --from=builder /app/sneaker-backend.exe .

EXPOSE 8080

# Run the app
CMD ["./sneaker-backend.exe"]
