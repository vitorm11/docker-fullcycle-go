# Builder stage
FROM golang:1.18-alpine AS builder

# Set workdir
WORKDIR /usr/src/app

# Copy go.mod
COPY go.mod ./
RUN go mod download && go mod verify

# Copy hello.go to workdir
COPY hello.go .

# Build hello.go file
RUN go build ./hello.go 

# Final stage
FROM scratch

# Set workdir
WORKDIR /app

# Copy files from builder
COPY --from=builder /usr/src/app .

# Run the command
CMD [ "/app/hello" ]
