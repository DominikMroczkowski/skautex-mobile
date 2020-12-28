import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Files extends StatelessWidget {
	final Report report;
	final Stream reload;

	Files({@required this.report, this.reload});

	Widget build(BuildContext context) {
		return Provider(
			child: View(report: report),
			context: context,
			report: report,
			reload: reload
		);
	}
}
