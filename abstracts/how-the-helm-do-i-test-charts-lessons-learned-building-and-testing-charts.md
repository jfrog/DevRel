# How the Helm Do I Test Charts? Lessons Learned Building and Testing Charts

## Abstract

As a package manager Helm learned a lot from the mistakes that other package managers made. Building and, especially, testing, and making sure they’re properly constructed is a different story. At JFrog we decided early on to make sure all our products had Helm charts that aligned with best practices (like repository layout, naming conventions, testing standards) and we’ve helped a number of projects, including Project Athens, set up their Helm chart testing as well. In this talk we’ll look at:

* The lessons we learned building and testing our charts
* Setting up CI/CD for Helm charts
* Creating a git workflow for Helm charts (really useful if you want your charts in Helm Hub)

## Notes

While we'll use some of the JFrog charts throughout the presentation , this is certainly not a product pitch.
