import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart';

class StatisticField extends StatelessWidget {
	final String name;
	final int value;
	final Function changeValue;
	final int index;
	final PlayerReport report;

	StatisticField({@required this.name, @required this.value, @required this.changeValue, @required this.index, @required this.report});

	Widget build(BuildContext context) {
		return Column(
			children: [
				Row(
					children: [
						Expanded(child: _statisticName(name), flex: 5),
						Expanded(child: _statisticValue(value), flex: 1),
					],
				),
				_ratingStars()
			]
		);
	}

	Widget _statisticName(String text) {
		return Align(
			child: Text(
				text,
				style: TextStyle(
					fontSize: 14,
				),
				overflow: TextOverflow.clip
			),
			alignment: Alignment.topLeft,
		);
	}

	Widget _statisticValue(int value) {
		return Align(
			child: Text(
				value.toString(),
				style: TextStyle(
					fontSize: 14,
				),
				overflow: TextOverflow.clip
			),
			alignment: Alignment.center,
		);
	}

	_ratingStars() {
		if (changeValue == null)
			return Container(width: 0.0, height: 0.0);
		return Slider(
      onChanged: (double value) => Function.apply(changeValue, [report], {#value: value.toInt(), #index: index}),
      max: 10,
			min: 0,
			value: value.toDouble(),
    );
	}
}
