# docker-httpsqs

> HTTPSQS (HTTP Simple Queue Service)

> Docker for httpsqs. Detail: http://code.google.com/p/httpsqs

## Pull the docker

```sh
$ docker pull toomee/httpsqs
```

## Config

To set the docker environment to add params for httpsqs.

```
-l <ip_addr>  -- HTTPSQS_PARAM_L
-p <num>      -- HTTPSQS_PARAM_P
-x <path>     -- HTTPSQS_PARAM_X
-t <second>   -- HTTPSQS_PARAM_T
-s <second>   -- HTTPSQS_PARAM_S
-c <num>      -- HTTPSQS_PARAM_C
-m <size>     -- HTTPSQS_PARAM_M
-i <file>     -- HTTPSQS_PARAM_I
-a <auth>     -- HTTPSQS_PARAM_A
```

## Examples

```sh
$ docker run -d -e HTTPSQS_PARAM_A=123456 -p 1218:1218 toomee/httpsqs
```
