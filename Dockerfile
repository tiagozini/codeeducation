FROM golang:1.17-alpine as builder

WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .

RUN go build -v -o /usr/local/bin/app ./...

FROM scratch

COPY --from=builder /usr/local/bin/app /

CMD ["/app"]
