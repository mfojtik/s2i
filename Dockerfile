FROM scratch
ENV PATH=/bin:/usr/bin

ADD ./buildroot/git /
COPY ./buildroot/bin/* /bin/

ENTRYPOINT ["/bin/s2i"]
