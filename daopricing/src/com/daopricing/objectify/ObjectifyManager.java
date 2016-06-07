package com.daopricing.objectify;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.daopricing.model.TokenCreationData;

public class ObjectifyManager {

	// remember to add to ofyhelper
	
	public static void save(TokenCreationData tokenCreationData) {
		ofy().save().entity(tokenCreationData).now();
	}
}
