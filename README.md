# ![GitHub release (latest by date)](https://img.shields.io/github/v/release/elegoev/docker-jenkinsci-docker?style=plastic)

### [docker-jenkinsci-docker](https://github.com/elegoev/docker-jenkinsci)

### Base image
Used base image [jenkins/jenkins](https://hub.docker.com/r/jenkins/jenkins)

### Build image
1. Create vagrantbox `vagrant up`
1. Login `vagrant ssh`
1. Change directory `cd /vagrant`
1. Build & run image `./build_image.sh`

### Create New Version (DockerHub)
1. Create release on GitHub
1. Image with new release (tag), will be created on DockerHub

### References
- [Developing Groovy Scripts to Automate Jenkins](https://brokenco.de/2017/07/24/groovy-automation-for-jenkins.html)
- [Jenkins updating init.groovy.d files in a docker container](https://stackoverflow.com/questions/45818327/jenkins-updating-init-groovy-d-files-in-a-docker-container)
- [JFrog Client](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory)


### Ports & Access
| Application          | URL                         |
|----------------------|-----------------------------|
| Jenkins              | http://localhost:8080       |
| Jenkins Blue Ocean   | http://localhost:8080/blue  |

### Docker Commands
|                      | command                                            |
|----------------------|----------------------------------------------------|
| build image          | docker build --rm -t elegoev/jenkinsci .           |
| shell in container   | docker exec -it \<container id\> bash              |

### Versioning
Repository follows sematic versioning  [![](https://img.shields.io/badge/semver-2.0.0-green.svg)](http://semver.org)

### Changelog
For all notable changes see [CHANGELOG](https://github.com/elegoev/docker-jenkinsci-docker/blob/master/CHANGELOG.md)

### License
Licensed under The MIT License (MIT) - for the full copyright and license information, please view the [LICENSE](https://github.com/elegoev/docker-jenkinsci-docker/blob/master/LICENSE) file.

### Issue Reporting
Any and all feedback is welcome.  Please let me know of any issues you may find in the bug tracker on github. You can find it [here. ](https://github.com/elegoev/docker-jenkinsci-docker/issues)
