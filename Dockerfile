FROM alpine:edge

RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

RUN mkdir /vault
RUN adduser -D -h /vault -u 1001 vault
WORKDIR /vault

RUN cd /tmp \
    && curl -sLo vault.zip https://releases.hashicorp.com/vault/0.5.3/vault_0.5.3_linux_amd64.zip \
    && echo "fddb97507f8b539534620882f3a46984160778950e4884831c0f7c2a82b65f52 *vault.zip" | sha256sum -c - \
    && unzip vault.zip \
    && mv vault /usr/sbin/vault \
    && rm vault.zip
    
USER vault
VOLUME /vault
COPY entrypoint /entrypoint
ENTRYPOINT ["/entrypoint"]
CMD ["vault"]

