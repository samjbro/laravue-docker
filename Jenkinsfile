#!/usr/bin/env groovy

node('master') {
    stage('build') {
        git url: 'https://github.com/samjbro/laravue-docker.git'

        sh "./develop.sh up -d"

        sh "./develop.sh composer install"

        sh 'cp .env.example .env'
        sh './develop.sh art key:generate'
    }

    stage('test') {
        sh "APP_ENV=testing ./develop.sh test"
    }
}