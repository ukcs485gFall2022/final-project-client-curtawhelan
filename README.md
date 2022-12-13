<!--
Name of your final project
-->
# Trek Track
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

<a href="http://www.youtube.com/watch?feature=player_embedded&v=asLSwNE51Sw
" target="_blank"><img src="http://img.youtube.com/vi/asLSwNE51Sw/0.jpg" 
alt="mydemo" width="240" height="180" border="10" /></a>

https://youtu.be/asLSwNE51Sw

### Designed for the following users
<!--
Describe the types of users your app is designed for and who will benefit from your app.
-->
Trek Track is designed for people who find themselves lacking the motivation to do even the most basic tasks. Whether they are depressed, looking for a change, or both. Trek Track can kickstart their journey right out of the box. Trek Track is not a fix-all for the users' problems, but it can help encourage them to seize the day and feel accomplished when they end the day and can see all the productive things they did. It is for those people who want to build long-lasting daily habits. That is why almost every task is assigned every day or every other day. Trek Track is not designed for those who want to lay out their calendar for the month. It is for those who want to work on focusing on what they can do today.
<!--
In addition, you can drop screenshots directly into your README file to add them to your README. Take these from your presentations.
-->
<img width="200" alt="homescreen" src="https://user-images.githubusercontent.com/85813299/207330761-ce457420-4f1d-4c02-98a4-e2a15d48b829.png"><img width="200" alt="onboard" src="https://user-images.githubusercontent.com/85813299/207328689-33e5d46f-250d-4da3-83ca-4dbc9b2e5b29.png"><img width="200" alt="onboard2" src="https://user-images.githubusercontent.com/85813299/207328712-5fc64615-6ea1-45d8-9629-b6820d1d7dcc.png">

<img width="200" alt="onboard3" src="https://user-images.githubusercontent.com/85813299/207328731-fb018526-0359-4358-84ae-c093d740aa72.png"><img width="200" alt="onboard4" src="https://user-images.githubusercontent.com/85813299/207328905-88214503-db11-472c-8da0-e67b9220bfcb.png"><img width="200" alt="onboard5" src="https://user-images.githubusercontent.com/85813299/207329059-df76b06b-b859-4d5d-b571-c249a4d33bdc.png">

<img width="200" alt="onboard6" src="https://user-images.githubusercontent.com/85813299/207329109-02117d2e-7609-422d-afcd-e802ab645b7e.png"><img width="200" alt="careview" src="https://user-images.githubusercontent.com/85813299/207329147-fbaab9a0-4f97-40d1-b42a-55353d0f650e.png"><img width="200" alt="careview2" src = "https://user-images.githubusercontent.com/85813299/207332002-8235ab75-d630-4f51-b039-ea6e9847bf11.png">

<img width="200" alt="careview3" src = "https://user-images.githubusercontent.com/85813299/207332048-63331aea-b044-4f71-93f3-0a557a9d58c1.png"><img width="200" alt="careview4" src = "https://user-images.githubusercontent.com/85813299/207332076-c9c607cd-3924-486e-9df9-3df28d23c351.png"><img width="200" alt="careview5" src = "https://user-images.githubusercontent.com/85813299/207332113-a9aae716-33fc-4f6c-8f57-b6d04952053a.png">

<img width="200" alt="careview6" src= "https://user-images.githubusercontent.com/85813299/207332137-876c8d78-c737-4721-a813-2544cec523ae.png"><img width="200" alt="careview7" src= "https://user-images.githubusercontent.com/85813299/207332183-a9d463f2-0f66-42e9-962a-d554bca012f4.png">

<!--
List all of the members who developed the project and
link to each members respective GitHub profile
-->
Developed by: 
- [Curt Whelan](https://github.com/curtawhelan) - `University of Kentucky`, `Computer Science`

Base Code Provided by:
- [Corey Baker](https://github.com/cbaker6) - `Professor at University of Kentucky`, `Computer Science`

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
- I stylized the app to have a uniform look with color coding as well.
- I implemented the beginning steps of the ResearchKit and fully converted the onboarding task, and consent task, to suit my app.
- I used an AI program to generate my app logo and stylized my app around it.
- I created a login page that looks very different from the original app and fixed a bug from the midterm where I had two email fields in the signup section.
- I created five of my OCKTasks: Avoid the phone for an hour in the morning, eating three meals a day, take a break from work every hour, clean up, and bathe. All of which are different card styles.
- I created two HealthKit Tasks: Water Intake (L) and Vitamin D Intake (IU), both of which were NumericProgress cards.
- Gave users the ability to make their HealthKit tasks.
- Gave users the ability to make their CareKit tasks, including fields for Title, Instructions, and Motivation, as well as the choice of what card style they want.
- Revamped the Profile View to use a form to gather Patient and Contact data. I also added a MyContact View inside the Profile View which only displays the current user’s contact and updated the information inside their contact if the information was changed.
- Revamped the Contact View to allow for contacts to be searched for, as well as filter out the current user’s contact.
- Added a link card to the top of the Care View which links to a high-energy song on YouTube to try and motivate users
- Attempted to implement a more fleshed-out custom scheduling system
- Created various Views, ViewModels, ViewModelControllers, Extensions, Constants, etc.
## Final Checklist
<!--
This is from the checkist from the final [Code](https://uk.instructure.com/courses/2030626/assignments/11151475). You should mark completed items with an x and leave non-completed items empty
-->
- [x] Signup/Login screen tailored to app
- [x] Signup/Login with email address
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
