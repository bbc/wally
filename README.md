# Wally
Wally is a web-based Cucumber viewer and navigator.

## About
The first cut of a feature file should be collabatively written, but then it becomes the property of developers who commit it to a version control system.

The Product Owner or Business Analyst usually does not want to use an IDE or VC client to view requiements. They also want to search or group features and scenarios.

## What's wrong with Relish?
Many of the ideas have been borrowed from Matt Wynne's Relish product, but we;

### Didn't want
* To sign-in

### Wanted to
* Use it through mobile devices
* Easily group features and scenarios by tags 
* Count features and tags
* Include a project progress bar 

### Installation
Install [mongodb](http://www.mongodb.org/display/DOCS/Quickstart "mongodb") > v. 2.0.0
gem install wally
wally server
http://localhost:4567/
create a '.wally' file and enter any authentication text you like
wally push http://localhost:4567/ feature_dir


## Wally?
If you walk in to a British fish shop and ask for a wally you'll receive a [pickled gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin).
