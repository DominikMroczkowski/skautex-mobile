import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/cost.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

String _customUrl = 'https://skautex.azurewebsites.net/api/v1/cost_recording/';

class Bloc extends ItemList<Cost> {

	Bloc(BuildContext context) : super(customUrl: _customUrl) {
		otp = context;
	}

}
