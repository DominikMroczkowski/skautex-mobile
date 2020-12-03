import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class StreamList extends StatelessWidget {

	final Stream stream;
	final Function tile;
	final Function notify;
	final AutoScrollController controller;

	StreamList({this.stream, this.tile, this.controller, this.notify});

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
						return NotificationListener<ScrollNotification>(
  						onNotification: (ScrollNotification scrollInfo) {
    						if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && notify != null)
									Function.apply(notify, []);
								return true;
  						},
  						child: ListView.builder(
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
								controller: controller,
							)
						);
					}
				);
			}
		);
	}
}
