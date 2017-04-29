FROM container-registry.oracle.com/database/standard
RUN cp /home/oracle/setup/dockerInit.sh /home/oracle/setup/dockerInit.sh.bak \
  # Don't run the container in a loop while building this image
  && sed -i -e '/^# keep container runing$/,$d' /home/oracle/setup/dockerInit.sh \
  && /home/oracle/setup/dockerInit.sh \
  && rm /home/oracle/setup/dockerInit.sh \
  && mv /home/oracle/setup/dockerInit.sh.bak /home/oracle/setup/dockerInit.sh
