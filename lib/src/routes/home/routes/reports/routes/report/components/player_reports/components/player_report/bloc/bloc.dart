import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/update.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'package:skautex_mobile/src/helpers/widgets/dialog_info.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Update<PlayerReport> {
	final PlayerReport value;

	final Function _updateReport;
	final _edit = BehaviorSubject<bool>();
	get edit => _edit.stream;
	toggleEdition() {_edit.sink.add(!_edit.value);}

	final _editedPlayer = BehaviorSubject<PlayerReport>();
	final _playerReport = BehaviorSubject<PlayerReport>();

	Stream get playerReport => _playerReport.stream;

	changePlayerReport(PlayerReport report, {int value, int index, String description}) async {
		int profile = 0;
		int j = 0;
		report.profiles.forEach(
			(i) {
				if (description != null)
					report.profiles[profile].description = description;
				int statistic = 0;
				if (description == null)
					i.statistics.forEach(
						(i) {
							if (j == index)
								report.profiles[profile].statistics[statistic].value = value;
							j++;
							statistic++;
						}
					);
				int group = 0;
				statistic = 0;

				if (description == null)
				i.group.forEach(
					(i) {
						int statistic = 0;
						i.statistics.forEach(
							(i) {
								if (j == index)
									report.profiles[profile].group[group].statistics[statistic].value = value;
								j++;
								statistic++;
							}
						);
						group++;
					}
				);
				profile++;
			}
		);
		_editedPlayer.sink.add(report);
	}

	update() {
		toggleEdition();
		updateItem(_playerReport.value);
	}

	Bloc(BuildContext context, {this.value, Function updateReport}) :
		_updateReport = updateReport {
		otp = context;
		_edit.sink.add(false);
		final _t = StreamTransformer<bool, PlayerReport>.fromHandlers(
			handleData: (bool i, sink) {
				if (!i)
					sink.add(value);
			}
		);
		Rx.merge([_edit.transform(_t), _editedPlayer.stream]).pipe(_playerReport);
		item.listen(
			(i) {
				i.then(
					(i) {
						_updateReport();
					}
				);
			}
		);
		item.listen(
			(i) {
				print(i.toString());
				showDialog(
					context: context,
					builder:  (c) {
						return DialogInfo(future: i, title: 'Aktualizuję');
					}
				);
			}
		);
	}

	dispose() {
		super.dispose();
		_playerReport.close();
		_editedPlayer.close();
	}
}
