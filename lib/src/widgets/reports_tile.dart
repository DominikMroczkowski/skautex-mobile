import 'package:flutter/material.dart';
import '../models/report.dart';
import '../blocs/reports/bloc.dart' as reports;
import '../blocs/session/bloc.dart' as session;

import 'dart:async';

import 'loading_container.dart';
import 'tile.dart';

class ReportsTile extends StatelessWidget {
	final String uri;

	ReportsTile({this.uri});

	Widget build(context) {
		final u = reports.Provider.of(context);

		return StreamBuilder(
			stream: u.watcher,
			builder: (context, AsyncSnapshot<Map<String, Future<Report>>> snapshot) {
				if (!snapshot.hasData) {
					return LoadingContainer.lineCount(2);
				}

				return FutureBuilder(
					future: snapshot.data[uri],
					builder: (context, AsyncSnapshot<Report> snapshot) {
						if (!snapshot.hasData) {
							return LoadingContainer.lineCount(2);
						}

						return Container(
							child: buildTile(context, snapshot.data),
							padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
						);
					}
				);
			}
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

	onTileTap(context)	{
		final s = session.Provider.of(context);
		s.changeClicked(uri);
		Navigator.pushNamed(context, '/home/report');
	}
}
