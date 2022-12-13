<!--
Name of your final project
-->
# Treck Track
![Swift](https://img.shields.io/badge/swift-5.5-brightgreen.svg) ![Xcode 13.2+](https://img.shields.io/badge/xcode-13.2%2B-blue.svg) ![iOS 15.0+](https://img.shields.io/badge/iOS-15.0%2B-blue.svg) ![watchOS 8.0+](https://img.shields.io/badge/watchOS-8.0%2B-blue.svg) ![CareKit 2.1+](https://img.shields.io/badge/CareKit-2.1%2B-red.svg) ![ci](https://github.com/netreconlab/CareKitSample-ParseCareKit/workflows/ci/badge.svg?branch=main)

## Description
<!--
Give a short description on what your project accomplishes and what tools is uses. Basically, what problems does it solve and why it's different from other apps in the app store.
-->
Trek Track utilizes [CareKit](https://github.com/carekit-apple/CareKit), [ParseCareKit](https://github.com/netreconlab/ParseCareKit), and ResearchKit to build the foundation of the app, store the data in the cloud and provide indepth data collection respectively.

Trek Track is an application that focuses on building good habits through simple daily tasks. These habits can help the user gain more control of their day-to-day life. This process must stay as simple as possible. That is why Trek Track includes a default daily schedule right out of the box. This schedule of tasks includes items such as eating three meals a day, resisting the urge to get on your phone first thing in the morning, logging breaks from work every hour, etc. All these tasks are organized by the order in which you are supposed to complete them, however, these schedules for the tasks are only suggestions allowing the user to complete them in any order. This is designed to help people get out of a rut without having to overthink it. The simplicity of Trek Track is what differentiates it from other habit-forming apps. Rather than providing a blank slate and potentially overwhelming the user, Trek Track gives the user a starting point that focuses on the little things and attempts to emphasize how important they are to improving everyday life.

### Demo Video
<!--
Add the public link to your YouTube or video posted elsewhere.
-->
To learn more about this application, watch the video below:

<a href="http://www.youtube.com/watch?feature=player_embedded&v=mib_YioKAQQ
" target="_blank"><img src="http://img.youtube.com/vi/mib_YioKAQQ/0.jpg" 
alt="Sample demo video" width="240" height="180" border="10" /></a>

### Designed for the following users
<!--
Describe the types of users your app is designed for and who will benefit from your app.
-->
Trek Track is designed for people who find themselves lacking the motivation to do even the most basic tasks. Whether they are depressed, looking for a change, or both. Trek Track can kickstart their journey right out of the box. Trek Track is not a fix-all for the users' problems, but it can help encourage them to seize the day and feel accomplished when they end the day and can see all the productive things they did. It is for those people who want to build long-lasting daily habits. That is why almost every task is assigned every day or every other day. Trek Track is not designed for those who want to lay out their calendar for the month. It is for those who want to work on focusing on what they can do today.
<!--
In addition, you can drop screenshots directly into your README file to add them to your README. Take these from your presentations.
-->
<img src="https://user-images.githubusercontent.com/8621344/101721031-06869500-3a75-11eb-9631-88927e9c8f00.png" width="300"> <img src="https://user-images.githubusercontent.com/8621344/101721111-33d34300-3a75-11eb-885e-4a6fc96dbd35.png" width="300"> <img src="https://user-images.githubusercontent.com/8621344/101721146-48afd680-3a75-11eb-955a-7848146a9d6f.png" width="300"><img src="https://user-images.githubusercontent.com/8621344/101721182-5cf3d380-3a75-11eb-99c9-bde40477acf3.png" width="300">

<!--
List all of the members who developed the project and
link to each members respective GitHub profile
-->
Developed by: 
- [Curt Whelan](https://github.com/curtawhelan) - `University of Kentucky`, `Computer Science`

ParseCareKit synchronizes the following entities to Parse tables/classes using [Parse-Swift](https://github.com/parse-community/Parse-Swift):

- [x] OCKTask <-> Task
- [x] OCKHealthKitTask <-> HealthKitTask 
- [x] OCKOutcome <-> Outcome
- [x] OCKRevisionRecord.KnowledgeVector <-> Clock
- [x] OCKPatient <-> Patient
- [x] OCKCarePlan <-> CarePlan
- [x] OCKContact <-> Contact

**Use at your own risk. There is no promise that this is HIPAA compliant and we are not responsible for any mishandling of your data**

<!--
What features were added by you, this should be descriptions of features added from the [Code](https://uk.instructure.com/courses/2030626/assignments/11151475) and [Demo](https://uk.instructure.com/courses/2030626/assignments/11151413) parts of the final. Feel free to add any figures that may help describe a feature. Note that there should be information here about how the OCKTask/OCKHealthTask's and OCKCarePlan's you added pertain to your app.
-->
## Contributions/Features

## Final Checklist
<!--
This is from the checkist from the final [Code](https://uk.instructure.com/courses/2030626/assignments/11151475). You should mark completed items with an x and leave non-completed items empty
-->
- [x] Signup/Login screen tailored to app
- [ ] Signup/Login with email address
- [x] Custom app logo
- [x] Custom styling
- [x] Add at least **5 new OCKTask/OCKHealthKitTasks** to your app
  - [x] Have a minimum of 7 OCKTask/OCKHealthKitTasks in your app
  - [x] 3/7 of OCKTasks should have different OCKSchedules than what's in the original app
- [x] Use at least 5/7 card below in your app
  - [x] InstructionsTaskView - typically used with a OCKTask
  - [x] SimpleTaskView - typically used with a OCKTask
  - [x] Checklist - typically used with a OCKTask
  - [x] Button Log - typically used with a OCKTask
  - [x] GridTaskView - typically used with a OCKTask
  - [x] NumericProgressTaskView (SwiftUI) - typically used with a OCKHealthKitTask
  - [ ] LabeledValueTaskView (SwiftUI) - typically used with a OCKHealthKitTask
- [x] Add the LinkView (SwiftUI) card to your app
- [ ] Replace the current TipView with a class with CustomFeaturedContentView that subclasses OCKFeaturedContentView. This card should have an initializer which takes any link
- [x] Tailor the ResearchKit Onboarding to reflect your application
- [ ] Add tailored check-in ResearchKit survey to your app
- [ ] Add a new tab called "Insights" to MainTabView
- [x] Replace current ContactView with Searchable contact view
- [x] Change the ProfileView to use a Form view
- [ ] Add at least two OCKCarePlan's and tie them to their respective OCKTask's and OCContact's 

## Wishlist features
<!--
Describe at least 3 features you want to add in the future before releasing your app in the app-store
-->
1. I would like to add the feature for the user to modify the colors of the app, allowing users to express themselves however they want.
2. The ability for the user to preview their card so they can know what to expect before officially adding it to their account.
3. A timer that locks the user into the app for a certain amount of time so that they can be more present in a room or focus on a task.
4. Allow the user to be able to delete their custom tasks, or modify the built in tasks.

## Challenges faced while developing
<!--
Describe any challenges you faced with learning Swift, your baseline app, or adding features. You can describe how you overcame them.
-->
I ran into a lot of issues during the development of Trek Track. The first and most prominent taking on a project of this size. When working with so many files of so many different types it can be difficult to keep track of the details such as the scope of your implementation or maintaining an organized MVVM-based file structure. All these files caused me problems in terms of the sometimes-overwhelming amount of data types in this project. Learning how to initialize, modify and utilize these data structures took a lot of reading of the documentation. The third and final challenge that stuck out to me the most was keeping up with a fast-paced development cycle. This affected development in two different ways. The first being that I had to stay at a steady but expedited pace, which tends to be difficult for me as a developer as I will often stick to a problem until it is done. This meant it was very easy to fall behind and then have long days to catch back up again.

## Setup Your Parse Server

### Heroku
The easiest way to setup your server is using the [one-button-click](https://github.com/netreconlab/parse-hipaa#heroku) deplyment method for [parse-hipaa](https://github.com/netreconlab/parse-hipaa).


## View your data in Parse Dashboard

### Heroku
The easiest way to setup your dashboard is using the [one-button-click](https://github.com/netreconlab/parse-hipaa-dashboard#heroku) deplyment method for [parse-hipaa-dashboard](https://github.com/netreconlab/parse-hipaa-dashboard).
