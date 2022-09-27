FROM python:3.10.6 as build

ADD . /app
WORKDIR /app

RUN pip install pipenv && \
    pipenv install --system --deploy --ignore-pipfile && \
    find / -name walrus

FROM gcr.io/distroless/python3

COPY --from=build /usr/local/lib/python3.10/site-packages/ /usr/lib/python3.10/

ENTRYPOINT ["/usr/local/bin/python3"]
CMD ["main.py"]
