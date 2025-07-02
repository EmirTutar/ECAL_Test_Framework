FROM ecal_base

COPY third_party/tclap/include/tclap /usr/local/include/tclap

RUN apt-get update && apt-get install -y python3 python3-pip

COPY .devcontainer/requirements.txt /tmp/requirements.txt

RUN pip3 install -r /tmp/requirements.txt

RUN apt-get install -y htop nano
