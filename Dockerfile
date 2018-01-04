FROM mhart/alpine-node:6

RUN npm install -g nodemon yarn

RUN apk add --no-cache \
            xvfb \
            bash \
            # Additionnal dependencies for better rendering
            ttf-freefont \
            fontconfig \
            dbus \
            --update tini \
            git \
    && \

    # Install wkhtmltopdf from `testing` repository
    apk add qt5-qtbase-dev \
            wkhtmltopdf \
            --no-cache \
            --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted

    # Wrapper for xvfb
RUN mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin && \
    echo $'#!/usr/bin/env sh\n\
     DISPLAY=:0.0 wkhtmltopdf-origin $@ \
' > /usr/bin/wkhtmltopdf && \
    chmod +x /usr/bin/wkhtmltopdf

