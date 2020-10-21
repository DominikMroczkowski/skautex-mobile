import 'package:rxdart/rxdart.dart';

class CostMixin {
	final _name = BehaviorSubject<String>();
	final _cost = BehaviorSubject<String>();
	final _date = BehaviorSubject<String>();
	final _file = BehaviorSubject<String>();

	Stream<String> get name => _name.stream;
	Stream<String> get cost => _cost.stream;
	Stream<String> get date => _date.stream;
	Stream<String> get file => _file.stream;

	Stream<bool> get submitValid  => Rx.combineLatest([name, cost, date], (_) { return true;});

	Function(String) get changeName => _name.sink.add;
	Function(String) get changeCost => _cost.sink.add;
	Function(String) get changeDate => _date.sink.add;
	Function(String) get changeFile => _file.sink.add;

	dispose() {
		_name.close();
		_cost.close();
		_date.close();
		_file.close();
	}
}
