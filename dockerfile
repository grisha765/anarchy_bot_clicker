FROM ghcr.io/astral-sh/uv:python3.12-alpine AS builder

RUN apk add --no-cache gcc musl-dev

WORKDIR /app

COPY pyproject.toml uv.lock /app

RUN uv sync --no-cache


FROM python:3.12-alpine AS main

WORKDIR /app

COPY --from=builder /app/.venv /app/.venv

COPY . /app

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1

ENV SESSIONS_PATH=/app/sessions

CMD ["python", "main.py"]

