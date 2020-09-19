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
                    when { expression { params.BUILD_APP == 'all' } }
                    steps {
                        sh 'docker stop nodejs-app'
                        sh 'docker stop python-app'
                        sh 'docker system prune'
                    }
                }
                stage ("REMOVE NODEJS") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'nodejs' } }
                    steps {
                        sh 'docker stop nodejs-app'
                        sh 'docker system prune'
                    }
                }
                stage ("REMOVE PYTHON") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'python' } }
                    steps {
                        sh 'docker stop python-app'
                        sh 'docker system prune'
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
                        sh 'docker run -d --rm --name nodejs-app -p 3000:3000 minhtuan9801/nodejs'
                        sh 'docker run -d --rm --name python-app -p 5000:5000 minhtuan9801/python'
                    }
                }
                stage ("DEPLOY NODEJS") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'nodejs' } }
                    steps {
                        echo 'DEPLOY NODEJS ON NODE 2'
                        sh 'docker run -d --rm --name nodejs-app -p 3000:3000 minhtuan9801/nodejs'
                    }
                }
                stage ("DEPLOY PYTHON") {
                    agent { label 'node2' }
                    when { expression { params.BUILD_APP == 'python' } }
                    steps {
                        echo 'DEPLOY PYTHON ON NODE 2'
                        sh 'docker run -d --rm --name python-app -p 5000:5000 minhtuan9801/python'
                    }
                }
            }
        }
    }
}
