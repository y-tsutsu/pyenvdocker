FROM debian

LABEL MAINTAINER tsustu <tsutsu0928@gmail.com>

SHELL ["/bin/bash", "-c"]

ADD Pipfile /root/
ADD main.py /root/

RUN apt update && apt upgrade -y
RUN apt install -y build-essential git
RUN apt install -y libsqlite3-dev libreadline-dev libgdbm-dev zlib1g-dev libbz2-dev sqlite3 tk-dev zip libssl-dev libffi-dev wget

ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
RUN pyenv install 3.6.8
RUN pyenv global 3.6.8
RUN pyenv versions
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc

RUN eval "$(pyenv init -)" && \
    cd /root && \
    python --version && \
    python -m pip install pip --upgrade && \
    python -m pip install pipenv && \
    .pyenv/versions/3.6.8/bin/pipenv install --system --skip-lock

ENTRYPOINT ["python", "/root/main.py"]
