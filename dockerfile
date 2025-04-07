FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3.6 \
    python3-pip \
    python3.6-venv \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.6 /usr/bin/python

COPY . .
RUN pip3 install -r requirements.txt
RUN python manage.py makemigrations
RUN python manage.py migrate


EXPOSE 8000

CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:8000"]
