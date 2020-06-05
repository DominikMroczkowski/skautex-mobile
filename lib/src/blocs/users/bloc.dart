import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import '../../models/user.dart';
import '../mixins/item_list.dart';

class Bloc extends ItemList<User> {
	Bloc(BuildContext context) {
		otp = context;
	}
}
