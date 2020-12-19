import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/download.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Download {
	final Report report;

	Bloc(BuildContext context, {this.report}) {
		otp = context;
	}

	startDownload() {
		downloadItem(report.uri + '/download');
	}

	dispose() {
	}
}
