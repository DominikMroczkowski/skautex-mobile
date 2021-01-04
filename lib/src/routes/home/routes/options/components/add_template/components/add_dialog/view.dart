import 'package:flutter/material.dart';
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
									title: Text('Not ready')
								);
							return AlertDialog(
								title: Text('Ready'));
						}
					);
				return form.Form(bloc: bloc);
			},
		);
	}
}

