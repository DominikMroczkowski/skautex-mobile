import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'components/add/add.dart';
import 'components/tile/tile.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {
	final Report report;

	View({this.report});

	Widget build(context) {
		return Column(
			children: [
				Container(child: _name(), margin: EdgeInsets.all(8.0),),
				_banList(context)
			]
		);
	}

	Widget _name() {
		return Row(
			children: [
				Text(
					'Powiązane pliki:',
					softWrap: true,
				),
				Expanded(child: Container()),
				Add(report: report),
			]
		);
	}

	_banList(BuildContext context) {
		final bloc = Provider.of(context);
		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (i) => Tile(file: i),
			scrollable: false
		);
	}
}
