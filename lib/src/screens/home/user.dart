import 'package:flutter/material.dart';

class User extends StatelessWidget {
	build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Skautex')
			),

			body:
				SingleChildScrollView(
				child: Container(
					child: Card(
							child: Container(
								child: Column(
									children: [
										Container(height: 200, color: Colors.white),
										Container(height: 200, color: Colors.red),
										Container(height: 200, color: Colors.blue),
										Container(height: 200, color: Colors.white),
										Container(height: 200, color: Colors.red),
										Container(height: 200, color: Colors.blue),
										Container(height: 200, color: Colors.white),
										Container(height: 200, color: Colors.red),
									]
								),
							padding: EdgeInsets.all(15.0),
							),
						),
					margin: EdgeInsets.all(15.0),
				),
			)
		);
	}
}
