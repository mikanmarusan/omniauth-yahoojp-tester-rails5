FROM ruby:3.3

RUN apt-get update -qq && apt-get install -y nodejs shared-mime-info

RUN mkdir /myapp
WORKDIR /myapp

COPY . /myapp/

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
