<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="updateheader.jspf" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.daopricing.model.*" %>
<%@ page import="com.daopricing.net.*" %>
<%@ page import="com.daopricing.objectify.*" %>
<%@ page import="org.json.*" %>
<%
String daohubStats = null;
String daoStats = null;
JSONObject json = null;
try {
	daohubStats = RetrieveData.stringData("https://daohub.org/tokencreation/server/stats.js");
} catch (SocketTimeoutException ex) {
	// sometimes, timeout can occur
	throw ex;
}

final long time = System.currentTimeMillis();

if (daohubStats != null) {
	// result is javascript.
	// doing a simple parsing of javascript.
	
	// find first {
	// find last }
	// get data in the middle.
	int indexFirstStartingBracket = daohubStats.indexOf("{");
	int indexLastEndingBracket = daohubStats.lastIndexOf("}");
	if (indexFirstStartingBracket != -1 && indexLastEndingBracket != -1) {
		daoStats = daohubStats.substring(indexFirstStartingBracket, indexLastEndingBracket + 1);
		
		json = new JSONObject(daoStats);
		double balance = json.getDouble("balance");
		//double balance
		
		long wholeTime = TokenCreationData.calcWholeTime(time);

		TokenCreationData data = new TokenCreationData();
		data.id = wholeTime;
		data.timeslot = new Date(wholeTime);
		data.timestamp = time;
		data.balance = json.getDouble("balance");
		data.balanceUsd = json.getDouble("balance_usd");
		data.price = json.getDouble("price");
		data.tokens = json.getDouble("tokens");
		data.units = json.getDouble("units");
		ObjectifyManager.save(data);
	}
}


%>
<%=json.toString(2)%>