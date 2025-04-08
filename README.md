# oanhnn/docker-php-unit

> **NOTE**: Now build from `unit:php` image base on offical PHP image (`php:cli`).

[![CI](https://github.com/oanhnn/docker-php-unit/actions/workflows/ci.yml/badge.svg)](https://github.com/oanhnn/docker-php-unit/actions/workflows/ci.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/oanhnn/php)](https://hub.docker.com/r/oanhnn/php)
[![Software License](https://img.shields.io/github/license/oanhnn/docker-php-unit.svg)](LICENSE.md)

## Features

- [x] All images are build from `unit:php` image base on offical PHP image (`php:cli`).
- [x] Install some PHP extensions: bcmath, gd, gmp, intl, opcache, pdo_mysql, pdo_pgsql, pcntl, zip, redis, xdebug (disable by default)
- [x] Publish to [Docker Hub](https://hub.docker.com/r/oanhnn/php) and [GHCR.IO](https://github.com/oanhnn/docker-php/pkgs/container/php)


## Tags.




## Usage

- Use like with official image

```
docker run -d --rm -p 80:80 -v $(pwd):/var/www oanhnn/php:8.3-unit
```

## Contributing

All code contributions must go through a pull request and approved by a core developer before being merged. 
This is to ensure proper review of all the code.

Fork the project, create a feature branch, and send a pull request.

If you would like to help take a look at the [list of issues](https://github.com/oanhnn/docker-php-unit/issues).

## Security Vulnerabilities

Please review [our security policy](../../security/policy) on how to report security vulnerabilities.

## Credits

- [Oanh Nguyen](https://github.com/oanhnn)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
