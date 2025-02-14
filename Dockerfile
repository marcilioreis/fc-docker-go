FROM golang:1.17.2-alpine3.14 AS builder
WORKDIR /app
COPY hello.go ./

ENV CGO_ENABLED=0  
RUN go mod init github.com/marcilioreis/fc-docker-go && \
    go build --ldflags='-w -s -f -extldflags "-static"' \
    -a -o fc-docker-go hello.go && \
    rm hello.go

FROM scratch
WORKDIR /app
COPY --from=builder /app ./
CMD ["./fc-docker-go"]

