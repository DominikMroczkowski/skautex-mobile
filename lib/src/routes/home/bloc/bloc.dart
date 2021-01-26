import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/models/fcm_device.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Add<FCMDevice> {
	final _messaging = FirebaseMessaging();

	Bloc(BuildContext context) {
		otp = context;
		_messaging.getToken().then((String token) {
			addItem(
				FCMDevice(
					registrationId: token
				)
			);
		});
	}
}
