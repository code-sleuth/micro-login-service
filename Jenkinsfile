node {
    checkout scm
    withEnv(['MYTOOL_HOME=/usr/local/mytool']) {
        docker.image("postgres:9.6").withRun() { db ->
            withEnv(['POSTGRES_USER=postgres', 'POSTGRES_PASSWORD=Z0mbie@home', "POSTGRES_HOST=localhost", "POSTGRES_DB=micro_login_db","POSTGRES_TEST_DB=micro_login_test"]) {
                sh "rake db:create"
                sh "rake db:migrate"
                sh "bundle exec rspec spec"
            }
        }
    }
}