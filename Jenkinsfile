pipeline {
    agent any

    environment {
        VIRTUAL_ENV = 'venv'
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    if (!fileExists("${env.WORKSPACE}/${VIRTUAL_ENV}")) {
                        sh "python -m venv ${VIRTUAL_ENV}"
                    }
                    sh "source ${VIRTUAL_ENV}/bin/activate && pip install -r requirements.txt coverage bandit"
                }
            }
        }

        stage('Lint') {
            steps {
                script {
                    sh "source ${VIRTUAL_ENV}/bin/activate && flake8 app.py"
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    sh "source ${VIRTUAL_ENV}/bin/activate && bandit -r ."
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh "source ${VIRTUAL_ENV}/bin/activate && coverage run -m pytest"
                }
            }
        }

        stage('Coverage') {
            steps {
                script {
                    sh "source ${VIRTUAL_ENV}/bin/activate && coverage report"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "bash deploy.sh ${VIRTUAL_ENV}"
                    archiveArtifacts artifacts: 'deployment_output.txt', fingerprint: true
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
