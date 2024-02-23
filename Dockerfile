FROM registry.access.redhat.com/ubi9/python-311@sha256:9466b94e3c872ef18ced7b815c446ca32b413ee116e5a394d90413becb5cd5e9

ENV PYTHONUNBUFFERED=1

COPY * /opt/microservices/
COPY requirements.txt /opt/microservices/
RUN pip install --upgrade pip \
  && pip install --upgrade pipenv\
  && apt-get clean \
  && apt-get update \
  && apt install -y build-essential \
  && apt install -y libmariadb3 libmariadb-dev \
  && pip install --upgrade -r /opt/microservices/requirements.txt

USER 1001

EXPOSE 8080
WORKDIR /opt/microservices/

CMD ["python", "app.py", "8080"]