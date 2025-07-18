FROM ubuntu:22.04

RUN apt-get clean && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV TERM=dumb
ENV PYTHONIOENCODING=utf-8

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git curl software-properties-common unzip
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3.6
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y libgtk-3-dev libboost-all-dev build-essential cmake libffi-dev
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y firefox
RUN curl https://bootstrap.pypa.io/get-pip.py | python3
RUN git clone https://github.com/ThoughtfulDev/EagleEye
WORKDIR /EagleEye
RUN python3 -m pip install -r requirements.txt
RUN python3 -m pip install --upgrade beautifulsoup4 html5lib spry
ADD https://github.com/mozilla/geckodriver/releases/download/v0.27.0/geckodriver-v0.27.0-linux64.tar.gz /EagleEye/geckodriver.tar.gz
RUN tar -xvf geckodriver.tar.gz
RUN mv geckodriver /usr/bin/geckodriver
RUN chmod +x /usr/bin/geckodriver
RUN rm -r /EagleEye/known/
ENTRYPOINT bash /entry.sh
