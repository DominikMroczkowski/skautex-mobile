import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart' as models;

import 'bloc/bloc.dart';
import 'view.dart';

class Report extends StatelessWidget {
	models.Report report;

	Report({this.report});

	Widget build(BuildContext context) {
		return Provider(
			child: View(),
			context: context,
			report: this.report
		);
	}
}
