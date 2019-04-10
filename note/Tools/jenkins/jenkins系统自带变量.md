The following variables are available to shell scripts
下面是shell脚本里可用的变量

```
BUILD_NUMBER
The current build number, such as "153"
当前构建的数字，如"153"
BUILD_ID
The current build ID, identical to BUILD_NUMBER for builds created in 1.597+, but a YYYY-MM-DD_hh-mm-ss timestamp for older builds
当前的构建ID，相同的BUILD_NUMBER
BUILD_DISPLAY_NAME
The display name of the current build, which is something like "#153" by default.
JOB_NAME
Name of the project of this build, such as "foo" or "foo/bar". (To strip off folder paths from a Bourne shell script, try: ${JOB_NAME##*/})
BUILD_TAG
String of "jenkins-${JOB_NAME}-${BUILD_NUMBER}". Convenient to put into a resource file, a jar file, etc for easier identification.
EXECUTOR_NUMBER
The unique number that identifies the current executor (among executors of the same machine) that’s carrying out this build. This is the number you see in the "build executor status", except that the number starts from 0, not 1.
NODE_NAME
Name of the slave if the build is on a slave, or "master" if run on master
NODE_LABELS
Whitespace-separated list of labels that the node is assigned.
WORKSPACE
The absolute path of the directory assigned to the build as a workspace.
JENKINS_HOME
The absolute path of the directory assigned on the master node for Jenkins to store data.
JENKINS_URL
Full URL of Jenkins, like http://server:port/jenkins/ (note: only available if Jenkins URL set in system configuration)
BUILD_URL
Full URL of this build, like http://server:port/jenkins/job/foo/15/ (Jenkins URL must be set)
JOB_URL
Full URL of this job, like http://server:port/jenkins/job/foo/ (Jenkins URL must be set)
SVN_REVISION
Subversion revision number that's currently checked out to the workspace, such as "12345"
SVN_URL
Subversion URL that's currently checked out to the workspace.


echo `pwd`			/home/lvyu/.jenkins/workspace/maven-test
echo $BUILD_NUMBER 		39
echo $BUILD_ID 			39
echo $BUILD_DISPLAY_NAME 	#39
echo $JOB_NAME 			maven-test
echo $BUILD_TAG 		jenkins-maven-test-39
echo $EXECUTOR_NUMBER 		1
echo $NODE_NAME 		master
echo $NODE_LABELS 		master
echo $WORKSPACE 		/home/lvyu/.jenkins/workspace/maven-test
echo $JENKINS_HOME 		/home/lvyu/.jenkins
echo $JENKINS_URL 		http://192.168.6.243:8080/jenkins/
echo $BUILD_URL 		http://192.168.6.243:8080/jenkins/job/maven-test/39/
echo $JOB_URL 			http://192.168.6.243:8080/jenkins/job/maven-test/
echo $SVN_REVISION 		2369
echo $SVN_URL 			http://192.168.6.243:8000/svn/lvyushequ/cxm/code/trunk/cxm
```
