ARG PYTHON_VERSION=3.5

FROM python:${PYTHON_VERSION}-slim

RUN pip install --upgrade pip && \
    pip install mypy