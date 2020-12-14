import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart' as models;

import 'bloc/bloc.dart';
import 'view.dart';

class PlayerReport extends StatelessWidget {
	final models.PlayerReport playerReport;
	final Function updateReport;

	PlayerReport({this.playerReport, this.updateReport});

	Widget build(BuildContext context) {
		return Provider(
			child: View(),
			context: context,
			playerReport: playerReport,
			updateReport: updateReport
		);
	}
}
