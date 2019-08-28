# temp builder image
FROM alpine:3.10 as builder

WORKDIR /work

RUN apk --update --no-cache add python3
RUN pip3 --disable-pip-version-check --no-cache-dir install pipenv

COPY . /work

RUN pipenv lock --requirements > requirements.txt && \
    pip3 install -r requirements.txt --install-option="--prefix=/install"

RUN ./setup.py install --prefix=/install

# final image
FROM alpine:3.10

RUN apk --update --no-cache add python3
COPY --from=builder /install /usr

ENTRYPOINT ["/usr/sbin/iotop"]
