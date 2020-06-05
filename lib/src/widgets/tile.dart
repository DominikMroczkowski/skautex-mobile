import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
	final List<Widget> widgets;
	final Function func;
	final Map<Symbol, dynamic> namedArgs;
	final List positionalArgs;

	Tile({@required List<Widget> children, @required Function func, Map<Symbol, dynamic> args, @required List positionalArgs}) :
		widgets = children,
		func = func,
		namedArgs = args,
		positionalArgs = positionalArgs;

	build(context) {
		return Card(
			child: InkWell(
				child: Container(
					child: Column (
						children: widgets
					),
					padding: EdgeInsets.all(20.0),
				),
				onTap: () {
					Function.apply(func, positionalArgs, namedArgs);
				}
			),
			color: Colors.white,
		);
	}
}
