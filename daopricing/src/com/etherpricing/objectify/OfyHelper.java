package com.etherpricing.objectify;

import com.googlecode.objectify.ObjectifyService;

import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;

/**
 * OfyHelper, a ServletContextListener, is setup in web.xml to run before a JSP is run.  This is
 * required to let JSP's access Ofy.
 **/
public class OfyHelper implements ServletContextListener {
  public void contextInitialized(ServletContextEvent event) {
    // This will be invoked as part of a warmup request, or the first user request if no warmup
    // request.
    ObjectifyService.register(com.etherpricing.model.Minute.class);
    ObjectifyService.register(com.etherpricing.model.TenMinute.class);
    ObjectifyService.register(com.etherpricing.model.Hour.class);
    ObjectifyService.register(com.etherpricing.model.Day.class);
  }

  public void contextDestroyed(ServletContextEvent event) {
    // App Engine does not currently invoke this method.
  }
}