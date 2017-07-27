FROM centos:centos7

MAINTAINER Charles Chen <charlestg@yahoo.com>

RUN yum -y update && yum -y upgrade && \
    yum -y install epel-release && \
    yum -y install python-pip && \
    yum -y install python-sphinx texlive texlive-latex-extra pandoc build-essential wget perl-Digest-MD5 git make && \
    yum -y install pngcrush libjpeg-turbo-utils

ENV TL install-tl
RUN mkdir -p $TL
RUN wget -nv -O $TL.tar.gz http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xzf $TL.tar.gz -C $TL --strip-components=1
ADD texlive.profile $TL/
RUN cd $TL/ && ./install-tl --profile texlive.profile
ENV PATH $PATH:/usr/local/texlive/2017/bin/x86_64-linux
# cleanup
#RUN rm $TL.tar.gz && rm -r $TL

