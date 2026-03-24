# omniauth-yahoojp-tester-containers

A demonstration Rails application for testing OAuth authentication with Yahoo Japan's YConnect service using the [omniauth-yahoojp](https://github.com/mikanmarusan/omniauth-yahoojp/) gem. Runs on Docker containers.

## Requirements

- Ruby 3.3
- Rails 7.1
- MySQL 8.0
- omniauth-yahoojp ~> 1.0

## Setup

### 1. Create `.env` file

Create a `.env` file in the project root with your Yahoo Japan YConnect credentials:

```
YAHOOJP_KEY={Your YConnect Client ID}
YAHOOJP_SECRET={Your YConnect Secret}
```

### 2. Build and start containers

```bash
$ docker-compose build
$ docker-compose up
```

Access the application at `http://localhost:3000/top`.

## Application Flow

1. **Landing page** (`/top`) — Login page with Yahoo Japan OAuth link
2. **OAuth initiation** (`/auth/yahoojp`) — Redirects to Yahoo Japan for authentication
3. **Callback** (`/auth/yahoojp/callback`) — Displays user information retrieved from Yahoo Japan

### OAuth Configuration

- **Scope**: `openid profile email address`
- **UserInfo Access**: Enabled (`userinfo_access: true`) — retrieves additional user profile information via the UserInfo API

## Testing

```bash
# Run unit tests
$ docker-compose exec rails rails test

# Run system tests (Capybara + Selenium)
$ docker-compose exec rails bundle exec rails test:system
```

## Customization

If you'd like to change the Ruby, Rails, or MySQL versions, modify the following files:

- `Dockerfile`
- `Gemfile`
- `docker-compose.yml`
