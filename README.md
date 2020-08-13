# omniauth-yahoojp-tester-rails5

This is the 'omniauth-yahoojp' sample Rails5 application that work on the docker container. See Also [omniauth-yahoojp](https://github.com/mikanmarusan/omniauth-yahoojp/)

## Installing

Put `.env` file that be described YConnect Client ID and Secret as environmental variables. 

```
YAHOOJP_KEY={Your YConnect Client ID}
YAHOOJP_SECRET={Your YConnect Secret}
```

then, all you have to is to run below and you can access the URL `http://localhost:3000/top`.

```
$ docker-compose build
$ docker-compose up
```


## Requirements

This sample application currently works with:

- Ruby 2.7.1
- Rails 5.2.4.3
- MySQL 5.7.31

If you'd like to change minor version,  you can change the configuration file below:

- Dockerfile
- Gemfile
- docker-compose.yml

