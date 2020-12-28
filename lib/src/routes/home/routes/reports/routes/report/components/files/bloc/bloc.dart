import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<File> {
	final Report report;
	final Stream reload;

	Bloc(BuildContext context, {this.report, this.reload}) {
		otp = context;
		super.fetch(uri: report.uri + 'files/');
		reload.listen((i) {
			fetch(uri: report.uri + 'files/');
		});
	}

	dispose() {
		super.dispose();
	}
}
