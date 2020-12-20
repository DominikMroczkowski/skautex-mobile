import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/download.dart';
import 'package:skautex_mobile/src/models/file.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Download {
	final File file;

	download() {downloadItem(file);}

	Bloc(BuildContext context, {@required this.file}) {
		otp = context;
	}
}
