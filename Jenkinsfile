node {
  stage ('Checkout') {
		//checkout scm
		checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/boga5/java-rpm-example.git']]])
	}	//Checkout SCM stage ends
	
	def content = readFile './env'				// variable to store .env file contents
	Properties env_properties = new Properties()	// creating an object for Properties class
	InputStream contents = new ByteArrayInputStream(content.getBytes());	// storing the contents
	env_properties.load(contents)	
	contents = null
	
	stage ('Maven Build') {
		def mvn_version = tool 'maven'
		echo "${mvn_version}"
		withEnv( ["PATH+MAVEN=${mvn_version}/bin"] ) {
			sh "mvn clean install"
		}	
	} //maven build stage ends

	stage ('Publish to YUM server') {
		sh """ scp ${env_properties.source_rpm_location} ${env_properties.remote_user}@${env_properties.remote_ip}:${env_properties.remote_rpm_location}"""
	}   //rpm publish to yum server stage ends
	
	stage ('Application Deployment') {
		sh """ssh -T ${env_properties.deploy_user}@${env_properties.deploy_ip} 'bash -s' < $WORKSPACE/deploy.sh ${env_properties.package_name}"""
	}	Application deployment stage ends
	
} //node ends
