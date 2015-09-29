# Based on the Fedora image
FROM petersenna/coccinelle

RUN dnf install -y tar xz git; dnf clean all

# This script gets the last stable version from kernel.org
# and extract it inside /linuxes
#
# This is the tricky part, the expected output shown below:
# curl -s https://kernel.org|grep -A1 latest_link|\
# 			     tr "\n" " "|\
# 			     tr -s " "|\
# 			     cut -d '"' -f 4
#
# Output: ./pub/linux/kernel/v4.x/linux-4.2.1.tar.xz

RUN mkdir /linuxes; cd /linuxes;curl "https://www.kernel.org/$(curl -s https://kernel.org|grep -A1 latest_link|tr "\n" " "|tr -s " "|cut -d '"' -f 4)"|tar xJf -;ls /linuxes

ADD ["cloudspatch.sh", "/usr/local/bin/cloudspatch.sh"]

ENTRYPOINT ["/usr/local/bin/cloudspatch.sh"]
