# Based on the Fedora image
FROM petersenna/coccinelle

RUN dnf install -y git; dnf clean all

RUN mkdir -p /linux/.git
ADD ["config", "/linux/.git/config"]

# Don't checkout now, do that on the container
RUN cd /linux; git init; git remote update

ADD ["cloudspatch.sh", "/usr/local/bin/cloudspatch.sh"]

ENTRYPOINT ["/usr/local/bin/cloudspatch.sh"]
