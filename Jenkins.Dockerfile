# Custom Dockerfile with packer & terraform
#

FROM ruby:2.4.1

USER root
# ENV RAILS_ENV ${DEPLOY_ENV}

# set working directory
RUN mkdir /usr/src/app && \
apt-get -y update && apt-get install postgresql postgresql-contrib -y && \
/etc/init.d/postgresql start

WORKDIR /usr/src/app

# install and cache app dependancies
COPY . .

# RUN mkdir -p /workdir && \
# curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz && \
# mkdir -p /usr/local/gcloud && \
# tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz && \
# /usr/local/gcloud/google-cloud-sdk/install.sh && \
# /usr/local/gcloud/google-cloud-sdk/bin/gcloud components install beta --quiet && \
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && \
apt-get install nodejs -y && \
bundle install
  
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# RUN gsutil cp gs://${BUCKET_NAME}/ssl/andela_key.key /usr/src/app/andela_key.key && \
# gsutil cp gs://${BUCKET_NAME}/ssl/andela_certificate.crt /usr/src/app/andela_certificate.crt

EXPOSE 3000

# # start the app
# # Set the command to start the node server.
CMD ["bundle", "exec", "puma"]