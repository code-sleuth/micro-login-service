pipeline {
    agent { 
        dockerfile {
            filename 'Jenkins.Dockerfile'
        }  
    }
    environment {
        POSTGRES_USER=credentials("POSTGRES_USER")
        POSTGRES_PASSWORD=credentials("POSTGRES_PASSWORD")
        POSTGRES_HOST=credentials("POSTGRES_HOST")
        POSTGRES_DB=credentials("POSTGRES_DB")
        POSTGRES_TEST_DB=credentials("POSTGRES_TEST_DB")
        GMAIL_USERNAME=credentials("GMAIL_USERNAME")
        GMAIL_PASSWORD=credentials("GMAIL_PASSWORD")
        GOOGLE_CLIENT_ID=credentials("GOOGLE_CLIENT_ID")
        GOOGLE_CLIENT_SECRET=credentials("GOOGLE_CLIENT_SECRET")
        DOMAIN=credentials("DOMAIN")
        RAILS_ENV=credentials("RAILS_ENV")
        PROJECT_ID=credentials("PROJECT_ID")
        SERVICE_KEY=credentials("SERVICE_KEY")
        SERVICE_ACCOUNT_EMAIL=credentials("SERVICE_ACCOUNT_EMAIL")
        VOF_INFRASTRUCTURE_REPO=credentials("VOF_INFRASTRUCTURE_REPO")
        GCLOUD_VOF_BUCKET=credentials("GCLOUD_VOF_BUCKET")
        SLACK_CHANNEL=credentials("SLACK_CHANNEL")
        SLACK_CHANNEL_HOOK=credentials("SLACK_CHANNEL_HOOK")
        BUGSNAG_KEY=credentials("BUGSNAG_KEY")
        USER_MICROSERVICE_API_URL=credentials("USER_MICROSERVICE_API_URL")
        USER_MICROSERVICE_API_TOKEN=credentials("USER_MICROSERVICE_API_TOKEN")
        STAGING_RESERVED_IP=credentials("STAGING_RESERVED_IP")
        PRODUCTION_RESERVED_IP=credentials("PRODUCTION_RESERVED_IP")
        PRODUCTION_BUGSNAG_KEY=credentials("PRODUCTION_BUGSNAG_KEY")
        SANDBOX_RESERVED_IP=credentials("SANDBOX_RESERVED_IP")
    }
    stages {
        stage('Build') { 
            steps {
                sh 'chmod 777 ./pgfile.sh'
                sh './pg-setup.sh'
                sh "rake db:create"
                sh "rake db:migrate"
            }
        }
        stage('Test'){
            steps {
                echo 'testing'
                sh '#!/bin/bash \n '+
                sh 'bundle exec rspec spec'
            }
        }
        // stage('Image Build') {
        //     steps {
        //         echo 'building base image...'
        //         sh 'chmod 777 ./script/packer.sh'
        //         sh './script/packer.sh'
        //     }
        // }

        // stage('Deploy') {
        //     steps {
        //         echo 'deploying...'
        //         sh 'chmod 777 ./script/deploy.sh'
        //         sh './script/deploy.sh'
        //     }
        // }
    }
}