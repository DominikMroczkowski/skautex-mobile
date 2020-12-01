import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Users extends ItemList<User> {
	Users({context}) {
		otp = context;
		super.fetch();
	}
}
