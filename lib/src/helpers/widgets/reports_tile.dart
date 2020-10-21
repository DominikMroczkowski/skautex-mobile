import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as session;

import 'tile.dart';

class ReportsTile extends StatelessWidget {
	final Report report;

	ReportsTile({this.report});

	Widget build(context) {
		return Container(
			child: buildTile(context, report),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget buildTile(BuildContext context, Report report) {
		List<Widget> children = [
			_text(report.title, 18),
			Row(children: <Widget>[
				Expanded(child: _text(report.owner, 14), flex: 3),
				Expanded(child: Container()),
				Expanded(child: _text(report.closeDate, 14, Alignment.centerRight), flex: 3),
			],)
		];
		String text;

		if (DateTime.now().isAfter(DateTime.parse(report.closeDate))) {
			text = 'Do wykonania';
		} else {
			text = 'Zamknięty';
		}

		children.add(_text(text, 14));

		return Tile(
			children: children,
			func: onTileTap,
			args: null,
			positionalArgs: [context]
		);
	}

	_text(text, double font, [alignment]) {
		alignment ??= Alignment.centerLeft;
		return Align(
			child: Text(
				text,
				overflow: TextOverflow.fade,
				style: TextStyle(
					fontSize: font,
				)
			),
			alignment: alignment
		);
	}

	onTileTap(BuildContext context)	{
		final s = session.Provider.of(context);
		s.changeClicked(report.uri);
		Navigator.pushNamed(context, '/home/report');
	}
}
