import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/player_report.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final _playerReports = BehaviorSubject<List<PlayerReport>>();
	Stream<List<PlayerReport>> get reports =>  _playerReports.stream;
	Function(List<PlayerReport>) get changeReports => _playerReports.sink.add;

	final _playerReport = BehaviorSubject<PlayerReport>();
	Stream<PlayerReport> get report =>  _playerReport.stream;
	Function(PlayerReport) get changeReport => _playerReport.sink.add;

	Bloc(List<PlayerReport> reports) {
		changeReports(reports);
	}

	dispose() {
		_playerReports.close();
		_playerReport.close();
	}
}
