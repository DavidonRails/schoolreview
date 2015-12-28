![Build Status](https://codeship.com/projects/65bf3820-42b3-0133-38f3-1eb5f82d52fc/status?branch=master)

### Welcome! This is Linghan's EdTech side project

The website is online now, please visit [The Lightning project](http://schoolreview.herokuapp.com/)!

The reason behind this app is partly stated in my [last blog](http://www.linghanxing.com/blog-1/2015/9/25/what-do-i-want-to-do-if-im-provided-with-unlimited-moneyresources). I don't claim I will fix all the problem I mentioned but this would be my first attempt to improve the situation.

The web app is set to answer the question: What and Why, instead of How.

This web app has _two_ program purposes:
1. A built in skill planner that help a user gauge their ability and arrange schedule, which should also provide a visual way to display their skill sets and program timeline.
2. Help those prospect students assess their own circumstances and achieve a best fit program by connecting them with those who has already attended it.

---
Besides that I will also implement a commenting and reviewing component, though not the focus, I believe its important to have a reputation system in this app.

### Roadmap
Here are the features I'd like to have in the breakable toy:

#### Birth of Lightning review

I am awfully frustrated when I was trying to find out what program to take and where to learn faster. The internet gives us the mirage that we have access of the world but the big question lies in how to choose the right one, and more importantly, we need a place to visually display our skill sets and programs. The current options in LinkedIn are not very visual, not to mention serve the purpose.

* The first step of this web app is to construct a place where users could easily display their skill sets and programs, also communicate with each other through Q&A.

* The second stage will then focus on building a querying system and analysing page for our uses to choose the program/course that best fit them.

#### Dream features:
1. An algorithm to process user time schedule and arrange suitable learning projects for him.
2. A data analysis section to display different users in distribution.
3. Helper session, where user can input their own skills and target, the system will return the right courses they need. √
4. Highcharts data analysis part. Where user can see all the data we have on our website. √
5. The homepage should have a section that calculates how many mentors are available near you, like in the [facebook react convention](https://www.youtube.com/watch?list=PLb0IAmt7-GS1cbw4qonlQztYV1TAW0sCr&v=KVZ-P-ZI6W4).

#### Basic features:
1. The ability to add/edit/destroy/read a college review. √
2. User sign up/out √
3. Pagination √
4. Email system √
5. Verification system when log-in
6. Rich text editor √
7. Ability to vote and rate on reviews. √
8. Search box √
9. Enable foundation icons √
10. Favicon icons
11. Limit characters in `show` √

### Learning object:
In the meantime this project also acts as a learning component of __Launch Academy__. The learning component I want to have here is: (hopefully, :/)

Be _proficient_ in:
  * Ruby on rails √
  * Ruby as a language √
  * HTML requests √
  * Data structure √
  * JavaScript & CSS √
  * foundation-rails √
  * Highcharts and Highmaps √

Be _familiar_ with:
  * Rich text editor components. √
  * AJAX implementation √
  * React.js x
  * Data analysis not_yet

#### Config of Elasticsearch in local environment

1. Install Elasticsearch with `brew install elasticsearch`
2. Input 'brew install elasticsearch' to get more info.
3. For search functions, remember to run 'elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'

#### Launch google chromedriver
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.chromedriver.plist

### Edited Nov 10
* Add Chinese translation, visit 'schoolreview.herokuapp.com/?local=zh'
