FROM jupyter/scipy-notebook

USER root

RUN apt-get install gcc-4.9 g++-4.9 -y && \
    ln -s  /usr/bin/gcc-4.9 /usr/bin/gcc -f && \
    ln -s  /usr/bin/g++-4.9 /usr/bin/g++ -f && \
    apt-get clean

RUN wget --quiet http://downloads.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz -O ta-lib-0.4.0-src.tar.gz &&\
	tar xvzf ta-lib-0.4.0-src.tar.gz && cd ta-lib && \
	./configure --prefix=/usr && \
	make && make install &&\
	cd .. && rm ta-lib-0.4.0-src.tar.gz && rm -r ta-lib

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
