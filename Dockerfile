FROM postgres:9.6
RUN localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8
CMD [ "postgres", "-c", "standard_conforming_strings=off"]
COPY criar-bancodados.sh /docker-entrypoint-initdb.d/

FROM postgres:10
RUN localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8
CMD [ "postgres", "-c", "standard_conforming_strings=off"]
COPY criar-bancodados.sh /docker-entrypoint-initdb.d/

FROM postgres:11
RUN localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8
CMD [ "postgres", "-c", "standard_conforming_strings=off"]
COPY criar-bancodados.sh /docker-entrypoint-initdb.d/