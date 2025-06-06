# BlogDjango

A modern Django-based blog application with social authentication, REST API, and Docker support.

## Features

- User authentication (including Google and VK social login)
- Blog posts and comments
- REST API (with DRF and drf-spectacular)
- Tagging (django-taggit)
- Admin panel
- Responsive UI with Bootstrap 5
- Dockerized for easy local development
- Makefile for common project tasks

## Requirements

- Docker & Docker Compose
- Python 3.12+ (for local development without Docker)

## Quick Start (with Docker)

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd BlogDjango
   ```
2. **Copy and edit the .env file:**
   Make sure to set your secrets and social auth keys.
3. **First run (build images and start containers):**
   ```bash
   make up_firstrun
   ```
   For subsequent runs, you can use:
   ```bash
   make up
   # or for logs in console
   make up_console_logs
   ```
   > **Note:** Migrations and superuser creation are handled automatically on container startup (see `docker-compose.yml`).
4. **Access the app:**
   - Blog: http://localhost:8000/
   - Admin: http://localhost:8000/admin/

## Main Makefile Commands

- `make up` — Start the development environment (detached)
- `make up_console_logs` — Start and show logs in console
- `make down` — Stop and remove containers
- `make build` — Build or rebuild services
- `make migrate` — Apply database migrations
- `make superuser` — Create a superuser
- `make backup` — Backup the database to ./backups/
- `make restore` — Restore the latest backup
- `make clean` — Full cleanup (down + remove volumes)
- `make resetdb` — Reset database schema

## Environment Variables (.env)

- `DJANGO_SECRET_KEY` — Django secret key
- `DJANGO_DEBUG` — Debug mode (True/False)
- `DJANGO_ALLOWED_HOSTS` — Allowed hosts
- `DB_ENGINE` — Database engine (should be django.db.backends.postgresql)
- `DB_NAME` — Database name
- `DB_USER` — Database user
- `DB_PASSWORD` — Database password
- `DB_HOST` — Database host (usually db for Docker)
- `DB_PORT` — Database port (5432)
- `EMAIL_HOST_USER` / `EMAIL_HOST_PASSWORD` — Email credentials
- `SOCIAL_AUTH_GOOGLE_OAUTH2_KEY` / `SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET` — Google OAuth
- `SOCIAL_AUTH_VK_OAUTH2_KEY` / `SOCIAL_AUTH_VK_OAUTH2_SECRET` — VK OAuth

## Development Notes

- All dependencies are managed with Poetry (`pyproject.toml`).
- Static and media files are served from `/static/` and `/media/`.
- Social authentication is configured via environment variables.
- Database backups are stored in the `./backups` directory.

## Production Note

For real-world deployments, you may want to:

- Remove automatic migrations and superuser creation from the Docker Compose `command`.
- Use a production-ready WSGI server (e.g., gunicorn or uwsgi).
- Set `DEBUG=False` and configure allowed hosts, static/media storage, and secure environment variables.

## Useful Links

- [Django documentation](https://docs.djangoproject.com/)
- [Docker documentation](https://docs.docker.com/)
- [Poetry documentation](https://python-poetry.org/docs/)
- [DRF documentation](https://www.django-rest-framework.org/)

---

**For any issues or contributions, please open an issue or pull request on GitHub.**
