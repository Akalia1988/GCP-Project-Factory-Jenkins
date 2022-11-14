pipeline {
    agent any
    parameters {
        string(name: 'REPO_NAME', defaultValue: 'gcp-jenkins-test', description: 'Name of the forked Github repo')
        string(name: 'PROJECT_NAME', defaultValue: 'gcp-jenkins-test', description: 'Name of GCP Project')
        string(name: 'ORG_ID', defaultValue: 'organization/123456', description: 'Organization ID')
        string(name: 'BILLING_ACCOUNT', defaultValue: 'xxxxx', description: 'Billing account')
        string(name: 'BILL_TO_LABEL_VALUE', defaultValue: 'dshare', description: 'Label for whom project is getting billed to.')
        string(name: 'COST_CENTER_LABEL_VALUE', defaultValue: 'f5020', description: 'Label for cost center.')
        string(name: 'BUSINESS_OWNER_LABEL_VALUE', defaultValue: 'it-cloud-management', description: 'Label for Business Owner')
        string(name: 'PRODUCT_OWNER_LABEL_VALUE', defaultValue: 'it-cloud-management', description: 'Label for Product Owner')
        string(name: 'OPERATIONS_OWNER_LABEL_VALUE', defaultValue: 'it-cloud-management', description: 'Label for Operations Owner')
        string(name: 'ENVIRONMENT_LABEL_VALUE', defaultValue: 'test', description: 'Label for project environment')
        string(name: 'PROJECT_ID', defaultValue: 'gcp-jenkins-test', description: 'The ID to give the project. If not provided, the PROJECT_NAME will be used.')
        string(name: 'FOLDER_ID', defaultValue: 'folders/xxxxxx', description: 'The project parent folder.')
        string(name: 'PROJECT_EDITOR', defaultValue: 'user:arshdeep.kalia@xxxx.com', description: 'The project user to give the editor role to.')
    }
    environment { 
        TFCREDS = credentials('it-tf-deploy')
        TF_API = credentials('terraform-cloud-api-token')
        REPO_NAME = "${params.REPO_NAME}"
        PROJECT_NAME = "${params.PROJECT_NAME}"
        ORG_ID = "${params.ORG_ID}"
        BILLING_ACCOUNT = "${params.BILLING_ACCOUNT}"
        BILL_TO_LABEL_VALUE = "${params.BILL_TO_LABEL_VALUE}"
        COST_CENTER_LABEL_VALUE = "${params.COST_CENTER_LABEL_VALUE}"
        BUSINESS_OWNER_LABEL_VALUE = "${params.BUSINESS_OWNER_LABEL_VALUE}"
        PRODUCT_OWNER_LABEL_VALUE = "${params.PRODUCT_OWNER_LABEL_VALUE}"
        OPERATIONS_OWNER_LABEL_VALUE = "${params.OPERATIONS_OWNER_LABEL_VALUE}"
        ENVIRONMENT_LABEL_VALUE = "${params.ENVIRONMENT_LABEL_VALUE}"
        PROJECT_ID = "${params.PROJECT_ID}"
        FOLDER_ID = "${params.FOLDER_ID}"
        PROJECT_EDITOR = "${params.PROJECT_EDITOR}"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout(scm)
            }
        }
        stage('Build') {
            agent {
                docker {
                    image 'harbor.prod.corp.xxxxxx.net/library/xxxxx/githubcli:latest'
                    args '-u root:root'
                }
            }
            steps {
                    withCredentials([usernamePassword(credentialsId: 'xxxxxx-jenkins-gh-token',
                                          usernameVariable: 'GITHUB_APP',
                                          passwordVariable: 'GITHUB_ACCESS_TOKEN')]) {
                    sh(label: 'Create new repo', returnStatus: true, returnStdout: true, script: '''
                        export PROJECT_NAME="${env.PROJECT_NAME}"
                        envsubst < README.md | tee README.md
                        echo "$GITHUB_ACCESS_TOKEN" > .githubtoken
                        unset GITHUB_TOKEN
                        gh auth login --with-token < .githubtoken
                        rm .githubtoken
                        rm -rf .git
                        rm -rf Jenkinsfile
                        gh repo create "acxiom-it-public-cloud/${REPO_NAME}" --private --source=. --remote=upstream
                        git config --global --add safe.directory "${WORKSPACE}"
                        git config --global init.defaultBranch main
                        git init
                        git remote add origin "git@github.com:xxxxx-it/${REPO_NAME}.git"
                        git add --all
                        git commit -m"initial commit"
                        git push origin main --verbose
                    ''')
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