import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/totp_device.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as session;

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<TOTPDevice> {

	Bloc(BuildContext context) {
		otp = context;
		session.Provider.of(context).me.listen((i) {
			i.then((User i) {
				var list = i.uri.split('/');
				list.removeLast();
				fetch(where: {'user': list.last});
			});
		});
	}
}
