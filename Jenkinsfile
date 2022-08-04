node {
    def app

    stage('Clone repository') {
        /* Clone repository to our workspace */

        checkout scm
    }
    
   stage ('Aqua Scan Dev Namespace') {
        /* Do a remote scan of the image in the dev namespace before pulling */
        aqua customFlags: '--layer-vulnerabilities', hideBase: false, hostedImage: 'orders-nginx-dev:good', localImage: '', locationType: 'hosted', notCompliesCmd: '', onDisallowed: 'fail', policies: '', register: false, registry: 'JFrog', showNegligible: true
    }
    
   stage('Package Dev Image') {
        docker.withRegistry('https://dstubked-docker.jfrog.io', 'jfrog') {
             /* Pull and retag for prod namespace */
            sh "docker pull dstubked-docker.jfrog.io/orders-nginx-dev:good"
            sh "docker tag dstubked-docker.jfrog.io/orders-nginx-dev:good dstubked-docker.jfrog.io/orders-nginx-prod:good"
        }
    }
    
    stage ('Aqua Scan Prod Namespace') {
         /* One final scan to check and register before push into prod namespace */
        aqua customFlags: '--layer-vulnerabilities', hideBase: false, hostedImage: '', localImage: 'dstubked-docker.jfrog.io/orders-nginx-prod:good', locationType: 'local', notCompliesCmd: '', onDisallowed: 'fail', policies: '', register: true, registry: 'JFrog', showNegligible: false
    }
    
    stage('Push into Prod Namespace') {
        docker.withRegistry('https://dstubked-docker.jfrog.io', 'jfrog') {
            /* Push into prod namespace */
            sh "docker push dstubked-docker.jfrog.io/orders-nginx-prod:good"
        }
    }
}
