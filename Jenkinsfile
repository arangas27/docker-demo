#!/usr/bin/env groovy

node {
    //Clone example project from GitHub repository
    git url: 'https://github.com/arangas27/docker-demo.git', branch : 'master'
    //def rtServer = Artifactory.server SERVER_ID
    def rtServer = Artifactory.newServer url: 'http://localhost:8082/artifactory/', credentialsId: 'Artifactory-admin'
    def rtDocker = Artifactory.docker server: rtServer
    def buildInfo = Artifactory.newBuildInfo()
    def tagName
    buildInfo.env.capture = true

    stage('Build') {
                sh 'ls -l;pwd'
                println "Docker Build Starting"
                tagName = "localhost:8082/docker-local/dockerdemo-pipeline:${env.BUILD_NUMBER}.1"
                println "DockerDemo Framework Build"
                docker.build(tagName)
                println "Docker pushing -->" + tagName + " To " + "dokcer-local"
                buildInfo = rtDocker.push(tagName, "docker-local", buildInfo)
                println "Docker Buildinfo"
                rtServer.publishBuildInfo buildInfo
    }
    //Promote image from local to staging repositoy
    stage ('Promote') {
            def promotionConfig = [
              'buildName'          : env.JOB_NAME,
              'buildNumber'        : env.BUILD_NUMBER,
              'targetRepo'         : 'ar-docker-stage-ca',
              'comment'            : 'Promoted to Stage',
              'sourceRepo'         : 'docker-local',
              'status'             : 'Released1',
              'includeDependencies': false,
              'copy'               : true
            ]
            rtServer.promote promotionConfig
    }
  }
