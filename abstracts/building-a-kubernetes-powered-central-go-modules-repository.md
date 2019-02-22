# Building a Kubernetes Powered Central Go Modules Repository

## Abstract

Today, Kubernetes is the defacto standard if you want to run container workloads in a production environment. As we set out to build our next generation of products, and run them smoothly in the cloud, we needed to move to Kubernetes too! In the process of building tools like KubeXray and GoCenter we learned a whole bunch.

Join this talk to learn how to get started with Kubernetes and how we got started at JFrog building our new tools. After the session you will know:

* How we got to Kubernetes (and why we chose it)
* How to know what you have in your apps and containers (and how we built ours)
* How we're running GoCenter at scale.

## Talk

Today, Kubernetes is the defacto standard if you want to run container workloads in a production environment, though that wasn't always the case. We had/have a fair amount of monolithic code for our products and to make sure we could build GoCenter in a way that would be easier to manage at scale we needed to make changes. For us, that meant changes to the way we write code (more Go), how we build apps (using Docker and Kubernetes), and how we deploy (using Helm).
We had to figure out a whole bunch of things as we looked at building proper microservices that we could deploy to Kubernetes. During the session, we will pay special attention to things like logging, persistence, limits, and probes because containerizing an app is not simply putting your existing app into a docker container.

As we're looking at containers, knowing exactly what is in the container in terms of licenses, packages, and vulnerabilities was, and is, incredibly important to us to keep our cluster and data secure.

## Notes

Throughout the session we'll cover the lessons that we have learned building these products, so it will *not* be a product pitch.