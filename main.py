from os import environ
from walrus import Database
from transformers import pipeline

sentiment_pipeline = pipeline("sentiment-analysis", model="siebert/sentiment-roberta-large-english")

hostname = environ.get("REDIS_HOSTNAME", "localhost")
port = environ.get("REDIS_PORT", 6379)
db_id = environ.get("REDIS_DB", 0)


class Processor:
    def __init__(self):
        db = Database(host=hostname, port=port, db=db_id)

        self.cg = db.consumer_group('gec-processor', 'gec')
        self.cg.create()
        self.cg.set_id('$')

        self.p = db.Stream('gec-processed')


    def work(self):
        while True:
            try:
                resp = self.cg.read(1)

                if resp:
                    key, messages = resp[0]
                    last_id, data = messages[0]

                    self.cg.gec.ack(last_id)

                    data[b'sentiment'] = sentiment_pipeline(str(data[b'msg']))[0]['label']
                    self.p.add(data)

            except ConnectionError as e:
                print("ERROR REDIS CONNECTION: {}".format(e))


if __name__ == "__main__":
    processor = Processor()
    processor.work()
