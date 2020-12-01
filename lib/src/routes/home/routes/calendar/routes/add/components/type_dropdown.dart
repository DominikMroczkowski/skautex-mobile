import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event_type.dart';

class TypeDropdown extends StatelessWidget {
	final Function(EventType) change;
	final Stream<Future<List<EventType>>> stream;
	final EventType value;

	TypeDropdown({this.stream, this.value, this.change});

	build(BuildContext context) {
		return StreamBuilder(
			stream: stream,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (_, snapshot) {
							if (snapshot.hasData)
								return _dropdown(snapshot.data);
							return loading();
						}
					);
				return loading();
			}
		);
	}

	_dropdown(List<EventType> data) {
		List<DropdownMenuItem<EventType>> items = [];

		data.forEach(
			(i) =>
				items.add(
					DropdownMenuItem<EventType>(
						value: i,
						child: Text(i.name)
					)
				)
		);

		return DropdownButtonFormField(
			items: items,
			onChanged: (EventType i) {i != null ?  change(i) : null;},
			value: value,
			isExpanded: true,
			decoration: InputDecoration(
				labelText: "Wybierz typ"
			),
		);
	}

	loading() {
		return Column(
			children: [
				TextField(
					enabled: false,
				),
				LinearProgressIndicator()
			],
		);
	}

}
