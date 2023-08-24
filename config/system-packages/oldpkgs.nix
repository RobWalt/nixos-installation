{ oldpkgs, ... }:
{
  inherit (oldpkgs)
    docker# some regressions in 20.10.25 which made it impossible to do `docker run` -> 'http: invalid Host header'
    docker-compose# keep this in sync with docker
    docker-client
    ;
}
