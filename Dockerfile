
FROM intersystemsdc/iris-community

USER root
RUN apt update && apt-get -y install git && apt-get -y install telnet

WORKDIR /opt/irisbuild
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild

ENV PIP_TARGET=${ISC_PACKAGE_INSTALLDIR}/mgr/python

COPY data data
COPY src src
COPY module.xml module.xml
COPY iris.script iris.script
COPY requirements.txt requirements.txt

RUN chown  -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild/
USER ${ISC_PACKAGE_MGRUSER}

RUN pip3 install -r requirements.txt
RUN iris start IRIS \
	&& iris session IRIS < iris.script \
    && iris stop IRIS quietly
