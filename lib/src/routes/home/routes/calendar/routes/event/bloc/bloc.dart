import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/event.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc  {
	final _event = BehaviorSubject<Event>();
	Stream<Event> get event =>  _event.stream;
	Function(Event) get changeEvent => _event.sink.add;

	Bloc({Event event}) {
		_event.sink.add(event);
	}

	dispose() {
		_event.close();
	}
}
