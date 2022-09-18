# Gender Equality Community Message Processor

To read messages from an XStream, label them according to a model of some sort (this project uses [this model from huggingface](https://huggingface.co/siebert/sentiment-roberta-large-english) for now, until we gather enough data to train our own, more relevant model), and then write back to another XStream for something else to handle.

The diagram [here](https://github.com/gender-equality-community/gec-bot#gender-equality-community-whatsapp-bot) shows where this project sits in more detail.

## Labelling

Right now we use some simple sentiment analysis, but it's not great; for instance it marks the following two texts as being positive:

1. My manager called me into a room and said "Great work!"
1. My manager called me into a room and said "Great legs!"

Whereas in actual fact, the second point is inappropriately sexual, has power-balance implications, and is, by all accounts, not okay. Because of a dearth of models on the marketplace that do what we want, and because of a lack of freely available HR-type data we can use to train a model of our own, we're kinda ignoring most of the positive sentiments from this model and assuming that anything negative is proper bad.

In the future, and once we're able to gather anonymous messages (with consent), we can combine our data and train our own models.
