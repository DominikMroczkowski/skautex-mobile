import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'bloc/bloc.dart';
import 'view.dart';

class PlayerReport extends StatelessWidget {
	Report report;

	PlayerReport({this.report});

	Widget build(BuildContext context) {
		return Provider(
			child: View(),
			context: context,
			report: report
		);
	}
}
