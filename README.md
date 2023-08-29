# oanhnn/docker-php-unit [Deprecated]

Now NGINX Unit build `unit:php` image base on offical PHP image (`php:cli`).
So that, I don't continue develop this repository.

[![CI](https://github.com/oanhnn/docker-php-unit/actions/workflows/ci.yml/badge.svg)](https://github.com/oanhnn/docker-php-unit/actions/workflows/ci.yml)
[![Software License](https://img.shields.io/github/license/oanhnn/docker-php-unit.svg)](LICENSE.md)

## Features


## Tags.

<table style="border: 1px">
    <tr>
        <th rowspan="2">Version</th>
        <th colspan="7">Variants</th>
    </tr>
    <tr>
        <th>apache</th>
        <th>cli</th>
        <th>fpm</th>
        <th>zts</th>
        <th>cli-alpine</th>
        <th>fpm-alpine</th>
        <th>zts-alpine</th>
    </tr>
    <tr>
        <th>7.0</th>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.0/alpine/Dockerfile" title="7.0-alpine">7.0-alpine</a></td>
        <td>-</td>
        <td>-</td>
    </tr>
    <tr>
        <th>7.1</th>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.1/alpine/Dockerfile" title="7.1-alpine">7.1-alpine</a></td>
        <td>-</td>
        <td>-</td>
    </tr>
    <tr>
        <th>7.2</th>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.2/alpine/Dockerfile" title="7.2-alpine">7.2-alpine</a></td>
        <td>-</td>
        <td>-</td>
    </tr>
    <tr>
        <th>7.3</th>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.3/apache/Dockerfile" title="7.3-apache">7.3-apache</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.3/cli/Dockerfile" title="7.3-cli">7.3-cli</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.3/fpm/Dockerfile" title="7.3-fpm">7.3-fpm</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.3/zts/Dockerfile" title="7.3-zts">7.3-zts</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.3/cli-alpine/Dockerfile" title="7.3-cli-alpine">7.3-cli-alpine</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.3/fpm-alpine/Dockerfile" title="7.3-fpm-alpine">7.3-fpm-alpine</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.3/zts-alpine/Dockerfile" title="7.3-zts-alpine">7.3-zts-alpine</a></td>
    </tr>
    <tr>
        <th>7.4</th>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.4/apache/Dockerfile" title="7.4-apache">7.4-apache</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.4/cli/Dockerfile" title="7.4-cli">7.4-cli</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.4/fpm/Dockerfile" title="7.4-fpm">7.4-fpm</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.4/zts/Dockerfile" title="7.4-zts">7.4-zts</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.4/cli-alpine/Dockerfile" title="7.4-cli-alpine">7.4-cli-alpine</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.4/fpm-alpine/Dockerfile" title="7.4-fpm-alpine">7.4-fpm-alpine</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/7.4/zts-alpine/Dockerfile" title="7.4-zts-alpine">7.4-zts-alpine</a></td>
    </tr>
    <tr>
        <th>8.0</th>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.0/apache/Dockerfile" title="8.0-apache">8.0-apache</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.0/cli/Dockerfile" title="8.0-cli">8.0-cli</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.0/fpm/Dockerfile" title="8.0-fpm">8.0-fpm</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.0/zts/Dockerfile" title="8.0-zts">8.0-zts</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.0/cli-alpine/Dockerfile" title="8.0-cli-alpine">8.0-cli-alpine</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.0/fpm-alpine/Dockerfile" title="8.0-fpm-alpine">8.0-fpm-alpine</a></td>
        <td>-</td>
    </tr>
    <tr>
        <th>8.1</th>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.1/apache/Dockerfile" title="8.1-apache">8.1-apache</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.1/cli/Dockerfile" title="8.1-cli">8.1-cli</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.1/fpm/Dockerfile" title="8.1-fpm">8.1-fpm</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.1/zts/Dockerfile" title="8.1-zts">8.1-zts</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.1/cli-alpine/Dockerfile" title="8.1-cli-alpine">8.1-cli-alpine</a></td>
        <td><a href="https://github.com/oanhnn/docker-php/blob/master/8.1/fpm-alpine/Dockerfile" title="8.1-fpm-alpine">8.1-fpm-alpine</a></td>
        <td>-</td>
    </tr>
</table>


## Usage

- Use like with official image

```
docker run -d --rm -p 9000:9000 -v $(pwd):/var/www oanhnn/php:8.0-fpm
```

## Contributing

All code contributions must go through a pull request and approved by a core developer before being merged. 
This is to ensure proper review of all the code.

Fork the project, create a feature branch, and send a pull request.

If you would like to help take a look at the [list of issues](https://github.com/oanhnn/docker-php/issues).

## Security Vulnerabilities

Please review [our security policy](../../security/policy) on how to report security vulnerabilities.

## Credits

- [Oanh Nguyen](https://github.com/oanhnn)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
