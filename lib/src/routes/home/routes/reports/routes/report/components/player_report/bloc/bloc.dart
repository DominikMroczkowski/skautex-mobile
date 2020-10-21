import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/blocs/mixins/update.dart';
import '../../models/player_report.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	Update<PlayerReport> _updater = Update<PlayerReport>();
	BehaviorSubject<Future<PlayerReport>> _playerReport = BehaviorSubject<Future<PlayerReport>>();
	List<StatisticInput> statInputs = [];
	BehaviorSubject<bool> _isEditable = BehaviorSubject<bool>();

	get isEditable => _isEditable.stream;

	toggleEdition() async {
		bool shouldReturnToPreviousState = _isEditable.value;
		statInputs.forEach((i) => i.refresh());
		_isEditable.sink.add(!_isEditable.value);
		if (shouldReturnToPreviousState) {
			PlayerReport report = await _playerReport.value;
			int index = 0;
			statInputs.forEach((i) {
				i.changeRating(report.statistics[index].value);
				index += 1;
			});
		}
	}

	get playerReport => _playerReport.stream;

	Bloc(BuildContext context, PlayerReport playerReport) {
		_playerReport.add(Future.value(playerReport));
		_updater.otp = context;

		playerReport.statistics.forEach(
			(i) {
				statInputs.add(StatisticInput(rating: i.value));
			}
		);

		_isEditable.sink.add(false);
		_updater.item.pipe(_playerReport);
	}

	update() async {
		PlayerReport report = await _playerReport.value;

		int index = 0;
		statInputs.forEach(
			(i) {
				report.statistics[index].value = i.getValue();
				index += 1;
			}
		);

		_updater.updateItem(report);
	}

	dispose() {
		_isEditable.close();
	}
}

class StatisticInput {
	BehaviorSubject _stream = BehaviorSubject<int>();

	StatisticInput({int rating}) {
		_stream.sink.add(rating ?? 0);
	}

	getValue() {
		return _stream.value;
	}

	get rating => _stream.stream;
	Function(int) get changeRating => _stream.sink.add;

	refresh() {
		_stream.sink.add(_stream.value);
	}

	dispose() {
		_stream.close();
	}
}
