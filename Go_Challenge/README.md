# JFrog-Go-Challenge

Go repositories are supported by Artifactory since version 5.11.0. To work with [Go repositories](https://www.jfrog.com/confluence/display/JFROG/Go+Registry) with the [JFrog CLI client ](https://www.jfrog.com/confluence/display/CLI)

## Prerequisite
* Install version 1.11 or above of **go**.
* Make sure the **go** command is in your PATH.
* Install [JFrog CLI](https://jfrog.com/getcli/)
* Make sure your JFrog CLI version is 1.26.0 or above

## Running the Example
CD to the root project directory

```console
Configure Artifactory:
> jfrog rt c

Configure the project's repositories:
> jfrog rt go-challenge

Build the project with go and resolve the project dependencies from Artifactory.
> jfrog rt go build --build-name=go-challenge-build --build-number=1 

Publish version v1.0.0 of the package to the go-local repository in Artifactory.
> jfrog rt gp go-challenge v1.0.0 --build-name=go-challenge-build --build-number=1

Collect environment variables and add them to the build info.
> jfrog rt bce go-challenge-build 1

Publish the build info to Artifactory.
> jfrog rt bp go-challenge-build 1
```
