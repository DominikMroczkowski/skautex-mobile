class FCMDevice {
	String name;
	String registrationId;
	String deviceId;
	bool active;
	bool type;
	String dateCreated;

	FCMDevice({this.registrationId});

	FCMDevice.fromJson(Map<String, dynamic> parsedJson) :
		name  = parsedJson['name'];

	Map<String, dynamic> toPost() {
		return <String, dynamic> {
			'type': 'android',
			'registration_id': registrationId
		};
	}
}
