FROM alpine:3.10 as builder

RUN apk --update --no-cache add python3

WORKDIR /work
COPY . /work
RUN ./setup.py install

FROM alpine:3.10

RUN apk --update --no-cache add python3

COPY --from=builder /usr/sbin/iotop /usr/sbin/iotop
COPY --from=builder /usr/lib/python3.7/site-packages/iotop /usr/lib/python3.7/site-packages/iotop
COPY --from=builder /usr/lib/python3.7/site-packages/iotop-0.6-py3.7.egg-info /usr/lib/python3.6/site-packages/iotop-0.6-py3.7.egg-info

ENTRYPOINT ["/usr/sbin/iotop"]