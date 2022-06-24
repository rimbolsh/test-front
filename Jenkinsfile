def version
pipeline {
    agent any

    // triggers {
    //     pollSCM('*/3 * * * *')
    // }
    parameters {
        string(name: 'projectName', defaultValue: 'pipeline-docker-image-front')
    }  

    stages {
        // 레포지토리를 다운로드 받음
        stage('Repository Prepare') {
            agent any
            steps {
                echo 'Clonning Repository'
                checkout scm
            }

            post {
                success {
                    echo 'Successfully Cloned Repository'
                }
                always {
                    echo "i tried..."
                }
                cleanup {
                    echo "after all other post condition"
                }
            }
        }

        stage('Build version') {
            agent any
            steps {
                script {
                    // echo "** version init : ${params.version} **"
                    version = sh( returnStdout: true, script: "cat package.json | grep -o '\"version\": [^,]*'" ).trim()
                    echo "** version temp : ${version} **"
                    
                    version = version.split(/:/)[1]
                    version = version.replaceAll("\"","").trim()
                    // params.put("version", tempSplit)
                    echo "** version load : ${version} **"
                }
            }
        }

        stage('docker Image build & push') {
            agent any
            steps {
                echo 'build & registry push'
                
                script {
                    docker.withRegistry("https://healthcare.kr.ncr.ntruss.com", 'dockerRegistry') {
                        def customImage = docker.build("healthcare.kr.ncr.ntruss.com/${params.projectName}:${version}")
                        customImage.push()
                    }
                }
            }
            
            
        }
    }
}