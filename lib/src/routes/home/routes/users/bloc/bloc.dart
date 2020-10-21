import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Bloc extends ItemList<User> {
	Bloc(BuildContext context) {
		otp = context;
	}
}
