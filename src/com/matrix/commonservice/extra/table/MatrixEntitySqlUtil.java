package com.matrix.commonservice.extra.table;


import com.matrix.commonservice.extra.table.sql.Insert;
import com.matrix.commonservice.extra.table.sql.Select;
import com.matrix.commonservice.extra.table.sql.Update;
import com.matrix.form.api.MFormContext;
import com.matrix.form.model.form.FormVariable;
import com.matrix.form.util.DataObjectHelper;
import commonj.sdo.DataObject;
import commonj.sdo.Property;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.engine.SessionFactoryImplementor;
import org.hibernate.type.NullableType;
import org.hibernate.util.StringHelper;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 扩展表数据操作公共类
 * 主要功能:生成sql
 */
public class MatrixEntitySqlUtil{

    private static MatrixEntitySqlUtil instance;
    private SessionFactoryImplementor factory;
    private static final String ORACLE_DB = "Oracle";
    public final static java.lang.String BUSINESS_PK_CODE = "M_F_ID";
    public final static java.lang.String BUSINESS_PK_ID = "fId";
    public final static java.lang.String PK_CODE = "M_BIZ_ID";
    public final static java.lang.String PK_ID = "mBizId";
    public final static java.lang.String SUBPK_CODE = "M_UUID";
    public final static java.lang.String SUBPK_ID = "uuid";
    public final static java.lang.String FK_ID = "rBizId";
    public final static String FK_CODE = "R_BIZ_ID";
    public final static String TABLE_PREFIX = "MB_";
    public final static String PHASE_4 = "4";
    public final static int EX_STATUS_0 = 0;
    public final static int EX_STATUS_1 = 1;
    public final static java.lang.String COL_CREATE_USER_CODE = "M_CREATEUSER";
    public final static java.lang.String COL_CREATE_USER_ID = "createUser";
    public final static java.lang.String COL_LAST_USER_CODE = "M_LASTMODIFYUSER";
    public final static java.lang.String COL_LAST_USER_ID = "lastModifyUser";
    public final static java.lang.String COL_CREATE_DATE_CODE = "M_CREATEDATE";
    public final static java.lang.String COL_CREATE_DATE_ID = "createDate";
    public final static java.lang.String COL_LAST_DATE_CODE = "M_LASTMODIFYDATE";
    public final static java.lang.String COL_LAST_DATE_ID = "lastModifyDate";
    public final static java.lang.String COL_STATUS_CODE = "M_STATUS";
    public final static java.lang.String COL_STATUS_ID = "mStatus";
    public final static java.lang.String COL_ORG_CODE = "M_ORG_ID";
    public final static java.lang.String COL_ORG_ID = "orgId";
    public final static java.lang.String COL_ORDER_ID = "cOrder";
    public final static java.lang.String COL_LOCK_USER_CODE = "LOCK_USER";
    public final static java.lang.String COL_LOCK_USER_ID = "lockUser";
    public final static java.lang.String COL_IS_DELETE_CODE = "M_IS_DELETE";
    public final static java.lang.String COL_IS_DELETE_ID = "isDelete";
    public final static java.lang.String SERVICE_ITEM_PK = "C_ID";
    public final static java.lang.String SERVICE_ITEM_FK = "C_RBZ_ID";
    public final static java.lang.String SERVICE_ITEM_FK_ID = "rBizId";
    public final static java.lang.String SERVICE_ITEM_CATEGORY_ID = "C_CATEGORY_ID";
    public final static java.lang.String SERVICE_ITEM_CREATE_USER_CODE = "C_CREATEUSER";
    public final static java.lang.String SERVICE_ITEM_CREATE_USER_ID = "createUser";
    public final static java.lang.String SERVICE_ITEM_LAST_USER_CODE = "C_LASTMODIFYUSER";
    public final static java.lang.String SERVICE_ITEM_LAST_USER_ID = "lastModifyUser";
    public final static java.lang.String SERVICE_ITEM_CREATE_DATE_CODE = "C_CREATEDATE";
    public final static java.lang.String SERVICE_ITEM_CREATE_DATE_ID = "createDate";
    public final static java.lang.String SERVICE_ITEM_LAST_DATE_CODE = "C_LASTMODIFYDATE";
    public final static java.lang.String SERVICE_ITEM_LAST_DATE_ID = "lastModifyDate";
    public final static java.lang.String SERVICE_ITEM_DELETE_CODE = "C_IS_DELETE";
    public final static java.lang.String SERVICE_ITEM_STATUS_CODE = "C_STATUS";
    public final static java.lang.String SERVICE_ITEM_STATUS_ID = "status";
    public final static java.lang.String SERVICE_ITEM_BIZ_TYPE_CODE = "c_biz_type";
    public final static java.lang.String SERVICE_ITEM_ORDER_ID = "c_order_or_work_id";
    public final static java.lang.String SERVICE_ITEM_TYPE = "c_item_type";
    public final static java.lang.String SERVICE_ITEM_HIS_DATE = "c_his_create_date";
    public final static int SERVICE_ITEM_STATUS_0 = 0;
    public final static int SERVICE_ITEM_STATUS_1 = 1;



