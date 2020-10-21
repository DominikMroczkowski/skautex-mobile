import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/helpers/blocs/delete.dart';

class Bloc extends Delete {

	Bloc(BuildContext context) {
		otp = context;
	}
}
