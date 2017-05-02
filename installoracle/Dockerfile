FROM container-registry.oracle.com/database/enterprise
COPY ./scripts /scripts
RUN sed -i -e '/^# keep container runing$/,$d' /home/oracle/setup/dockerInit.sh \
  && /home/oracle/setup/dockerInit.sh \
  && echo "set -e" >> /home/oracle/setup/dockerInit.sh \
  && echo "sh /scripts/postinit.sh" >> /home/oracle/setup/dockerInit.sh \
  && echo "# keep container runing" >> /home/oracle/setup/dockerInit.sh \
  && echo "tail -f \$INIT_LOG &" >> /home/oracle/setup/dockerInit.sh \
  && echo "childPID=\$!" >> /home/oracle/setup/dockerInit.sh \
  && echo "wait \$childPID" >> /home/oracle/setup/dockerInit.sh
