# chat_app

Flutter & Dart - The Complete Guide [2021 Edition]

Section 14

## Getting Started

### Android
Add the chat_app to a Firebase Project

- Application ID can be found in <b>chat_app/android/app/build.gradle</b>
- Place your "google-services.json" in <b>chat_app/android/app</b>
- Set current 'google-services' classpath in dependencies in <b>chat_app/android/build.gradle</b>
 - Add current 'google-services' plugin and dependencies in <b>chat_app/android/app/build.gradle</b>

### IOS

Add the chat_app to a Firebase Project

- Application ID can be found in 'XCode' General Tab
- Place your "GoogleService-info.plist" in <b>chat_app/ios/Runner</b>

## Firestore Rules

	match /users/{uid} {
    	allow write: if request.auth != null && request.auth.uid == uid;
    }
    match /users/{uid}{
    	allow read: if request.auth != null;
    }
    match /chats/{document=**}{
    	allow read, create: if request.auth != null;
    }