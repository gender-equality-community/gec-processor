FROM python:3.10.6

RUN useradd -u 1000 -s /bin/false -d /tmp app

ADD . /app
WORKDIR /app

RUN pip install pipenv

RUN chown -R 1000:1000 /app

USER 1000
RUN pipenv install --system --deploy --ignore-pipfile

ENTRYPOINT ["/usr/local/bin/python3"]
CMD ["main.py"]
