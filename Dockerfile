FROM python:3.11-alpine3.18
LABEL maintainer="Paras Pathak(paraspsp)"

ENV PYTHONUNBUFFERED 1

COPY ./package_requirements.txt /tmp/package_requirements.txt
COPY ./package_requirements.dev.txt /tmp/package_requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/package_requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/package_requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user