FROM nginx:latest

EXPOSE 8585
EXPOSE 80
EXPOSE 5005
EXPOSE 5055

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  curl wget \
  python3 \
  python3-venv \
  python3-pip \
  python3-dev \
  libpq-dev \
  sudo \
  vim \
  && apt-get autoremove -y

COPY ./rasa/index*.html /usr/share/nginx/html/

RUN useradd -ms /bin/bash veetee
RUN usermod -aG sudo veetee
RUN echo "veetee ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#ADD rasa  /home/veetee
USER veetee
WORKDIR /home/veetee
COPY ./rasa /home/veetee/rasa

# while developing its easier to sudo from the user. 
RUN sudo chown -R veetee:veetee /home/veetee/rasa
COPY ./entrypoint.sh /home/veetee
COPY ./trainrasa.sh /home/veetee

# Add environment variables. 
ENV PATH="/home/veetee/miniconda3/bin:${PATH}"
ARG PATH="/home/veetee/miniconda3/bin:${PATH}"

# Anaconda setup
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /home/veetee/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

# Install for Python 3.8 this way.
RUN conda install anaconda python=3.9
RUN conda install -c anaconda flask daal
RUN conda init --all

# Install some stuff with pip
RUN python -m pip install --upgrade pip
RUN pip3 install dask==2022.02.1 \
spyder==5.1.5 \
packaging==21.3

# Install the full rasa --
RUN pip3 install -U --user pip && pip3 install rasa[full]
RUN sudo chmod a+x /home/veetee/*.sh
WORKDIR /home/veetee/rasa/models
RUN rm *
WORKDIR /home/veetee
RUN rm -rf /home/veetee/rasa/.rasa

# Train Rasa
RUN /home/veetee/trainrasa.sh

ENTRYPOINT sudo service nginx start && /home/veetee/entrypoint.sh && bash