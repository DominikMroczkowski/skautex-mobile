import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/models/player.dart';

class Invitation {
	String uri;
	User trainer;
	User owner;
	Player player;
	String creationDate;
	File invitation;

	Invitation.fromJson(Map<String, dynamic> parsedJson):
		uri = parsedJson['url'],
		trainer = User.fromJson(parsedJson['trainer']),
		owner = User.fromJson(parsedJson['owner']),
		player = Player.fromJson(parsedJson['player']),
		invitation = File(uri: parsedJson['invitation_file']);
}
