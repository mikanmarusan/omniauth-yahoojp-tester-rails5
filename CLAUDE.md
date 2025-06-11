# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Application Overview

This is a Rails 5 demonstration application for testing OAuth authentication with Yahoo Japan's YConnect service using the `omniauth-yahoojp` gem. The app provides a complete OAuth flow example, from login initiation to displaying user information retrieved from Yahoo Japan.

## Development Commands

### Docker Development (Primary Workflow)
```bash
# Build containers
docker-compose build

# Start the application
docker-compose up

# Run Rails commands inside container
docker-compose exec web rails console
docker-compose exec web rails test
docker-compose exec web bundle exec rails test:system
```

### Database Commands
```bash
# Database operations (inside container)
docker-compose exec web rails db:create
docker-compose exec web rails db:migrate
```

### Testing
- **Framework**: Rails default (Minitest)
- **System tests**: Capybara + Selenium WebDriver
- **Run tests**: `docker-compose exec web rails test`
- **System tests**: `docker-compose exec web bundle exec rails test:system`

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
Requires `.env` file with Yahoo Japan OAuth credentials:
```
YAHOOJP_KEY={Your YConnect Client ID}
YAHOOJP_SECRET={Your YConnect Secret}
```

### Dependencies
- **Rails 5.2.4.3** with Ruby 2.7.1
- **MySQL 5.7.31** database
- **OmniAuth gems**: `omniauth`, `omniauth-oauth2`, `omniauth-yahoojp`
- **Containerized** with Docker Compose

## Development Notes

- Application runs on port 3000 via Docker Compose
- Access via: `http://localhost:3000/top`
- OAuth scope: `openid profile email address`
- All development should use Docker Compose commands
- No complex business logic - focused solely on OAuth demonstration