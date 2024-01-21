FROM python:3.10.12
WORKDIR /usr/src/app/

COPY . /usr/src/app/
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Prepare data to be used (saves data to data_<YYYY-MM-DD-hh-mm-ss>.pickle)
RUN python drunk_detector data --train-files data/train/*/* --test-files data/test/*/* --val-files data/validation/*/*

# Predict drunkeness using best CNN model
RUN python drunk_detector predict -m sum -d data_*.pickle

## Train a new hyperparameter tuned CNN
#RUN python drunk_detector train -m sum -d data_*.pickle

EXPOSE 80
