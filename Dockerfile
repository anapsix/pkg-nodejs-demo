## this stage creates a common "base" image
## allowing a single line change to base, when required
## common dependencies can be installed here
FROM alpine:3.9 as base
RUN apk add --no-cache libgcc libstdc++

## this stage creates image that builds our NodeJS application
## other build-time dependencies should be installed here
FROM base as build
ARG NODE_VERSION
ENV NODE_VERSION=${NODE_VERSION:-10}
RUN apk add --no-cache nodejs nodejs-npm && \
    npm install -g pkg
COPY ./server.js /src/
WORKDIR /src
RUN \
    TARGETARCH="$(node -e 'console.log(process.arch);')" && \
    echo >&2 "## Generating artifact for Node v${NODE_VERSION}-${TARGETARCH}" && \
    pkg server.js --target node${NODE_VERSION}-alpine-${TARGETARCH}


## this stage produces release-ready artifact
## this is the one we are going to be running
FROM base as release
COPY --from=build /src/server /server
USER nobody
EXPOSE 3000/tcp
CMD /server
