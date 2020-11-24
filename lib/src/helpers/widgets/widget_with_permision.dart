import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/permissions.dart';

class WidgetWithPermission extends StatelessWidget {

	final Stream stream;
	final Function widget;
	final Permissions permissions;
	final List<dynamic> arguments;

	WidgetWithPermission({@required this.stream, @required this.widget, @required this.permissions, this.arguments});

	Widget build(BuildContext context) {
		return StreamBuilder(
			stream: stream,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return Container(width: 0.0, height: 0.0);

				return FutureBuilder(
					future: snapshot.data,
					builder: (context, snapshot) {
						if (!snapshot.hasData)
							return Container(width: 0.0, height: 0.0);
						if (!permissions.XOR((snapshot.data as Permissions)))
							return Container(width: 0.0, height: 0.0);

						return Function.apply(widget, arguments);
					}
				);
			}
		);
	}
}
