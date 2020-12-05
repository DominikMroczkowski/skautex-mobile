import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class StreamList extends StatelessWidget {

	final Stream itemsWatcher;
	final Stream requestWatcher;
	final Function tile;
	final Function notify;
	final AutoScrollController controller;

	StreamList({this.itemsWatcher, this.requestWatcher, this.tile, this.controller, this.notify});

	Widget build(BuildContext context) {
		return StreamBuilder(
			stream: itemsWatcher,
			builder: (context, snapshot) {
				if (!snapshot.hasData && requestWatcher != null) {
					return StreamBuilder(
						stream: requestWatcher,
						builder: (_, snapshot) {
							if (snapshot.hasData)
								return FutureBuilder(
									future: snapshot.data,
									builder: (_, snapshot) {
										if (snapshot.hasData)
											return Container(width: 0.0, height: 0.0);
										return Center(child: CircularProgressIndicator());
									}
							);
							return Container(child: Text('Brak danych'));
						}
					);
				}

				if (!snapshot.hasData)
					return Center(child: CircularProgressIndicator());

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
								child: index == snapshot.data.length && requestWatcher != null ?
									Column(children: [tile(snapshot.data[index]), getMoreIndicator()]) :
									tile(snapshot.data[index]),
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

	Widget getMoreIndicator() {
		return StreamBuilder(
				stream: requestWatcher,
				builder: (_, snapshot) {
					if (snapshot.hasData)
						return FutureBuilder(
							future: snapshot.data,
							builder: (_, snapshot) {
								if (snapshot.hasData)
									return Container(width: 0.0, height: 0.0);
								return Container(child: Center(child: CircularProgressIndicator()), height: 20.0);
							}
						);
					return Container(width: 0.0, height: 0.0);
				}
			);
	}
}
