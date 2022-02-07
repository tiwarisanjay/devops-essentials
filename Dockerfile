FROM alpine:3.13.6

ARG KUSTOMIZE_VERSION

RUN apk update && apk add bash
RUN apk add openssl 
# Add Python
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
# Add terrafrom
RUN apk add terraform --repository=http://dl-cdn.alpinelinux.org/alpine/v3.14/main
# Add Git
RUN apk add git 
RUN apk add curl
# Add kubectl 
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin
# Add kustomize 
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
RUN chmod +x kustomize
RUN mv ./kustomize /usr/local/bin
# Add helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh
ENTRYPOINT [ "terraform", "version"]