    protected MatrixEntitySqlUtil() {
    }

    protected MatrixEntitySqlUtil(SessionFactoryImplementor factory) {
        if(factory!=null) {
            this.factory = factory;
        }
    }

    public static MatrixEntitySqlUtil getInstance(SessionFactoryImplementor factory) {
        if (instance == null) {
            instance = new MatrixEntitySqlUtil(factory);
        }else {
            if (factory != null) {
                instance.factory = factory;
            }
        }
        return instance;
    }


    /**
     * 生成update 语句
     *
     * @param dataObject 要保存的对象
     * @param tableName  数据库表名
     * @return
     */
    public String generateUpdateString(DataObject dataObject, String tableName) {

        Update update = new Update(getFactory().getDialect()).setTableName(tableName);

        // select the correct row by either pk or rowid
        update.setPrimaryKeyColumnNames(new String[]{BUSINESS_PK_CODE,COL_STATUS_CODE,COL_IS_DELETE_CODE});
        boolean hasColumns = false;
        List<Property> properties = dataObject.getType().getProperties();
        for (Iterator iter = properties.iterator(); iter.hasNext(); ) {
            Property property = (Property) iter.next();
            if (property.getType().isDataType()) {
                // this property belongs on the table and is to be inserted
                if (PK_ID.equals(property.getName()) || COL_ORG_ID.equals(property.getName()) || COL_CREATE_USER_ID.equals(property.getName()) || COL_CREATE_DATE_ID.equals(property.getName())||COL_IS_DELETE_ID.equals(property.getName())||BUSINESS_PK_ID.equals(property.getName())) {
                    continue;
                }
                if (FK_ID.equals(property.getName())) {
                    update.addColumn(FK_CODE);
                } else if (SUBPK_ID.equals(property.getName())) {
                    update.addColumn(SUBPK_CODE);
                } else if (COL_LAST_USER_ID.equals(property.getName())) {
                    update.addColumn(COL_LAST_USER_CODE);
                } else if (COL_LAST_DATE_ID.equals(property.getName())) {
                    update.addColumn(COL_LAST_DATE_CODE);
                } else if (COL_STATUS_ID.equals(property.getName())) {
                    update.addColumn(COL_STATUS_CODE);
                } else if (COL_LOCK_USER_ID.equals(property.getName())) {
                    update.addColumn(COL_LOCK_USER_CODE);
                } else {
                    update.addColumn(property.getName());
                }
            }
        }

        return update.toStatementString();
    }

    /**
     * 生成update 语句
     *
     * @param fieldMap 要保存的对象
     * @param tableName  数据库表名
     * @return
     */
    public String generateUpdateString(LinkedHashMap<String, String> fieldMap, String tableName) {

        Update update = new Update(getFactory().getDialect()).setTableName(tableName);

        // select the correct row by either pk or rowid
        update.setPrimaryKeyColumnNames(new String[]{SERVICE_ITEM_FK,SERVICE_ITEM_STATUS_CODE});
        boolean hasColumns = false;
        update.addColumn(SERVICE_ITEM_LAST_USER_CODE);
        update.addColumn(SERVICE_ITEM_LAST_DATE_CODE);
        for (Map.Entry<String, String> entry : fieldMap.entrySet()) {
            String colName = entry.getValue();
            update.addColumn(colName);
        }
        return update.toStatementString();
    }

