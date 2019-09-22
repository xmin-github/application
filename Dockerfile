FROM golang:1.10.1
WORKDIR /go/src/github.com/xmin/application
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest  
LABEL Maintainer xmin
LABEL Environment production
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/xmin/application/app .
COPY static static
CMD ["./app"] 