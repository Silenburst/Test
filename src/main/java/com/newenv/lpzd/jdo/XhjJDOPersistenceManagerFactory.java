package com.newenv.lpzd.jdo;

import org.datanucleus.PropertyNames;
import org.datanucleus.api.jdo.JDOPersistenceManagerFactory;

public class XhjJDOPersistenceManagerFactory extends
		JDOPersistenceManagerFactory {

	public void setQueryJdoqlAllowAll (boolean flag){
        assertConfigurable();
        getConfiguration().setProperty(PropertyNames.PROPERTY_QUERY_JDOQL_ALLOWALL, flag ? Boolean.TRUE : Boolean.FALSE);
    }
	
	public void setAutoCreateSchema (boolean flag){
        assertConfigurable();
        getConfiguration().setProperty(PropertyNames.PROPERTY_AUTOCREATE_SCHEMA, flag ? Boolean.TRUE : Boolean.FALSE);
    }
	
	public void setValidateSchema (boolean flag){
        assertConfigurable();
        getConfiguration().setProperty(PropertyNames.PROPERTY_VALIDATE_SCHEMA, flag ? Boolean.TRUE : Boolean.FALSE);
    }
	
	public void setValidateTables (boolean flag){
        assertConfigurable();
        getConfiguration().setProperty(PropertyNames.PROPERTY_VALIDATE_TABLES, flag ? Boolean.TRUE : Boolean.FALSE);
    }
	
	public void setValidateColumns (boolean flag){
        assertConfigurable();
        getConfiguration().setProperty(PropertyNames.PROPERTY_VALIDATE_COLUMNS, flag ? Boolean.TRUE : Boolean.FALSE);
    }
	
	public void setValidateConstraints (boolean flag){
        assertConfigurable();
        getConfiguration().setProperty(PropertyNames.PROPERTY_VALIDATE_CONSTRAINTS, flag ? Boolean.TRUE : Boolean.FALSE);
    }
	
	public void setInitializeColumnInfo (String v){
        assertConfigurable();
        getConfiguration().setProperty("datanucleus.rdbms.initializeColumnInfo", v);
    }
	
	public void setConnectionPoolingType (String v){
        assertConfigurable();
        getConfiguration().setProperty(PropertyNames.PROPERTY_CONNECTION_POOLINGTYPE, v);
    }
	
}
