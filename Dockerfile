FROM ubuntu

RUN apt-get update && \
    apt-get install -y python3 python3-pip wget && \
    apt-get clean
RUN mkdir sfdx
RUN wget -qO- https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz | tar xJ -C sfdx --strip-components 1
RUN ./sfdx/install
RUN pip3 install cumulusci  --no-cache-dir

ADD assets /opt/resource
RUN chmod +x /opt/resource/*