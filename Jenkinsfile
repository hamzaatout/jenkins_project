pipeline {
    agent any

    environment {
        VIRTUAL_ENV = 'venv'
        PYTHONIOENCODING = 'utf-8'
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    if (!fileExists("${VIRTUAL_ENV}/Scripts/activate.bat")) {
                        bat "python -m venv ${VIRTUAL_ENV}"
                    }
                    bat """
call ${VIRTUAL_ENV}\\Scripts\\activate.bat
pip install -r requirements.txt coverage bandit
"""
                }
            }
        }

        stage('Lint') {
            steps {
                script {
                    bat """
call ${VIRTUAL_ENV}\\Scripts\\activate.bat
flake8 app.py
"""
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    bat """
set PYTHONIOENCODING=utf-8
call ${VIRTUAL_ENV}\\Scripts\\activate.bat
bandit -r . -x ${VIRTUAL_ENV}
"""
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    bat """
call ${VIRTUAL_ENV}\\Scripts\\activate.bat
coverage run -m pytest
"""
                }
            }
        }

        stage('Coverage') {
            steps {
                script {
                    bat """
call ${VIRTUAL_ENV}\\Scripts\\activate.bat
coverage report
"""
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    bat """
powershell -NoProfile -ExecutionPolicy Bypass -File deploy.ps1 -VirtualEnv ${VIRTUAL_ENV}
"""
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
