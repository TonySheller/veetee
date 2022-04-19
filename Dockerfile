FROM python:3.8.13-slim

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  curl wget \
  python3 \
  python3-venv \
  python3-pip \
  python3-dev \
  libpq-dev \
  curl \
  && apt-get autoremove -y

# Add the user
RUN useradd -ms /bin/bash veetee
USER veetee
WORKDIR /home/veetee

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

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip3 install dask==2022.02.1 \
spyder==5.1.5 \
packaging==21.3

RUN pip3 install -U --user pip && pip3 install rasa[full]

ENTRYPOINT ["bash"]