import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

class FileField extends StatelessWidget{
	final Function(String) change;
	final AsyncSnapshot<String> path;

	FileField({@required this.change, this.path});

	Widget build(BuildContext context) {
		return Row(
			children: [
				Expanded(child: _file(context), flex: 2),
			]
		);
	}

	Widget _file(BuildContext context) {
		return GestureDetector(
		  onTap: () async {
				final f = await FlutterDocumentPicker.openDocument();


				if(f != null) {
   				final path = f;
					change(path);
				}
			},
  		child: AbsorbPointer(
    		child: _dateField()
  		)
		);
	}

	Widget _dateField() {
		return TextField(
			controller: TextEditingController(text: path.data ?? ''),
			decoration: InputDecoration(
				errorText: path.error
			)
		);
	}
}
