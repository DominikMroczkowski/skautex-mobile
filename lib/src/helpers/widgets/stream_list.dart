import 'package:flutter/material.dart';

class StreamList extends StatelessWidget {

	final Stream stream;
	final Function tile;

	StreamList({this.stream, this.tile});

	Widget build(BuildContext context) {
		return StreamBuilder(
			stream: stream,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return Center(
						child: CircularProgressIndicator()
					);
				}

				return FutureBuilder(
					future: snapshot.data,
					builder: (context, snapshot) {
						if (!snapshot.hasData) {
							return Center(
								child: CircularProgressIndicator()
							);
						}

						return ListView.builder(
							itemCount: snapshot.data.length,
							itemBuilder: (context, int index) {
								return tile(
									snapshot.data[index]
								);
							}
						);
					}
				);
			}
		);
	}
}
