import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:path/path.dart';

class FileField extends StatelessWidget{
	final Function(String) change;
	final AsyncSnapshot<String> snapshot;

	FileField({@required this.change, this.snapshot});

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
			controller: TextEditingController(text: snapshot.hasData ? basename(snapshot.data) : ''),
			decoration: InputDecoration(
				labelText: 'Plik',
				errorText: snapshot?.error
			)
		);
	}
}
