package com.daopricing.model;

import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

import flexjson.JSONSerializer;

/**
 * per minute token creation data
 * @author sol wu
 *
 */
@Entity
public class TokenCreationData {
	
	@Id public Long id;
    @Index public Date timeslot;
    public long timestamp;
    public double balance;
    public double balanceUsd;
    public double price;
    public double tokens;
    public double units;
    
    public String toString() {
    	return new JSONSerializer().exclude("*.class").serialize(this);
    }
    
    /**
     * calculate the exact minute with 0 milliseconds
     * @param timeMillis - java epoch time in milliseconds
     */
    public static Long calcWholeTime(long timeMillis) {
    	// divide by the number of milliseconds in 1 minute.  remove reminder.
    	final long MILLIS_IN_MINUTE = 1000 * 60; 
    	return timeMillis - (timeMillis % MILLIS_IN_MINUTE);
    }

}