    /**
     * 生成insert 语句
     *
     * @param dataObject 要保存的对象
     * @param tableName  数据库表名
     * @return
     */
    public String generateInsertString(DataObject dataObject, String tableName) {

        Insert insert = new Insert(getFactory().getDialect())
                .setTableName(tableName);
        // add normal properties
        List<Property> properties = dataObject.getType().getProperties();
        for (Iterator iter = properties.iterator(); iter.hasNext(); ) {
            Property property = (Property) iter.next();
            if (property.getType().isDataType()) {
                // this property belongs on the table and is to be inserted
                if (PK_ID.equals(property.getName())) {
                    insert.addColumn(PK_CODE);
                } else if (FK_ID.equals(property.getName())) {
                    insert.addColumn(FK_CODE);
                }  else if (COL_IS_DELETE_ID.equals(property.getName())) {
                    insert.addColumn(COL_IS_DELETE_CODE);
                } else if (BUSINESS_PK_ID.equals(property.getName())) {
                    insert.addColumn(BUSINESS_PK_CODE);
                }else if (SUBPK_ID.equals(property.getName())) {
                    insert.addColumn(SUBPK_CODE);
                } else if (COL_CREATE_USER_ID.equals(property.getName())) {
                    insert.addColumn(COL_CREATE_USER_CODE);
                } else if (COL_CREATE_DATE_ID.equals(property.getName())) {
                    insert.addColumn(COL_CREATE_DATE_CODE);
                } else if (COL_LAST_USER_ID.equals(property.getName())) {
                    insert.addColumn(COL_LAST_USER_CODE);
                } else if (COL_LAST_DATE_ID.equals(property.getName())) {
                    insert.addColumn(COL_LAST_DATE_CODE);
                } else if (COL_STATUS_ID.equals(property.getName())) {
                    insert.addColumn(COL_STATUS_CODE);
                } else if (COL_ORG_ID.equals(property.getName())) {
                    insert.addColumn(COL_ORG_CODE);
                } else if (COL_LOCK_USER_ID.equals(property.getName())) {
                    insert.addColumn(COL_LOCK_USER_CODE);
                } else {
                    insert.addColumn(property.getName());
                }
            }

        }
        String result = insert.toStatementString();
        return result;
    }

    /**
     * 生成insert 语句
     *
     * @param fieldMap  要保存的表数据map
     * @param tableName 数据库表名
     * @return
     */
    public String generateInsertString(LinkedHashMap<String, String> fieldMap, String tableName) {

        Insert insert = new Insert(getFactory().getDialect())
                .setTableName(tableName);
        insert.addColumn(SERVICE_ITEM_PK);
        insert.addColumn(SERVICE_ITEM_FK);
        insert.addColumn(SERVICE_ITEM_CATEGORY_ID);
        insert.addColumn(SERVICE_ITEM_CREATE_USER_CODE);
        insert.addColumn(SERVICE_ITEM_CREATE_DATE_CODE);
        insert.addColumn(SERVICE_ITEM_DELETE_CODE);
        insert.addColumn(SERVICE_ITEM_STATUS_CODE);
        insert.addColumn(SERVICE_ITEM_ORDER_ID);
        insert.addColumn(SERVICE_ITEM_BIZ_TYPE_CODE);
        insert.addColumn(SERVICE_ITEM_TYPE);
        for (Map.Entry<String, String> entry : fieldMap.entrySet()) {
            String colName = entry.getValue();
            insert.addColumn(colName);
        }
        String result = insert.toStatementString();
        return result;
    }

