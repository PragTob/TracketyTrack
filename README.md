## TracketyTrack [![Build Status](https://secure.travis-ci.org/PragTob/TracketyTrack.png)](http://travis-ci.org/PragTob/TracketyTrack) [![Code Climate](https://codeclimate.com/github/PragTob/TracketyTrack.png)](https://codeclimate.com/github/PragTob/TracketyTrack)
TracketyTrack is a simple tool for keeping track of user stories and their status. It can particularly be used as tracker for small agile projects. One main feature is the support for PairProgramming. The name was inspired by [hacketyhack] (hackety-hack.com).

It is designed with small teams (such as students working on a project) in mind that want to keep track of their progress but can not have a "real" storyboard with sticky notes etc. as students usually don't have an office. We want to allow to user to do as much as possible and not put too many restrictions on what is possible and what is not, since we don't want to build a tool that gets in the way of a user. For instance you may create a user story with just a name, if that is what you wish.

Moreover it could be used by distributed teams or teams that want a simple electronical record of their progress.

TracketyTrack can also be used to generate simple statistics such as a burndown chart (for the sprint and the project itself).

TracketyTrack also presents a nice user interface powered by Twitter Bootstrap (and many custom adjustments) featuring nice utility boxes that help you get your work done more quickly.

If you want to, you can take a look at our [demo page] (http://severe-earth-1378.herokuapp.com/) - you may log in as user@example.com with the password: 12345678

## Attention Beta Stuff
TracketyTrack was developed using Test Driven Development, however acceptance testing was added later. So we are relatively confident about the stability of the system. However it has not been used in production over a long time, so you should be cautios if you want to use this as your only user story tracker. We guarantee for nothing.

## Can I try this thing?
Sure you can! We have a publicly accesible demo page over at [heroku] (http://severe-earth-1378.herokuapp.com/) that gets updated as development progresses. You can log in as user@example.com with the password: 12345678

If you do so please leave us some feedback in form of a github issue (we don't have better communication channels right now, as the project is still pretty small).

You could also try to set up your own heroku app by cloning/forking this repository and [hooking it up with heroku] (http://devcenter.heroku.com/articles/rails31_heroku_cedar). You should use the heroku_assets branch, as there are all the precompiled assets (somehow heroku auto compile doesn't work anymore with Rails 3.2 at least nor for me).

## Why you got so many issues? / How can I help?
Most of the issues are features that we thought of when originally developing this web applications - if you feel like being generous go ahead and have a look at the issues list and see if you might want to help implement a feature.

## Feedback
We would love to hear from you what you think about TracketyTrack and what we could do to make it an even better user story tracker. We don't have good communication channels right now, so for now please open a github issue or send one of the contributors a message.

## Who has done this?
This project started out as a student project at the Blekinge Institute of Technology (Sweden) by 4 exchange students from Germany and now we hope to maintain it as open source software and use it on our next own projects.

## License
This project is open source, as you can see. It is licensed under the [MIT license](http://www.opensource.org/licenses/MIT), which can also be found in the LICENSE file.

## Thanks
Thanks to all the maintainers and contributors of all the software and infrastructure we use. You really made our lives a lot easier! Just to name a few:

* Thanks to Matz & the ruby core team (and all committers) for Ruby. Also to all the maintainers of the alternative implementations.
* Thanks to dhh for inventing Rails and making web development a lot easier. Of course also to everybody who has ever helped with rails.
* Thanks to github for hosting our code and a good infrastructure including Issues and everything.
* Thanks to intelliJ as they make a super cool IDEs and are so awesome that they gave us an open source license for RubyMine for TracketyTrack!
* Thanks to TravisCI for being the most awesome, easiest continous integration tool out there!
* Thanks to everybody working on rspec making testing easy and at the same time documenting our code.
* Thanks to Jonas Nicklas for turnip and capybara helping with itnegration testing.
* Thanks to heroku for letting us deploy applications for free.
* Thanks to everybody involved in agile development for letting us have fun while developing software.

