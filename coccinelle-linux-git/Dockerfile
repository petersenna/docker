# Based on the Fedora image
FROM petersenna/coccinelle

RUN dnf install -y git; dnf clean all

ADD ["spatch-wrapper", "/usr/local/bin/"]

RUN mkdir -p /linux/.git
ADD ["config", "/linux/.git/config"]

# Don't checkout now
RUN cd /linux; git init; git remote update

# Let's test this, but I think it may be a good idea
# as future remote updates will be saved
VOLUME ["/linux/.git"]
