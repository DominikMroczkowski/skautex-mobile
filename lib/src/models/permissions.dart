class Permissions {
	bool addAuditentry = false;
	bool changeAuditentry = false;
	bool deleteAuditentry = false;
	bool viewAuditentry = false;
	bool viewOwnAuditentries = false;
	bool addGroup = false;
	bool changeGroup = false;
	bool deleteGroup = false;
	bool viewGroup = false;
	bool addPermission = false;
	bool changePermission = false;
	bool deletePermission = false;
	bool viewPermission = false;
	bool addUser = false;
	bool changeOwnUser = false;
	bool changeUser = false;
	bool deleteOwnUser = false;
	bool deleteUser = false;
	bool viewOwnUser = false;
	bool viewUser = false;
	bool addOrganization = false;
	bool changeOrganization = false;
	bool deleteOrganization = false;
	bool viewOrganization = false;
	bool addOrganizationapikey = false;
	bool changeOrganizationapikey = false;
	bool deleteOrganizationapikey = false;
	bool viewOrganizationapikey = false;
	bool addEmaildevice = false;
	bool changeEmaildevice = false;
	bool changeOwnEmaildevices = false;
	bool deleteEmaildevice = false;
	bool deleteOwnEmaildevices = false;
	bool viewEmaildevice = false;
	bool viewOwnEmaildevices = false;
	bool addStaticdevice = false;
	bool changeOwnStaticdevices = false;
	bool changeStaticdevice = false;
	bool deleteOwnStaticdevices = false;
	bool deleteStaticdevice = false;
	bool viewOwnStaticdevices = false;
	bool viewStaticdevice = false;
	bool addStatictoken = false;
	bool changeStatictoken = false;
	bool deleteStatictoken = false;
	bool viewStatictoken = false;
	bool addTotpdevice = false;
	bool changeOwnTotpdevices = false;
	bool changeTotpdevice = false;

	bool deleteOwnTotpdevices = false;
	bool deleteTotpdevice = false;
	bool viewOwnTotpdevices = false;
	bool viewTotpdevice = false;

	bool addLeague = false;
	bool changeLeague = false;
	bool deleteLeague = false;
	bool viewLeague = false;

	bool addPlayer = false;
	bool changePlayer = false;
	bool deletePlayer = false;
	bool viewPlayer = false;

	bool addPlayerstatus = false;
	bool changePlayerstatus = false;
	bool deletePlayerstatus = false;
	bool viewPlayerstatus = false;

	bool addTeam = false;
	bool changeTeam = false;
	bool deleteTeam = false;
	bool viewTeam = false;

	bool addBlacklistedtoken = false;
	bool changeBlacklistedtoken = false;
	bool deleteBlacklistedtoken = false;
	bool viewBlacklistedtoken = false;

	bool addOutstandingtoken = false;
	bool changeOutstandingtoken = false;
	bool deleteOutstandingtoken = false;
	bool viewOutstandingtoken = false;


	Permissions.fromJson(Map<String, dynamic> parsedJson) {
		(parsedJson['results'] as List).forEach(
			(i) {
				final codeName = i['codename'];
				switch (codeName) {
				case "add_auditentry":
					this.addAuditentry = true;
					break;
				case "change_auditentry":
					this.changeAuditentry = true;
					break;
				case "delete_auditentry":
					this.deleteAuditentry = true;
					break;
				case "view_auditentry":
					this.viewAuditentry = true;
					break;
				case "view_ownAuditentries":
					this.viewOwnAuditentries = true;
					break;
				case "add_group":
					this.addGroup = true;
					break;
				case "change_group":
					this.changeGroup = true;
					break;
				case "delete_group":
					this.deleteGroup = true;
					break;
				case "view_group":
					this.viewGroup = true;
					break;
				case "add_permission":
					this.addPermission = true;
					break;
				case "change_permission":
					this.changePermission = true;
					break;
				case "delete_permission":
					this.deletePermission = true;
					break;
				case "view_permission":
					this.viewPermission = true;
					break;
				case "add_user":
					this.addUser = true;
					break;
				case "change_own_user":
					this.changeOwnUser = true;
					break;
				case "change_user":
					this.changeUser = true;
					break;
				case "delete_own_user":
					this.deleteOwnUser = true;
					break;
				case "delete_user":
					this.deleteUser = true;
					break;
				case "view_own_user":
					this.viewOwnUser = true;
					break;
				case "view_user":
					this.viewUser = true;
					break;
				case "add_organization":
					this.addOrganization = true;
					break;
				case "change_organization":
					this.changeOrganization = true;
					break;
				case "delete_organization":
					this.deleteOrganization = true;
					break;
				case "view_organization":
					this.viewOrganization = true;
					break;
				case "add_organizationapikey":
					this.addOrganizationapikey = true;
					break;
				case "change_organizationapikey":
					this.changeOrganizationapikey = true;
					break;
				case "delete_organizationapikey":
					this.deleteOrganizationapikey = true;
					break;
				case "view_organizationapikey":
					this.viewOrganizationapikey = true;
					break;
				case "add_emaildevice":
					this.addEmaildevice = true;
					break;
				case "change_emaildevice":
					this.changeEmaildevice = true;
					break;
				case "change_own_emaildevices":
					this.changeOwnEmaildevices = true;
					break;
				case "delete_emaildevice":
					this.deleteEmaildevice = true;
					break;
				case "delete_own_emaildevices":
					this.deleteOwnEmaildevices = true;
					break;
				case "view_emaildevice":
					this.viewEmaildevice = true;
					break;
				case "view_own_emaildevices":
					this.viewOwnEmaildevices = true;
					break;
				case "add_staticdevice":
					this.addStaticdevice = true;
					break;
				case "change_own_staticdevices":
					this.changeOwnStaticdevices = true;
					break;
				case "change_staticdevice":
					this.changeStaticdevice = true;
					break;
				case "delete_own_staticdevices":
					this.deleteOwnStaticdevices = true;
					break;
				case "delete_staticdevice":
					this.deleteStaticdevice = true;
					break;
				case "view_own_staticdevices":
					this.viewOwnStaticdevices = true;
					break;
				case "view_staticdevice":
					this.viewStaticdevice = true;
					break;
				case "add_statictoken":
					this.addStatictoken = true;
					break;
				case "change_statictoken":
					this.changeStatictoken = true;
					break;
				case "delete_statictoken":
					this.deleteStatictoken = true;
					break;
				case "view_statictoken":
					this.viewStatictoken = true;
					break;
				case "add_totpdevice":
					this.addTotpdevice = true;
					break;
				case "change_own_totpdevices":
					this.changeOwnTotpdevices = true;
					break;
				case "change_totpdevice":
					this.changeTotpdevice = true;
					break;
				case "delete_ownTotpdevices":
					this.deleteOwnTotpdevices = true;
					break;
				case "delete_totpdevice":
					this.deleteTotpdevice = true;
					break;
				case "view_own_totpdevices":
					this.viewOwnTotpdevices = true;
					break;
				case "view_totpdevice":
					this.viewTotpdevice = true;
					break;
				case "add_league":
					this.addLeague = true;
					break;
				case "change_league":
					this.changeLeague = true;
					break;
				case "delete_league":
					this.deleteLeague = true;
					break;
				case "view_league":
					this.viewLeague = true;
					break;
				case "add_player":
					this.addPlayer = true;
					break;
				case "change_player":
					this.changePlayer = true;
					break;
				case "delete_player":
					this.deletePlayer = true;
					break;
				case "view_player":
					this.viewPlayer = true;
					break;
				case "add_playerstatus":
					this.addPlayerstatus = true;
					break;
				case "change_playerstatus":
					this.changePlayerstatus = true;
					break;
				case "delete_playerstatus":
					this.deletePlayerstatus = true;
					break;
				case "view_playerstatus":
					this.viewPlayerstatus = true;
					break;
				case "add_team":
					this.addTeam = true;
					break;
				case "change_team":
					this.changeTeam = true;
					break;
				case "delete_team":
					this.deleteTeam = true;
					break;
				case "view_team":
					this.viewTeam = true;
					break;
				case "add_blacklistedtoken":
					this.addBlacklistedtoken = true;
					break;
				case "change_blacklistedtoken":
					this.changeBlacklistedtoken = true;
					break;
				case "delete_blacklistedtoken":
					this.deleteBlacklistedtoken = true;
					break;
				case "view_blacklistedtoken":
					this.viewBlacklistedtoken = true;
					break;
				case "add_outstandingtoken":
					this.addOutstandingtoken = true;
					break;
				case "change_outstandingtoken":
					this.changeOutstandingtoken = true;
					break;
				case "delete_outstandingtoken":
					this.deleteOutstandingtoken = true;
					break;
				case "view_outstandingtoken":
					this.viewOutstandingtoken = true;
					break;
				default:
					break;
				}
			}
		);
	}

	Permissions.toXOR();

	XOR(Permissions permissions) {
		if ((addAuditentry && permissions.changeAuditentry) ||
                    (changeAuditentry && permissions.changeAuditentry) ||
                    (deleteAuditentry && permissions.deleteAuditentry) ||
                    (viewAuditentry && permissions.viewAuditentry) ||
                    (viewOwnAuditentries && permissions.viewOwnAuditentries) ||
                    (addGroup && permissions.addGroup) ||
                    (changeGroup && permissions.changeGroup) ||
                    (deleteGroup && permissions.deleteGroup) ||
                    (viewGroup && permissions.viewGroup) ||
		    (addPermission && permissions.addPermission) ||
		    (changePermission && permissions.changePermission) ||
		    (deletePermission && permissions.deletePermission) ||
		    (viewPermission && permissions.viewPermission) ||
		    (addUser && permissions.addUser) ||
		    (changeOwnUser && permissions.changeOwnUser) ||
		    (changeUser && permissions.changeUser) ||
		    (deleteOwnUser && permissions.deleteOwnUser) ||
		    (deleteUser && permissions.deleteUser) ||
		    (viewOwnUser && permissions.viewOwnUser) ||
		    (viewUser && permissions.viewUser) ||
		    (addOrganization && permissions.addOrganization) ||
		    (changeOrganization && permissions.changeOrganization) ||
		    (deleteOrganization && permissions.deleteOrganization) ||
		    (viewOrganization && permissions.viewOrganization) ||
		    (addOrganizationapikey && permissions.addOrganizationapikey) ||
		    (changeOrganizationapikey && permissions.changeOrganizationapikey) ||
		    (deleteOrganizationapikey && permissions.deleteOrganizationapikey) ||
		    (viewOrganizationapikey && permissions.viewOrganizationapikey) ||
		    (addEmaildevice && permissions.addEmaildevice) ||
		    (changeEmaildevice && permissions.changeEmaildevice) ||
		    (changeOwnEmaildevices && permissions.changeOwnEmaildevices) ||
		    (deleteEmaildevice && permissions.deleteEmaildevice) ||
		    (deleteOwnEmaildevices && permissions.deleteOwnEmaildevices) ||
		    (viewEmaildevice && permissions.viewEmaildevice) ||
		    (viewOwnEmaildevices && permissions.viewOwnEmaildevices) ||
		    (addStaticdevice && permissions.addStaticdevice) ||
		    (changeOwnStaticdevices && permissions.changeOwnStaticdevices) ||
		    (changeStaticdevice && permissions.changeStaticdevice) ||
		    (deleteOwnStaticdevices && permissions.deleteOwnStaticdevices) ||
		    (deleteStaticdevice && permissions.deleteStaticdevice) ||
		    (viewOwnStaticdevices && permissions.viewOwnStaticdevices) ||
		    (viewStaticdevice && permissions.viewStaticdevice) ||
		    (addStatictoken && permissions.addStatictoken) ||
		    (changeStatictoken && permissions.changeStatictoken) ||
		    (deleteStatictoken && permissions.deleteStatictoken) ||
		    (viewStatictoken && permissions.viewStatictoken) ||
		    (addTotpdevice && permissions.addTotpdevice) ||
		    (changeOwnTotpdevices && permissions.changeOwnTotpdevices) ||
		    (changeTotpdevice && permissions.changeTotpdevice) ||
		    (deleteOwnTotpdevices && permissions.deleteOwnTotpdevices) ||
		    (deleteTotpdevice && permissions.deleteTotpdevice) ||
		    (viewOwnTotpdevices && permissions.viewOwnTotpdevices) ||
		    (viewTotpdevice && permissions.viewTotpdevice) ||
		    (addLeague && permissions.addLeague) ||
		    (changeLeague && permissions.changeLeague) ||
		    (deleteLeague && permissions.deleteLeague) ||
		    (viewLeague && permissions.viewLeague) ||
		    (addPlayer && permissions.addPlayer) ||
		    (changePlayer && permissions.changePlayer) ||
		    (deletePlayer && permissions.deletePlayer) ||
		    (viewPlayer && permissions.viewPlayer) ||
		    (addPlayerstatus && permissions.addPlayerstatus) ||
		    (changePlayerstatus && permissions.changePlayerstatus) ||
		    (deletePlayerstatus && permissions.deletePlayerstatus) ||
		    (viewPlayerstatus && permissions.viewPlayerstatus) ||
		    (addTeam && permissions.addTeam) ||
		    (changeTeam && permissions.changeTeam) ||
		    (deleteTeam && permissions.deleteTeam) ||
		    (viewTeam && permissions.viewTeam) ||
		    (addBlacklistedtoken && permissions.addBlacklistedtoken) ||
		    (changeBlacklistedtoken && permissions.changeBlacklistedtoken) ||
		    (deleteBlacklistedtoken && permissions.deleteBlacklistedtoken) ||
		    (viewBlacklistedtoken && permissions.viewBlacklistedtoken) ||
		    (addOutstandingtoken && permissions.addOutstandingtoken) ||
		    (changeOutstandingtoken && permissions.changeOutstandingtoken) ||
		    (deleteOutstandingtoken && permissions.deleteOutstandingtoken) ||
		    (viewOutstandingtoken && permissions.viewOutstandingtoken)) {
			return true;
		}
		return false;
	}
}
