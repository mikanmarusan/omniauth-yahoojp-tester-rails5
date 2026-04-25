# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Application Overview

This is a Rails 7 demonstration application for testing OAuth authentication with Yahoo Japan's YConnect service using the `omniauth-yahoojp` gem. The app provides a complete OAuth flow example, from login initiation to displaying user information retrieved from Yahoo Japan.

## Development Commands

### Docker Development (Primary Workflow)
```bash
# Build containers
docker-compose build

# Start the application
docker-compose up

# Run Rails commands inside container
docker-compose exec rails rails console
docker-compose exec rails rails test
docker-compose exec rails bundle exec rails test:system
```

### Database Commands
```bash
# Database operations (inside container)
docker-compose exec rails rails db:create
docker-compose exec rails rails db:migrate
```

### Testing
- **Framework**: Rails default (Minitest)
- **System tests**: Capybara + Selenium WebDriver
- **Run tests**: `docker-compose exec rails rails test`
- **System tests**: `docker-compose exec rails bundle exec rails test:system`

## Application Architecture

### Core Flow
1. **Landing**: `/top` - Login page with Yahoo Japan OAuth link
2. **OAuth**: `/auth/yahoojp` - Initiates Yahoo Japan authentication
3. **Callback**: `/auth/yahoojp/callback` - Processes OAuth response and displays user data

### Key Components
- **Sessions Controller** (`app/controllers/sessions_controller.rb`): Handles OAuth flow
- **OAuth Config** (`config/initializers/omniauth.rb`): Yahoo Japan provider setup
- **Routes** (`config/routes.rb`): Simple routing for top and callback endpoints

### Environment Setup
Requires host shell environment variables (no `.env` file):
```bash
export YAHOOJP_KEY={Your YConnect Client ID}
export YAHOOJP_SECRET={Your YConnect Secret}
# Optional: export YAHOOJP_USERINFO_ACCESS=false  # to skip UserInfo API
```
Credentials are injected into the container via Docker Compose `environment:` passthrough.

### Dependencies
- **Rails 7.1+** with Ruby 3.3
- **MySQL 8.0** database
- **OmniAuth gems**: `omniauth`, `omniauth-oauth2`, `omniauth-yahoojp`
- **Containerized** with Docker Compose

## Upstream Gem Dependency

This app is a downstream consumer of the `omniauth-yahoojp` gem ([GitHub](https://github.com/mikanmarusan/omniauth-yahoojp)).

### Gem API Surface Used

**Provider config** (`config/initializers/omniauth.rb`):
- `provider :yahoojp` with options: `scope`, `userinfo_access`

**Auth hash consumed** (`app/controllers/sessions_controller.rb`, `app/views/sessions/callback.html.erb`):
- `auth.uid`
- `auth.info`: sub, name, given_name, family_name, gender, zoneinfo, locale, birthdate, nickname, picture, email, email_verified, plus Japanese name variants (given_name_ja_kana_jp, given_name_ja_hani_jp, family_name_ja_kana_jp, family_name_ja_hani_jp)
- `auth.info.address`: country, postal_code, region, locality, formatted
- `auth.credentials`: token, refresh_token, expires_at, id_token
- `auth.extra`, `auth.extra.id_token_claims`

### Cross-Project Update Rules

When `omniauth-yahoojp` changes its API:
1. **New provider options** (e.g., `userinfo_access`) -> update `config/initializers/omniauth.rb`
2. **New/changed auth hash fields** -> update controller and view to display them
3. **Removed or renamed fields** -> update controller and view to remove/rename references
4. **Gem version bump** -> update `Gemfile`

### Git Operations

This sample app has its own Git repository. All Git operations (branch, commit, push, PR) for this app must be performed in this repository (`omniauth-yahoojp-tester-containers`), NOT in the upstream gem repository (`omniauth-yahoojp`).

## Development Notes

- Application runs on port 3000 via Docker Compose
- Access via: `http://localhost:3000/top`
- OAuth scope: `openid profile email address`
- All development should use Docker Compose commands
- No complex business logic - focused solely on OAuth demonstration