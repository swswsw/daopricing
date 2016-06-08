<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="updateheader.jspf" %>
<%@ page import="java.util.*" %>
<%@ page import="com.etherpricing.net.*" %>
<%@ page import="com.etherpricing.cache.*" %>
<%@ page import="org.json.*" %>
<%
JSONObject json = RetrieveData.jsonData("https://poloniex.com/public?command=returnTicker");
final long time = System.currentTimeMillis();
final String poloniex = "Poloniex"; 
PriceCache pc = new PriceCache();
if (json != null) {
	JSONObject btcdao = json.getJSONObject("BTC_DAO");
	JSONObject ethdao = json.getJSONObject("ETH_DAO");
	
	// weird, currency pair means first currency = this much second currency.  
	// eg. eth_btc price of 0.0020 means  1 eth = 0.0020 btc
	// but poloniex seems to flip the price (flip around first and second currency)
	// we want to normalize the notation, so we will flip first and second currency.
	
	// we want quoteVolume as the unit is in eth
	PriceCache.Price btcdaoPrice = 
		new PriceCache.Price("DAO", "BTC", btcdao.getDouble("last"), btcdao.getDouble("quoteVolume"), time, poloniex);
	PriceCache.Price ethdaoPrice = 
			new PriceCache.Price("DAO", "ETH", ethdao.getDouble("last"), ethdao.getDouble("quoteVolume"), time, poloniex);
	
	pc.getPriceList().add(btcdaoPrice);
	pc.getPriceList().add(ethdaoPrice);
	
	CacheManager.save("latest_poloniex", pc);
}
%>
<%=pc%>