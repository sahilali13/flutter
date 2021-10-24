# chat_app

Flutter & Dart - The Complete Guide [2021 Edition]

Section 14

## Getting Started

### Android
Add the chat_app to a Firebase Project and follow the instructions.

- Application ID can be found in **chat_app/android/app/build.gradle**.

### IOS

Add the chat_app to a Firebase Project and follow the instructions.

- Application ID can be found in **XCode General Tab**.
- Place your *GoogleService-info.plist* in **chat_app/ios/Runner**.
- Be Sure to add the *GoogleService-info.plist* via **Add Option** in **XCode**.

## Firestore Rules

	rules_version = '2';
	service cloud.firestore {
  		match /databases/{database}/documents {
  			match /users/{uid} {
    			allow write: if request.auth != null && request.auth.uid == uid;
    		}
    		match /users/{uid}{
    			allow read: if request.auth != null;
    		}
    		match /chat/{document=**}{
    			allow read, create: if request.auth != null;
    		}
	  	}
	}

## Dependencies
- flutter_launcher_icons -> <https://pub.dev/packages/flutter_launcher_icons>
	- Follow the instructions 
- cloud_firestore -> <https://pub.dev/packages/cloud_firestore>
- firebase_core -> <https://pub.dev/packages/firebase_core>
- firebase_auth -> <https://pub.dev/packages/firebase_auth>
- image_picker -> <https://pub.dev/packages/image_picker>
	- Follow the instructions
- firebase_storage -> <https://pub.dev/packages/firebase_storage>
- path_provider -> <https://pub.dev/packages/path_provider>
