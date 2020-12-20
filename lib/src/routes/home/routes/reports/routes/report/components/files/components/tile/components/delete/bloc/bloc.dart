import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/file.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final File file;
	Bloc(BuildContext context, {this.file}) {
		otp = context;
	}
}
