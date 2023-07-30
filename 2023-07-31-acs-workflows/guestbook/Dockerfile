FROM golang as builder
COPY main.go /guestbook/
COPY go.mod /guestbook/
COPY go.sum /guestbook/
RUN cd /guestbook && go build

FROM docker.io/ubuntu:jammy-20221130

COPY --from=builder /guestbook/guestbook /app/guestbook

ADD public/index.html /app/public/index.html
ADD public/script.js /app/public/script.js
ADD public/style.css /app/public/style.css
ADD public/jquery.min.js /app/public/jquery.min.js

WORKDIR /app
CMD ["./guestbook"]
EXPOSE 3000
