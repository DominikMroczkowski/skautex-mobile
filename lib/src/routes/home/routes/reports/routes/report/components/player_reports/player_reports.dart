import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart' as models;

import 'bloc/bloc.dart';
import 'view.dart';

class PlayerReports extends StatelessWidget {
	List<models.PlayerReport> reports;

	PlayerReports({this.reports});

	Widget build(BuildContext context) {
		return Provider(
			child: View(),
			context: context,
			reports: reports
		);
	}
}
