import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class SearchBar extends StatelessWidget {
	final Function change;
	final String title;

	SearchBar({@required this.change, @required this.title});

	Widget build(context) {
		return Provider(
			child: View(title: title),
			change: change,
			defaultTitle: title
		);
	}
}


