import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import '../../models/report.dart';
import '../mixins/item_list.dart';

class Bloc extends ItemList<Report> {
	Bloc(BuildContext context) {
		otp = context;
	}
}
