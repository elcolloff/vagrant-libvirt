FROM alpine
COPY . /exploit
RUN sh /exploit/exploit.sh