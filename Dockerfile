FROM alpine:3.18.0 as staging

RUN apk add --no-cache unzip

ADD .venv/lib/python3.11/site-packages /app
ADD dist/*.whl /tmp/dist/
RUN unzip -n -q /tmp/dist/*.whl -d /app

FROM python:3.11-alpine

WORKDIR /app
ENV PYTHONPATH=/app:$PYTHONPATH
COPY --from=staging /app/ /app/

ENTRYPOINT ["python", "-m", "template"]