    /**
     * 生成insert 语句
     *
     * @param fieldMap  要保存的表数据map
     * @param fromTable 源数据的表名
     * @param toTable 要插入的表名
     * @return
     */
    public String generateSelectIntotString(LinkedHashMap<String, String> fieldMap, String fromTable,String toTable) {
        StringBuilder tofields = new StringBuilder(20 * (9 + fieldMap.size()));
        StringBuilder frfields = new StringBuilder(20 * (9 + fieldMap.size()));
        tofields.append(SERVICE_ITEM_PK).append(",").append(SERVICE_ITEM_FK).append(",").append(SERVICE_ITEM_CATEGORY_ID)
                .append(",").append(SERVICE_ITEM_DELETE_CODE)
                .append(",").append(SERVICE_ITEM_ORDER_ID)
                .append(",").append(SERVICE_ITEM_BIZ_TYPE_CODE)
                .append(",").append(SERVICE_ITEM_TYPE);
        frfields.append("'").append(UUID.randomUUID().toString()).append("' as ").append(SERVICE_ITEM_PK).append(",").append(SERVICE_ITEM_FK).append(",").append(SERVICE_ITEM_CATEGORY_ID)
                .append(",").append(SERVICE_ITEM_DELETE_CODE)
                .append(",").append(SERVICE_ITEM_ORDER_ID)
                .append(",").append(SERVICE_ITEM_BIZ_TYPE_CODE)
                .append(",").append(SERVICE_ITEM_TYPE);
        for (Map.Entry<String, String> entry : fieldMap.entrySet()) {
            String colName = entry.getValue();
            tofields.append(",").append(colName);
            frfields.append(",").append(colName);
        }
        tofields.append(",").append(SERVICE_ITEM_CREATE_DATE_CODE)
                .append(",").append(SERVICE_ITEM_CREATE_USER_CODE)
                .append(",").append(SERVICE_ITEM_STATUS_CODE);
        String dbType = MFormContext.getFormProperties().getDbType();
        if (!fromTable.equals(toTable)) {
            frfields.append(",").append(SERVICE_ITEM_CREATE_DATE_CODE)
                    .append(",").append(SERVICE_ITEM_CREATE_USER_CODE)
                    .append(",").append(SERVICE_ITEM_STATUS_CODE);
            tofields.append(",")
                    .append(SERVICE_ITEM_HIS_DATE);
            //oracle 数据库分页特殊处理
            if (ORACLE_DB.equalsIgnoreCase(dbType)) {
                frfields.append(",").append("SYSDATE as c_his_create_date ");
            } else {
                frfields.append(",").append("NOW() as c_his_create_date ");
            }
        } else {
            //oracle 数据库分页特殊处理
            if (ORACLE_DB.equalsIgnoreCase(dbType)) {
                frfields.append(",").append("SYSDATE as").append(SERVICE_ITEM_CREATE_DATE_CODE);
            } else {
                frfields.append(",").append("NOW() as c_his_create_date ").append(SERVICE_ITEM_CREATE_DATE_CODE);
            }
            frfields.append(",'").append(MFormContext.getUser().getUserId()).append("' as ").append(SERVICE_ITEM_CREATE_USER_CODE)
                    .append(",").append(0).append(" as ").append(SERVICE_ITEM_STATUS_CODE);
        }

        StringBuilder select = new StringBuilder(20 * (9 + fieldMap.size()));
        select.append("select ").append(frfields);
        select.append(" from ").append(fromTable).append(" where ").append(SERVICE_ITEM_FK).append(" =? AND ").append(SERVICE_ITEM_STATUS_CODE).append(" =? AND ").append(SERVICE_ITEM_DELETE_CODE).append(" =?");
        StringBuilder selectInto = new StringBuilder(2 * (20 * (9 + fieldMap.size())));
        selectInto.append("Insert into ").append(toTable).append("(").append(tofields).append(")").append(" ").append(select);
        return selectInto.toString();
    }

    /**
     * 生成删除语句
     *
     * @param tableName 表名
     * @param condition 删除条件
     * @return
     */
    public String generateDeleteString(String tableName, String condition) {
        StringBuffer deleteSql = new StringBuffer("DELETE FROM ");
        deleteSql.append(tableName).append(" WHERE ");
        deleteSql.append(" ").append(condition);
        return deleteSql.toString();
    }


    public SessionFactoryImplementor getFactory() {
        return factory;
    }

    /**
     * 将正式数据合并到历史数据
     * @param hisObj
     * @param obj
     * @return
     */
    public static DataObject mergeHistoryObj(DataObject hisObj,DataObject obj) {
        List<Property> properties = hisObj.getType().getProperties();
        Object[] objects = new Object[properties.size()];
        int i = 0;
        for (Iterator iter = properties.iterator(); iter.hasNext(); ) {
            Property property = (Property) iter.next();
            if (property.getType().isDataType()) {
                if (COL_LAST_DATE_ID.equals(property.getName())) {
                    hisObj.setDate(COL_LAST_DATE_ID, new Date());
                }else {
                    hisObj.set(property.getName(), obj.get(property.getName()));
                }
            }
        }

        return hisObj;
    }
    /**
     * 获取执行sql 时要用到的参数
     *
     * @param dataObject
     * @return
     */
    public static SQLQuery getParam(DataObject dataObject, SQLQuery sqlQuery) {
        List<Property> properties = dataObject.getType().getProperties();
        Object[] objects = new Object[properties.size()];
        int i = 0;
        for (Iterator iter = properties.iterator(); iter.hasNext(); ) {
            Property property = (Property) iter.next();
            if (property.getType().isDataType()) {
                sqlQuery.setParameter(i++,dataObject.get(property.getName()),convertParamType(property));
            }
        }
        return sqlQuery;
    }

