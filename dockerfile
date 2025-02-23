FROM ghcr.io/astral-sh/uv:python3.12-alpine

RUN apk add --no-cache gcc musl-dev

WORKDIR /app

COPY pyproject.toml uv.lock /app

RUN uv sync --no-cache

COPY . /app

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1

ENV SESSIONS_PATH=/app/sessions

CMD ["uv", "run", "main.py"]

