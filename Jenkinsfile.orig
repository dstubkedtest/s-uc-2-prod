node {
    def app

    stage('Clone repository') {
        /* Clone repository to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image */

        app = docker.build("dstubked-docker.jfrog.io/orders-nginx:good")
    }
    
    stage ('Aqua Scan') {
        aqua customFlags: '--layer-vulnerabilities', hideBase: false, hostedImage: '', localImage: 'dstubked-docker.jfrog.io/orders-nginx:good', locationType: 'local', notCompliesCmd: '', onDisallowed: 'fail', policies: '', register: true, registry: 'JFrog', showNegligible: false
    }
    
    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         */
        docker.withRegistry('https://dstubked-docker.jfrog.io', 'jfrog') {
            app.push()
        }
    }
    
        /*stage('Aqua Scanner CLI') {
            sh "echo Hello from the shell"
            sh "hostname"
            sh "echo $WORKSPACE"
            sh "echo $JENKINS_HOME"
            sh "docker run -e BUILD_JOB_NAME=ExampleVulnerablePipeline -e BUILD_URL=$BUILD_URL -e BUILD_NUMBER=$BUILD_NUMBER --rm -v /var/run/docker.sock:/var/run/docker.sock registry.aquasec.com/scanner:4.2 scan --host http://aquasec-demo658-vm0.eastus.cloudapp.azure.com --registry 'Docker Hub' dstubked/docker-test:latest --no-verify --register --html --user jenkins_scanner --password P@ssword > regresults.html"
    }
    archiveArtifacts 'regresults.html'*/
    /*publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '$WORKSPACE', reportFiles: 'results.html', reportName: 'Aqua HTML Report', reportTitles: ''])*/
}
