FROM python:3.9 as build

ADD . /app
WORKDIR /app

RUN pip install pipenv && \
    pipenv install --system --deploy --ignore-pipfile

FROM gcr.io/distroless/python3

ENV PYTHONPATH=/usr/lib/python3.9/site-packages

COPY --from=build /usr/local/lib/python3.9/site-packages/ /usr/lib/python3.9/site-packages
COPY --from=build /app /app

ENTRYPOINT ["/usr/bin/python"]
CMD ["/app/main.py"]
