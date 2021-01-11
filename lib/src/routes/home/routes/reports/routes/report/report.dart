import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart' as models;

import 'bloc/bloc.dart';
import 'view.dart';

class Report extends StatelessWidget {
	final models.Report report;
	final Function updateUpperPage;

	Report({@required this.report, @required this.updateUpperPage});

	Widget build(BuildContext context) {
		return Provider(
			child: View(),
			context: context,
			report: this.report,
			updateUpperPage: updateUpperPage
		);
	}
}
