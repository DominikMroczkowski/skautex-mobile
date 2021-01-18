import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart' as models;

import 'bloc/bloc.dart';
import 'view.dart';

class PlayerReport extends StatelessWidget {
	final Function updateUpperPage;
	final models.PlayerReport playerReport;

	PlayerReport({@required this.updateUpperPage, @required this.playerReport});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			update: updateUpperPage,
			report: playerReport
		);
	}
}

