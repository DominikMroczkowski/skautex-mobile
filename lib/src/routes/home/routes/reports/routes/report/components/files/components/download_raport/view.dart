import 'package:flutter/material.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return RaisedButton(
			onPressed: bloc.startDownload,
			child: Icon(Icons.download_rounded),
		);
	}
}
