import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final Report report;

	Delete({this.report});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(report: report),
		);
	}
}

