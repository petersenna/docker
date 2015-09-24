# Build latest Coccinelle packages
FROM fedora

RUN dnf -y update; dnf clean all
RUN dnf -y install @development-tools; dnf clean all
RUN dnf -y install rpmdevtools 'dnf-command(builddep)'; dnf clean all
RUN dnf -y builddep coccinelle; dnf clean all

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
