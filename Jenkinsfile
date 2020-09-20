pipeline {
    agent { label 'master' }
    options {
        timestamps ()
    }
    environment {
        DOCKER_TAG='latest'
    }
    stages {
        gtage ("GIT REPO")
        steps {
            git 'https://github.com/minhtuan1407/jenkins-final.git'
            sh 'git pull origin master'
        }
        stage("BUILD") {
            parallel {
                stage ("BUILD ALL") {
                    when { expression { params.BUILD_APP == 'all' } }
                    steps {
                        echo 'BUILD NODEJS'
                        sh 'nodejs/build-nodejs.sh'
                        echo 'BUILD PYTHON'
                        sh 'python/build-python.sh'
                    }
                }
                stage ("BUILD NODEJS") {
                    when { expression { params.BUILD_APP == 'nodejs' } }
                    steps {
                        echo 'BUILD NODEJS'
                        sh 'nodejs/build-nodejs.sh'
                    }
                }
                stage ("BUILD PYTHON") {
                    when { expression { params.BUILD_APP == 'python' } }
                    steps {
                        echo 'BUILD PYTHON'
                        sh 'python/build-python.sh'
                    }
                }
            }
        }
        stage ("PUSH") {
            parallel {
                stage ("PUSH ALL") {
                    when { expression { params.BUILD_APP == 'all' } }
                    steps {
                        withDockerRegistry([ credentialsId: "Dockerhub credential", url: "" ]) {
                            sh './nodejs/push-nodejs.sh'
                            sh './python/push-python.sh'
                        }
                    }
                }
                stage ("PUSH NODEJS") {
                    when { expression { params.BUILD_APP == 'nodejs' } }
                    steps {
                        withDockerRegistry([ credentialsId: "Dockerhub credential", url: "" ]) {
                            sh './nodejs/push-nodejs.sh'
                        }
                    }
                }
                stage ("PUSH PYTHON") {
                    when { expression { params.BUILD_APP == 'python' } }
                    steps {
                        withDockerRegistry([ credentialsId: "Dockerhub credential", url: "" ]) {
                            sh './python/push-python.sh'
                        }
                    }
                }
            }
        }
        stage ("REMOVE OLD CONTAINER") {
            parallel {
                stage ("REMOVE ALL") {
                    agent { label 'node2' }
                    steps {
                        catchError (buildResult: 'SUCCESS', stageResult: 'FAILURE')
                        {
                            sh 'docker stop $(docker ps -a -q)'
                            sh 'docker system prune -f'
                        }
                    }
                }
            }
        }
        stage ("DEPLOY") {
            parallel {
                stage ("DEPLOY ALL") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'all' } }
                    steps {
                        echo 'DEPLOY ON NODE 2'
                        sh './nodejs/deploy-nodejs.sh'
                        sh './python/deploy-python.sh'
                    }
                }
                stage ("DEPLOY NODEJS") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'nodejs' } }
                    steps {
                        echo 'DEPLOY NODEJS ON NODE 2'
                        sh './nodejs/deploy-nodejs.sh'
                    }
                }
                stage ("DEPLOY PYTHON") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'python' } }
                    steps {
                        echo 'DEPLOY PYTHON ON NODE 2'
                        sh './python/deploy-python.sh'
                    }
                }
            }
        }
    }
}