    /**
     * 获取执行sql 时要用到的参数
     *
     * @param jsonObject
     * @return
     */
    public static SQLQuery getParam(JSONObject jsonObject,SQLQuery sqlQuery,JSONObject dataJson,String bizId,int bizType,String orderOrWorkId,int status) {
        JSONArray jsonArray = jsonObject.getJSONArray("fields");
        JSONObject data = dataJson.getJSONObject("serviceItem_"+jsonObject.getInt("itemType"));
        int index = 0;
        sqlQuery.setParameter(index++,UUID.randomUUID().toString(),Hibernate.STRING);
        sqlQuery.setParameter(index++,bizId,Hibernate.STRING);
        sqlQuery.setParameter(index++,jsonObject.getString("categoryId"),Hibernate.STRING);
        sqlQuery.setParameter(index++,MFormContext.getUser().getUserId(),Hibernate.STRING);
        sqlQuery.setParameter(index++,new Date(),Hibernate.DATE);
        sqlQuery.setParameter(index++,0,Hibernate.INTEGER);
        sqlQuery.setParameter(index++,status,Hibernate.INTEGER);
        sqlQuery.setParameter(index++,orderOrWorkId,Hibernate.STRING);
        sqlQuery.setParameter(index++,bizType,Hibernate.INTEGER);
        sqlQuery.setParameter(index++,jsonObject.getInt("itemType"),Hibernate.INTEGER);
        for (int i = 0, size = jsonArray.size(); i < size; i++) {
            JSONObject fieldObj = jsonArray.getJSONObject(i);
                sqlQuery.setParameter(index++,getParamValue(data, fieldObj),convertParamType(fieldObj.getString("type")));
        }
        return sqlQuery;
    }


    /**
     * 获取执行update 时要用到的参数
     *
     * @param dataObject
     * @return
     */
    public static SQLQuery getUpdateParam(DataObject dataObject, SQLQuery sqlQuery) {
        List<Property> properties = dataObject.getType().getProperties();
        int i = 0;
        for (Iterator iter = properties.iterator(); iter.hasNext(); ) {
            Property property = (Property) iter.next();
            if (property.getType().isDataType()) {
                if (PK_ID.equals(property.getName()) || COL_ORG_ID.equals(property.getName()) || COL_CREATE_USER_ID.equals(property.getName()) || COL_CREATE_DATE_ID.equals(property.getName())||BUSINESS_PK_ID.equals(property.getName())||COL_IS_DELETE_ID.equals(property.getName())) {
                    continue;
                }
                if (COL_LAST_DATE_ID.equals(property.getName())) {
                    sqlQuery.setParameter(i++,new Date());
                } else if (COL_LAST_USER_ID.equals(property.getName())) {
                    sqlQuery.setParameter(i++,MFormContext.getUser().getUserId());
                } else if (COL_LOCK_USER_ID.equals(property.getName())) {
                    sqlQuery.setParameter(i++,MFormContext.getUser().getUserId());
                } else {
                    sqlQuery.setParameter(i++,dataObject.get(property.getName()),convertParamType(property));
                }
                System.out.println(property.getName());
            }
        }
        sqlQuery.setParameter(i++,dataObject.get(BUSINESS_PK_ID));
        sqlQuery.setParameter(i++,dataObject.get(COL_STATUS_ID));
        sqlQuery.setParameter(i++,0);
        return sqlQuery;
    }
    /**
     * 获取执行sql 时要用到的参数
     *
     * @param jsonObject
     * @return
     */
    public static SQLQuery getUpdateParam(JSONObject jsonObject,SQLQuery sqlQuery,JSONObject dataJson,String bizId,int status) {
        JSONArray jsonArray = jsonObject.getJSONArray("fields");
        JSONObject data = dataJson.getJSONObject("serviceItem_"+jsonObject.getInt("itemType"));
        int index = 0;
        sqlQuery.setParameter(index++,MFormContext.getUser().getUserId(),Hibernate.STRING);
        sqlQuery.setParameter(index++,new Date(),Hibernate.DATE);
        for (int i = 0, size = jsonArray.size(); i < size; i++) {
            JSONObject fieldObj = jsonArray.getJSONObject(i);
            sqlQuery.setParameter(index++, getParamValue(data, fieldObj), convertParamType(fieldObj.getString("type")));
        }
        sqlQuery.setParameter(index++, bizId, Hibernate.STRING);
        sqlQuery.setParameter(index++, status, Hibernate.INTEGER);
        return sqlQuery;
    }
    /**
     * 生成查询语句
     *
     * @param dataObject 查询的对象
     * @param tableName  查询的表名
     * @param keys       查询的条件
     * @return
     */
    public String generateSelectString(DataObject dataObject, String tableName, String[] keys) {
        String entityName = dataObject.getType().getName();
        Select select = new Select(this.getFactory().getDialect());
        String[] aliasedIdColumns = StringHelper.qualify(this.getRootAlias(entityName), keys);
        String selectClause = this.concretePropertySelectFragment(this.getRootAlias(entityName), dataObject);
        String fromClause = this.fromTableFragment(tableName, this.getRootAlias(entityName));
        String whereClause = StringHelper.join("=? and ", aliasedIdColumns) + "=?" + this.whereJoinFragment(this.getRootAlias(entityName), true, false);
        return select.setSelectClause(selectClause).setFromClause(fromClause).setOuterJoins("", "").setWhereClause(whereClause).toStatementString();
    }

