FROM openjdk:8-alpine

ARG PLUGIN_SDK_VERSION

RUN apk --update add \
      --virtual build-dependencies \
      curl \
      tar && \
    mkdir -p /opt/atlassian/plugin-sdk && \
    curl "https://packages.atlassian.com/maven/repository/public/com/atlassian/amps/atlassian-plugin-sdk/${PLUGIN_SDK_VERSION}/atlassian-plugin-sdk-${PLUGIN_SDK_VERSION}.tar.gz" \
      | tar --extract --gzip --strip-components=1 --directory /opt/atlassian/plugin-sdk && \
    apk del build-dependencies

ENV PATH /opt/atlassian/plugin-sdk/bin:$PATH
