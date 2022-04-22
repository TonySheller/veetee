FROM ubuntu/nginx:1.18-20.04_edge
#FROM python:3.8.13-slim

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  curl wget \
  python3 \
  python3-venv \
  python3-pip \
  python3-dev \
  libpq-dev \
  curl \
  certbot \
  python3-certbot-nginx \
  sudo \
  vim \
  systemd \
  && apt-get autoremove -y

COPY ./rasa/index*.html /var/www/html/

RUN useradd -ms /bin/bash veetee
RUN usermod -aG sudo veetee
RUN echo "veetee ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ADD rasa  ~
USER veetee
WORKDIR /home/veetee
COPY ./rasa /home/veetee/rasa
RUN sudo chown -R veetee:veetee /home/veetee/rasa
COPY ./entrypoint.sh /home/veetee
COPY ./trainrasa.sh /home/veetee
#rasa run -m models --enable-api --cor "*"

# Add environment variables. 
ENV PATH="/home/veetee/miniconda3/bin:${PATH}"
ARG PATH="/home/veetee/miniconda3/bin:${PATH}"

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /home/veetee/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

# Install for Python 3.8 this way.
RUN conda install anaconda python=3.8
RUN conda install -c anaconda flask daal
RUN conda init --all

RUN python -m pip install --upgrade pip
RUN pip3 install dask==2022.02.1 \
spyder==5.1.5 \
packaging==21.3

RUN pip3 install -U --user pip && pip3 install rasa[full]
RUN sudo chmod a+x /home/veetee/entrypoint.sh
#CMD [service nginx start]
#&& rasa run -m models --enable-api --cors "*"
WORKDIR /home/veetee/rasa/models
RUN rm *
WORKDIR /home/veetee
RUN rm -rf /home/veetee/rasa/.rasa
RUN /home/veetee/trainrasa.sh
#ENTRYPOINT sudo service nginx start && /home/veetee/entrypoint.sh && bash
ENTRYPOINT sudo service nginx start && /home/veetee/entrypoint.sh && bash