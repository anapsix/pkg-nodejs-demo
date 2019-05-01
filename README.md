# NodeJS pkg'ed application demo

En example of packaging NodeJS application into executable with [pkg][pkg].

It's using a NodeJS "Hello World" [`server.js`][server.js], and [Docker Multi-Stage build][multi-stage] to create Alpine-base Docker image containing application executable.

## Usage
```bash
docker build -t test .
docker images --filter=reference='test:latest'
docker run -it --rm -p 3000:3000 test
```
While container instance is running, checkout http://localhost:3000

[ Link Reference ]::
[pkg]: https://www.npmjs.com/package/pkg
[server.js]: ./server.js
[multi-stage]: https://docs.docker.com/develop/develop-images/multistage-build/
