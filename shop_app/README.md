# shop_app

Flutter & Dart - The Complete Guide [2021 Edition]

Section 8 - 12

# Getting Started

#### shop_app/lib/providers/auth.dart
- Replace **API_KEY** with yours

- Replace **SIGN_IN_SEGMENT** with recent from <https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password>

- Replace **SIGN_UP_SEGMENT** with recent from <https://firebase.google.com/docs/reference/rest/auth#section-create-email-password>

- Replace **URL** with common endpoint from
	- <https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password>
	- <https://firebase.google.com/docs/reference/rest/auth#section-create-email-password>
 

#### shop_app/lib/providers/orders.dart
- Replace **DATABASE_URL** with yours

#### shop_app/lib/providers/product.dart

- Replace **DATABASE_URL** with yours

# Realtime Flutter Rules

	{
  		"rules": {
    		".read": "auth != null",  
    		".write": "auth != null",
    	"products": {
      		".indexOn": ["creatorId"],
    	}
  	}
    
# Dependencies

- provider -> <https://pub.dev/packages/provider>
- intl -> <https://pub.dev/packages/intl>
- http -> <https://pub.dev/packages/http>
- shared_preferences -> <https://pub.dev/packages/shared_preferences>
- flutter_launcher_icons -> <https://pub.dev/packages/flutter_launcher_icons>