    /**
     * 生成查询语句
     *
     * @param fieldMap   查询的字段字典
     * @param tableName  查询的表名
     * @param keys       查询的条件
     * @return
     */
    public String generateSelectString(LinkedHashMap<String, String> fieldMap, String tableName, String[] keys) {
        Select select = new Select(this.getFactory().getDialect());
        String[] aliasedIdColumns = StringHelper.qualify(this.getRootAlias(tableName), keys);
        String selectClause = this.concretePropertySelectFragment(this.getRootAlias(tableName), fieldMap);
        String fromClause = this.fromTableFragment(tableName, this.getRootAlias(tableName));
        String whereClause = StringHelper.join("=? and ", aliasedIdColumns) + "=?" + this.whereJoinFragment(this.getRootAlias(tableName), true, false);
        return select.setSelectClause(selectClause).setFromClause(fromClause).setOuterJoins("", "").setWhereClause(whereClause).toStatementString();
    }

    public String fromTableFragment(String tableName, String name) {
        return tableName + ' ' + name;
    }


    public String getRootAlias(String entityName) {
        return StringHelper.generateAlias(entityName);
    }

    protected String concretePropertySelectFragment(String alias, DataObject dataObject) {
        List<Property> properties = dataObject.getType().getProperties();
        StringBuffer strBuffer = new StringBuffer(properties.size() * 10);
        for (Iterator iter = properties.iterator(); iter.hasNext(); ) {
            Property property = (Property) iter.next();
            String field = property.getName();
            if (FK_ID.equals(property.getName())) {
                field = FK_CODE;
            } else if (PK_ID.equals(property.getName())) {
                field = PK_CODE;
            } else if (SUBPK_ID.equals(property.getName())) {
                field = SUBPK_CODE;
            } else if (BUSINESS_PK_ID.equals(property.getName())) {
                field = BUSINESS_PK_CODE;
            }else if (COL_IS_DELETE_ID.equals(property.getName())) {
                field = COL_IS_DELETE_CODE;
            }else if (COL_CREATE_USER_ID.equals(property.getName())) {
                field = COL_CREATE_USER_CODE;
            } else if (COL_CREATE_DATE_ID.equals(property.getName())) {
                field = COL_CREATE_DATE_CODE;
            } else if (COL_LAST_USER_ID.equals(property.getName())) {
                field = COL_LAST_USER_CODE;
            } else if (COL_LAST_DATE_ID.equals(property.getName())) {
                field = COL_LAST_DATE_CODE;
            } else if (COL_STATUS_ID.equals(property.getName())) {
                field = COL_STATUS_CODE;
            } else if (COL_ORG_ID.equals(property.getName())) {
                field = COL_ORG_CODE;
            } else if (COL_LOCK_USER_ID.equals(property.getName())) {
                field = COL_LOCK_USER_CODE;
            }
            if (strBuffer.length() > 0) {
                strBuffer.append(" ,");
            }
            strBuffer.append(alias).append(".").append(field);
        }
        return strBuffer.toString();
    }

    protected String concretePropertySelectFragment(String alias, LinkedHashMap<String, String> fieldMap ){
        StringBuffer strBuffer = new StringBuffer(fieldMap.size() * 10);
        for (Map.Entry<String, String> entry : fieldMap.entrySet()) {
            String colName = entry.getValue();
            if (strBuffer.length() > 0) {
                strBuffer.append(" ,");
            }
            strBuffer.append(alias).append(".").append(colName);
        }
        return strBuffer.toString();
    }

