import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/download.dart';
import 'package:skautex_mobile/src/models/file.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Download {
	final File file;
	Bloc(BuildContext context, {this.file}) {
		otp = context;
	}
}
