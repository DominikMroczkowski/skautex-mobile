import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Bloc extends ItemList<Report> {
	Bloc(BuildContext context) {
		otp = context;
	}
}