    public String whereJoinFragment(String alias, boolean innerJoin, boolean includeSubclasses) {
        return "";
    }

    /**
     * 生成批量insert语句
     *
     * @param list      批量保存的数据集合
     * @param tableName 保存数据的数据库表明
     * @return
     */
    public String generateInsertBatchString(List list, String tableName) {
        StringBuffer buf = new StringBuffer(list.size() * 15 + tableName.length() + 10);
        // add normal properties
        buf.append("insert into ").append(tableName);
        DataObject dataObject = null;
        StringBuffer param = new StringBuffer(list.size() * 15 + tableName.length() + 10);

        for (Iterator iter = list.iterator(); iter.hasNext(); ) {
            DataObject obj = (DataObject) iter.next();
            dataObject = obj;
            List<Property> props = obj.getType().getProperties();
            if (param.length() > 0) {
                param.append(",");
            }
            param.append("(");
            StringBuffer values = new StringBuffer("");
            for (Iterator iter1 = props.iterator(); iter1.hasNext(); ) {
                Property property = (Property) iter1.next();
                if (values.length() > 0) {
                    values.append(",");
                }
                values.append("?");
            }
            param.append(values);
            param.append(")");
        }
        buf.append("(");

        if (dataObject == null) {
            return null;
        }
        List<Property> properties = dataObject.getType().getProperties();
        for (Iterator iter = properties.iterator(); iter.hasNext(); ) {
            Property property = (Property) iter.next();
            if (property.getType().isDataType()) {
                // this property belongs on the table and is to be inserted
                if (property != properties.get(0)) {
                    buf.append(",");
                }
                if (PK_ID.equals(property.getName())) {
                    buf.append(PK_CODE);
                }
                else if (FK_ID.equals(property.getName())) {
                    buf.append(FK_CODE);
                } else if (SUBPK_ID.equals(property.getName())) {
                    buf.append(SUBPK_CODE);
                } else if (COL_CREATE_USER_ID.equals(property.getName())) {
                    buf.append(COL_CREATE_USER_CODE);
                } else if (COL_CREATE_DATE_ID.equals(property.getName())) {
                    buf.append(COL_CREATE_DATE_CODE);
                } else if (COL_STATUS_ID.equals(property.getName())) {
                    buf.append(COL_STATUS_CODE);
                } else if (COL_ORG_ID.equals(property.getName())) {
                    buf.append(COL_ORG_CODE);
                } else if (COL_LOCK_USER_ID.equals(property.getName())) {
                    buf.append(COL_LOCK_USER_CODE);
                } else {
                    buf.append(property.getName());
                }
            }

        }
        buf.append(")");
        buf.append(" ").append("values").append(" ").append(param);
        return buf.toString();
    }

    /**
     * 获取saveBatch 参数
     *
     * @param list 要保存的数据集合
     * @param id   子表的rBizId value
     * @return
     */
    public static SQLQuery getListParam(List list, String id,SQLQuery sqlQuery) {

        int i = 0;
        int index = 0;
        for (Iterator iter = list.iterator(); iter.hasNext(); ) {
            DataObject dataObject = (DataObject) iter.next();
            List<Property> properties = dataObject.getType().getProperties();
            for (Iterator iter1 = properties.iterator(); iter1.hasNext(); ) {
                Property property = (Property) iter1.next();
                if (property.getType().isDataType()) {
                    if (FK_ID.equals(property.getName())) {
                        sqlQuery.setParameter(i++,id);
                    } else if (PK_ID.equals(property.getName())) {
                        sqlQuery.setParameter(i++,UUID.randomUUID().toString());
                    } else if (SUBPK_ID.equals(property.getName())) {
                        sqlQuery.setParameter(i++,UUID.randomUUID().toString());
                    } else if (COL_ORDER_ID.equals(property.getName())) {
                        if (dataObject.get(property.getName()) == null) {
                            sqlQuery.setParameter(i++,index);
                        }
                    } else {
                        sqlQuery.setParameter(i++,dataObject.get(property.getName()),convertParamType(property));
                    }
                }
            }
            index += 1;
        }
        return sqlQuery;
    }

