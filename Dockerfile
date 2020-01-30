FROM python:3.7
ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    && apt-get -y install libpq-dev python-dev python3-dev musl-dev libgdal-dev

RUN useradd -ms /bin/bash pupa
USER pupa


COPY --chown=pupa:pupa . /home/pupa/councilmatic

ENV PATH="$PATH:/home/pupa/.local/bin"

WORKDIR /home/pupa/councilmatic
RUN pip install --user -r requirements.txt

ENV DATABASE_URL=postgresql://postgresql/opencivicdata
ENV DJANGO_SETTINGS_MODULE=councilmatic.settings

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
