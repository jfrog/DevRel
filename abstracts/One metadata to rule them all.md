# One metadata to rule them all - open approach to artifact metadata for faster, more stable and more trusted releases #

## Abstract (~750 characters) ##
Grafeas is an open source metadata effort, which allows metadata exchange between different tools to enable smarter decisions and easier control. In this talk, we’ll show you how by utilizing the metadata during the deployment pipeline, you can create more secure and trusted releases.

## Talk description ##
With the proliferation of binaries to software production and delivery (think beyond dependency artifacts like JARs, but also include VM and container images, microservices systems as a whole, IoT deployments) artifacts metadata becomes critical for decisions of what should be deployed where and investigation of deployed services. But comprehensive metadata is hard to obtain because of the existing stovepipes. Every tool that emits and consumes metadata in their own limited scope and in their own custom format. Those stovepipes hurt everyone and Grafeas is here to change that. Grafeas is an open source metadata effort, with a community sponsored by Google, JFrog, and others. Its intention is to allow metadata exchange between different tools to enable smarter decisions and easier control. In this talk, we’ll show you how to pull artifact metadata, such as vulnerabilities, licenses, etc, from the public and private sources. Then we’ll share the metadata with different tools using Grafeas. By using Grafeas API, we can, utilize the metadata during the deployment pipeline, for example, make sure image promotions are gated by known CVEs. Ultimately, you can create more secure and trusted releases.

## Notes ##
This is a joint talk with a speaker a speaker from Google (probably with the [Grafeas project lead](https://github.com/aysylu)) about the new OSS initiative.
