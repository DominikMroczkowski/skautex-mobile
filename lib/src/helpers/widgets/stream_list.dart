import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class StreamList extends StatelessWidget {

	final Stream stream;
	final Function tile;
	final AutoScrollController controller;

	StreamList({this.stream, this.tile, this.controller});

	Widget build(BuildContext context) {
		return StreamBuilder(
			stream: stream,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return Container(child: Text('Lista jest pusta'));
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
								if (controller == null)
									return tile(snapshot.data[index]);

								return AutoScrollTag(
									key: ValueKey(index),
									index: index,
									child: tile(
										snapshot.data[index]
									),
									controller: controller,

								);
							},
							padding: EdgeInsets.only(bottom: 80),
							shrinkWrap: true,
							controller: controller
						);
					}
				);
			}
		);
	}
}
