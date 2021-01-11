import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'bloc/bloc.dart';
import 'components/form.dart' as form;

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);
		return StreamBuilder(
			stream: bloc.item,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (_, snapshot) {
							if (snapshot.connectionState != ConnectionState.done)
								return AlertDialog(
									title: Text('Oczewiwanie'),
									content: CircularIndicator()
								);
							return AlertDialog(
								title: Text('dodano'));
						}
					);
				return form.Form(bloc: bloc);
			},
		);
	}
}

