FROM centos:latest

MAINTAINER yifeixudocker

# add td-agent repository and gpg key
ADD td-agent.repo /etc/yum.repos.d/td-agent.repo
ADD RPM-GPG-KEY-td-agent /etc/pki/rpm-gpg/RPM-GPG-KEY-td-agent

# install td-agent
RUN yum -y install td-agent && yum clean all

# install fluent biquery plugin
RUN /usr/sbin/td-agent-gem install fluent-plugin-bigquery fluent-plugin-google-cloud --no-ri --no-rdoc -V
RUN yum clean all && yum swap fakesystemd systemd

VOLUME ["/etc/td-agent"]

ENTRYPOINT ["td-agent"]
