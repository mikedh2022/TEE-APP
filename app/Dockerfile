FROM python:3.7-alpine3.8


COPY requirements.txt /opt/pip/requirements.txt
RUN pip install -r /opt/pip/requirements.txt

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ADD . /opt/app
WORKDIR /opt/app

ENTRYPOINT ["./entrypoint.sh"]