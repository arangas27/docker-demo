FROM busybox:latest

ADD	./build-output.sh      /tmp/

RUN ls -la
RUN chmod +x /tmp/build-output.sh
RUN sh /tmp/build-output.sh
