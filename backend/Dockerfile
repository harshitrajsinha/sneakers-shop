FROM golang:1.24.6-alpine3.22 AS builder

# Set up working dir
WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

COPY . .

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

# Build layer 1
RUN go build -o sneaker-backend ./main.go

FROM alpine:latest

# Set working directory
WORKDIR /app

RUN addgroup -S nonroot && adduser -S nonroot -G nonroot

# Copy binary file from build stage
COPY --from=builder /app/sneaker-backend .

EXPOSE 8080

USER nonroot

# Run the app
CMD ["./sneaker-backend"]