    public void setValue(DataObject dataObject, int index, Object o) {
        if (o == null) {
            return;
        }
        if (o instanceof Integer) {
            int value = ((Integer) o).intValue();
            dataObject.setInt(index, value);
        } else if (o instanceof BigInteger) {
            BigInteger bi = (BigInteger) o;
            dataObject.setBigInteger(index, bi);
        } else if (o instanceof String) {
            String s = o.toString();
            dataObject.setString(index, s);
        } else if (o instanceof Double) {
            double d = ((Double) o).doubleValue();
            dataObject.setDouble(index, d);
        } else if (o instanceof BigDecimal) {
            BigDecimal bd = ((BigDecimal) o);
            dataObject.setBigDecimal(index, bd);
        } else if (o instanceof Float) {
            float f = ((Float) o).floatValue();
            dataObject.setFloat(index, f);
        } else if (o instanceof Long) {
            long l = ((Long) o).longValue();
            dataObject.setLong(index, l);
        } else if (o instanceof Boolean) {
            boolean b = ((Boolean) o).booleanValue();
            dataObject.setBoolean(index, b);
        } else if (o instanceof Date) {
            Date d = (Date) o;
            dataObject.setDate(index, d);
        } else if (o instanceof Timestamp) {
            Timestamp t = (Timestamp) o;
            dataObject.setDate(index, t);
        }
    }

    private static Object getParamValue(JSONObject databject, JSONObject jsonObject) {
        Object val=databject.get(jsonObject.getString("id"));
        String pattern = jsonObject.getString("pattern");
        if (val == null) {
            return null;
        }
        String dataType = uiTypeToDataType(jsonObject.getString("type"));
        if ("date".equals(dataType)) {
            if (pattern == null || pattern.trim().length() == 0) {
                pattern = "yyyy-MM-dd";
            }
            Date dateStart = null;
            SimpleDateFormat formatter = new SimpleDateFormat(pattern);
            try {
               String dateStr= databject.getString(jsonObject.getString("id"));
               if(dateStr!=null&&dateStr.trim().length()>0) {
                   dateStart = formatter.parse(dateStr);
               }
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return dateStart;
        } else if ("number".equals(dataType)) {
            return BigDecimal.valueOf(databject.getDouble(jsonObject.getString("id")));
        } else {
            return val.toString();
        }
    }

    public static NullableType convertParamType(String uiType) {
        NullableType type;
        if ("date".equals(uiType)) {//日期框
            type=Hibernate.DATE;
        } else if ("time".equals(uiType)) {//时间框
            type=Hibernate.DATE;
        } else if ("number".equals(uiType)) {//数字框
            type=Hibernate.BIG_DECIMAL;
        } else {
            type=Hibernate.STRING;
        }
        return type;
    }
    public static String uiTypeToDataType(String uiType) {
        String dataType = null;
        if ("date".equals(uiType)) {//日期框
            dataType = "date";
        } else if ("time".equals(uiType)) {//时间框
            dataType = "date";
        } else if ("number".equals(uiType)) {//数字框
            dataType = "number";
        } else {
            dataType = "string";
        }
        return dataType;
    }

    public static int convertComponentType(String uiType) {
        int type;
        if ("date".equals(uiType)) {//日期框
            type=2;
        } else if ("time".equals(uiType)) {//时间框
            type=2;
        } else if ("number".equals(uiType)) {//数字框
            type=3;
        } else {
            type=1;
        }
        return type;
    }
    public static NullableType convertParamType(Property property) {
        NullableType type;
        String typeName = property.getType().getName();
        if (DataObjectHelper.isInt(typeName)) {
            type=Hibernate.INTEGER;
        } else if (DataObjectHelper.isDecimal(typeName)) {
            type=Hibernate.BIG_DECIMAL;
        } else if (DataObjectHelper.isDouble(typeName)) {
            type=Hibernate.DOUBLE;
        } else if (DataObjectHelper.isLong(typeName)) {
            type=Hibernate.LONG;
        } else if (DataObjectHelper.isBoolean(typeName)) {
            type=Hibernate.BOOLEAN;
        } else if (DataObjectHelper.isFloat(typeName)) {
            type=Hibernate.FLOAT;
        }
        //日期
        else if (DataObjectHelper.isDate(typeName)) {
            type=Hibernate.DATE;
        } else {
            type=Hibernate.STRING;
        }
        return type;
    }
    public boolean isExFormVariable(FormVariable formVariable) {
        if (MatrixEntitySqlUtil.PHASE_4.equals(formVariable.getPhase())) {
            return true;
        }
        return false;
    }

    public boolean isExtraMainTable(FormVariable formVariable) {
        String type = formVariable.getType();
        if ("DataObject".equals(type)) {
            return true;
        }
        return false;
    }

}