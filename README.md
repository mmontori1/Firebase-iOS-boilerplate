# Firebase iOS Boilerplate

This boilerplate is to start off an iOS project with a simple setup with Firebase to create projects with simple authentication, database, and storage from Firebase, as well as customize your own login user interface. You can see it in action by running the Example project through X-code. Keep in mind, you need to install the CocoaPods for the Example project to work.

## Setup

### CocoaPod Setup

After cloning/forking the repo, You have to first work on setting up all the files to the project and connecting it to Firebase. Copy over all the files in the Files folder and apply them to a new XCode iOS project you've created. Make sure that the App Delegate and Main.storyboard replace the project's files that you created.

You need to apply Firebase using CocoaPods by running this within the project directory on terminal:
```
pod init
pod install
```
Then add these lines to your Podfile in your project.
```
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
```
Run pod install again within the project directory on terminal.
```
pod install
```
From there, all you have to do is setup your Firebase online and connect the project from there.

### Applying Firebase to the project

Go on Firebase using a Google account and start up a project. 

![alt text](https://cdn.rawgit.com/MakeSchool-Tutorials/Makestagram-Swift-V3/e3d3d494c07f3e0ec8b1600257166d2d6b1a313e/P01-Intro-To-Firebase/assets/02_empty_firebase_console.png)

Now you just want to add Firebase to your app. You can do this by setting the project to iOS. Follow the steps and only do the first two, which are to register the app and download the config file. You don't need to do add the Firebase SDK or add the initializer code since it is already set up. 

![alt text](https://cdn.rawgit.com/MakeSchool-Tutorials/Makestagram-Swift-V3/e3d3d494c07f3e0ec8b1600257166d2d6b1a313e/P01-Intro-To-Firebase/assets/05_initial_project_overview.png)

Make sure you then enable email login in the authentication tab on Firebase.

![alt text](http://i.imgur.com/98Ign92.png)

That's it! Now you can work off making your own iOS app using Firebase.

## Issues

If there are any problems on the project, please go ahead an open up an issue on this repo.

Thanks!

