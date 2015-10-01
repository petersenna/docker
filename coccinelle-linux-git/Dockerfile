# Based on the Fedora image
FROM petersenna/coccinelle

RUN dnf install -y git; dnf clean all

RUN mkdir -p /linux/.git
ADD ["config", "/linux/.git/config"]

# Don't checkout now, do that on the container
RUN cd /linux; git init; git remote update

# Let's test this, but I think it may be a good idea
# as future remote update will be kept saving bandwidth
# and start time
VOLUME ["/linux/.git"]

ADD ["cloudspatch.sh", "/usr/local/bin/cloudspatch.sh"]

ENTRYPOINT ["/usr/local/bin/cloudspatch.sh"]
