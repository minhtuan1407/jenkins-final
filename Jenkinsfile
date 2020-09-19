pipeline {
    agent { label 'master' }
    options {
        timestamps ()
    }
    stages {
        stage("BUILD") {
            parallel {
                stage ("BUILD ALL") {
                    when { expression { params.BUILD_APP == 'all' } }
                    steps {
                        git 'https://github.com/minhtuan1407/jenkins-final.git'
                        sh 'git pull origin master'
                        echo 'BUILD NODEJS'
                        sh 'nodejs/build-nodejs.sh'
                        echo 'BUILD PYTHON'
                        sh 'python/build-python.sh'
                    }
                }
                stage ("BUILD NODEJS") {
                    when { expression { params.BUILD_APP == 'nodejs' } }
                    steps {
                        git 'https://github.com/minhtuan1407/jenkins-final.git'
                        echo 'BUILD NODEJS'
                        sh 'nodejs/build-nodejs.sh'
                    }
                }
                stage ("BUILD PYTHON") {
                    when { expression { params.BUILD_APP == 'python' } }
                    steps {
                        git 'https://github.com/minhtuan1407/jenkins-final.git'
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
                        echo 'PUSH IMAGE TO DOCKERHUB'
                        withDockerRegistry([ credentialsId: "Dockerhub credential", url: "" ]) {
                            sh './nodejs/push-nodejs.sh'
                            sh './python/push-python.sh'
                        }
                    }
                }
                stage ("PUSH NODEJS") {
                    when { expression { params.BUILD_APP == 'nodejs' } }
                    steps {
                        echo 'PUSH IMAGE TO DOCKERHUB'
                        withDockerRegistry([ credentialsId: "Dockerhub credential", url: "" ]) {
                            sh './nodejs/push-nodejs.sh'
                        }
                    }
                }
                stage ("PUSH PYTHON") {
                    when { expression { params.BUILD_APP == 'python' } }
                    steps {
                        echo 'PUSH IMAGE TO DOCKERHUB'
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
                        echo 'REMOVE ALL'
                        sh 'docker stop $(docker ps -a -q)'
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
                        sh 'docker pull minhtuan9801/nodejs'
                        sh 'docker pull minhtuan9801/python'
                        sh 'docker run -d --rm --name nodejs-app --net=host minhtuan9801/nodejs'
                        sh 'docker run -d --rm --name python-app --net=host minhtuan9801/python'
                    }
                }
                stage ("DEPLOY NODEJS") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'nodejs' } }
                    steps {
                        echo 'DEPLOY NODEJS ON NODE 2'
                        sh 'docker pull minhtuan9801/nodejs'
                        sh 'docker run -d --rm --name nodejs-app --net=host minhtuan9801/nodejs'
                    }
                }
                stage ("DEPLOY PYTHON") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'python' } }
                    steps {
                        echo 'DEPLOY PYTHON ON NODE 2'
                        sh 'docker pull minhtuan9801/python'
                        sh 'docker run -d --rm --name python-app --net=host minhtuan9801/python'
                    }
                }
            }
        }
    }
}
