import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class ConnectedUsers extends ItemList<User> {
	final String uri;

	ConnectedUsers({context, this.uri}) {
		otp = context;
		super.fetch(uri: uri + 'connected_users');
	}
}
