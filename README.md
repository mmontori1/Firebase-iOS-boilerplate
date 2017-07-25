# Firebase-boilerplate
iOS + Firebase boilerplate

This boilerplate is to start off an iOS project with a simple setup with Firebase to create projects with simple authentication, database, and storage from Firebase. You can see it in action by running the Example project through X-code.

## How to setup

After cloning/forking the repo, You have to first work on setting up all the files to the project and connecting it to Firebase. Copy over all the files in the Files folder and apply them to the project you've created.
You need to apply Firebase using CocoaPods by running this within the project directory on terminal:
```
pod init
pod install
```
Then add these lines to your Podfile in your project and pod install again.
```
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
```
From there, all you have to do is setup your Firebase online and connect the project from there.

## Applying Firebase to the project
