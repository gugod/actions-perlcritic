FROM perl:5.32
RUN cpanm -q --notest --no-man-pages Task::PerlCriticAllPolicies && rm -fr ./cpanm /root/.cpanm
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
