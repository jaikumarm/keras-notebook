FROM jupyter/scipy-notebook

USER root

RUN apt-get install gcc-4.9 g++-4.9 -y && \
    ln -s  /usr/bin/gcc-4.9 /usr/bin/gcc -f && \
    ln -s  /usr/bin/g++-4.9 /usr/bin/g++ -f && \
    apt-get clean


RUN conda install --quiet --yes -n python2 -c jaikumarm \
	'theano=0.9.0.dev4' \
	'keras=1.2.0' \
	'ta-lib=0.4.9' \
	'flatdict=1.2.0' \
	&& conda clean -tipsy

RUN conda install --quiet --yes -n python2 psycopg2 pymongo future paramiko gunicorn\
	&& conda clean -tipsy

RUN pip2 install --upgrade pip && \
    pip2 install hyperopt IbPy2 pytz backtrader

ENV KERAS_BACKEND="theano"
ENV PYTHONUNBUFFERED=1

USER $NB_USER
