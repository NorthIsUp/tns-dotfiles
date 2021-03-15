FROM alpine
RUN apk add --no-cache \
    zsh \
    pcre-dev \
    curl \
    git \
    exa

ENV TERM xterm

WORKDIR /root

COPY zshrc .zshrc

CMD [ "zsh" ]
