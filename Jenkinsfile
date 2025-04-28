pipeline {
    agent any

    environment {
        DEPENDENCY_CHECK_VERSION = "6.5.1"
        DEPENDENCY_CHECK_HOME = "${WORKSPACE}/dependency-check-${DEPENDENCY_CHECK_VERSION}"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from Git
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install Node.js dependencies
                    sh 'npm install'
                }
            }
        }

        stage('Run Dependency-Check') {
            steps {
                script {
                    // Download and install Dependency-Check 6.5.1
                    sh "curl -L https://github.com/jeremylong/DependencyCheck/releases/download/v${DEPENDENCY_CHECK_VERSION}/dependency-check-${DEPENDENCY_CHECK_VERSION}-release.zip -o dependency-check-${DEPENDENCY_CHECK_VERSION}.zip"
                    sh "unzip dependency-check-${DEPENDENCY_CHECK_VERSION}.zip -d ${DEPENDENCY_CHECK_HOME}"
                    sh "rm dependency-check-${DEPENDENCY_CHECK_VERSION}.zip"

                    // Run Dependency-Check
                    sh "${DEPENDENCY_CHECK_HOME}/dependency-check/bin/dependency-check.sh --project nodejs-web-app --scan ./ --out . --format HTML"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t nodejs-web-app .'
                }
            }
        }

        stage('Publish Docker Image') {
            steps {
                script {
                    sh 'docker tag nodejs-web-app elvin98bc/nodejs-web-app:latest'
                    sh 'docker push elvin98bc/nodejs-web-app:latest'
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                script {
                    sh 'docker run -d -p 8001:8001 nodejs-web-app'
                }
            }
        }

        stage('Publish Report') {
            steps {
                // Publish Dependency-Check report in Jenkins
                publishHTML(target: [
                    reportName: 'Dependency-Check Report',
                    reportDir: '.',
                    reportFiles: 'dependency-check-report.html',
                    keepAll: true
                ])
            }
        }
    }
}