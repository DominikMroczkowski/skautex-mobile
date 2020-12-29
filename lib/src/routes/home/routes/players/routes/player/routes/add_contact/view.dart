import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/models/contact_detail.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Dodaj informacje kontaktowe'),
			),
			body: _body(context),
		);
	}

	Widget _body(BuildContext context) {
		final bloc = Provider.of(context);
		return SingleChildScrollView(
			child: Column(
				children: [
					_padding(_type(bloc)),
					_padding(_value(bloc)),
					_padding(_add(bloc))
				],
			)
		);
	}

	Widget _type(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.type,
			builder: (_, snapshot) {
				List<DropdownMenuItem<String>> items = [];
				contactTypes.forEach(
					(i) =>
						items.add(DropdownMenuItem(child: Text(i), value: i))
				);
				return DropdownButtonFormField<String>(
					value: snapshot.data,
					items: items,
					onChanged: bloc.changeType
				);
			}
		);
	}

	Widget _value(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.value,
			builder: (_, snapshot) {
				return TextFormField(
					initialValue: snapshot.data ?? '',
					onChanged: bloc.changeValue
				);
			}
		);
	}

	Widget _add(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.submitValid,
			builder: (_, snapshot) {
				return Row(
					children: [
						Expanded(child: Container()),
						RaisedButton(
							child: _indicator(bloc),
							onPressed: snapshot.hasData && snapshot.data == true ? bloc.addContact : null,
						)
					]
				);
			}
		);
	}

	Widget _indicator(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.item,
			builder: (_, snapshot) {
				bool indicator = snapshot.hasData && snapshot.connectionState != ConnectionState.done;
				return indicator ? CircularIndicator() : Text('Dodaj');
			}
		);
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(8.0)
		);
	}
}
