package com.matrix.commonservice.data;

import com.matrix.commonservice.extra.table.MatrixEntitySqlUtil;
import com.matrix.dasservice.DASAgent;
import com.matrix.form.api.MFormContext;
import com.matrix.form.engine.datamapping.DynamicDataListHelper;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.hibernate.SQLQuery;
import org.hibernate.engine.SessionFactoryImplementor;

import java.util.*;

public class MServiceItemHelperImpl implements MServiceItemHelperInterface {
    private DataService dataService = MFormContext.getService("DataService");
    private final static String DATA_STRUCT_ID = "mDataStruct";
    private final static String SERVICE_ITEM_1 = "serviceItem_1";
    private final static String SERVICE_ITEM_2 = "serviceItem_2";
    private final static String SERVICE_ITEM_3 = "serviceItem_3";


    @Override
    public void saveServiceItem(JSONObject dataJson, String bizId, int bizType, String orderOrWorkId, int status) {
        JSONObject structObj = DynamicDataListHelper.getDynamicJsonObject();
        if (structObj == null) {
            return;
        }
        SessionFactoryImplementor factory = (SessionFactoryImplementor) DASAgent.getFormDASService().getSessionFactory("");
        for (Object key : structObj.keySet()) {
            String keyStr = (String) key;
            if (!keyStr.startsWith("serviceItem")) {
                continue;
            }
            JSONObject jsonObject = structObj.getJSONObject(keyStr);
            if (jsonObject != null) {
                LinkedHashMap<String, String> fieldMap = getFieldMapping(jsonObject);
                String insertSql = MatrixEntitySqlUtil.getInstance(factory).generateInsertString(fieldMap, getTableName(jsonObject));
                SQLQuery sqlQuery = dataService.creatQuery(insertSql);
                sqlQuery = MatrixEntitySqlUtil.getParam(jsonObject, sqlQuery, dataJson, bizId, bizType, orderOrWorkId, status);
                dataService.executeSQL(sqlQuery);
            }
        }
    }

    @Override
    public void updateServiceItem(JSONObject dataJson, String bizId, int status) {
        JSONObject structObj = DynamicDataListHelper.getDynamicJsonObject();
        if (structObj == null) {
            return;
        }
        SessionFactoryImplementor factory = (SessionFactoryImplementor) DASAgent.getFormDASService().getSessionFactory("");
        for (Object key : structObj.keySet()) {
            String keyStr = (String) key;
            if (!keyStr.startsWith("serviceItem")) {
                continue;
            }
            JSONObject jsonObject = structObj.getJSONObject(keyStr);
            LinkedHashMap<String, String> fieldMap = getFieldMapping(jsonObject);
            if (jsonObject != null) {
                String updateSql = MatrixEntitySqlUtil.getInstance(factory).generateUpdateString(fieldMap, getTableName(jsonObject));
                SQLQuery sqlQuery = dataService.creatQuery(updateSql);
                sqlQuery = MatrixEntitySqlUtil.getUpdateParam(jsonObject, sqlQuery, dataJson, bizId, status);
                dataService.executeSQL(sqlQuery);
            }
        }
    }

    @Override
    public Map loadServiceItem(String bizId, int status) {
        Map data = new HashMap<String, Object>();
        JSONObject structObj = DynamicDataListHelper.getDynamicJsonObject();
        if (structObj == null) {
            return data;
        }
        SessionFactoryImplementor factory = (SessionFactoryImplementor) DASAgent.getFormDASService().getSessionFactory("");
        for (Object key : structObj.keySet()) {
            String keyStr = (String) key;
            if (!keyStr.startsWith("serviceItem")) {
                continue;
            }
            JSONObject jsonObject = structObj.getJSONObject(keyStr);
            LinkedHashMap<String, String> fieldMap = (LinkedHashMap<String, String>) getQueryFieldMapping(jsonObject).get("fieldMap");
            if(fieldMap==null||fieldMap.size()==0){
                return data;
            }
            String selectSql = MatrixEntitySqlUtil.getInstance(factory).generateSelectString(fieldMap, getTableName(jsonObject), new String[]{MatrixEntitySqlUtil.SERVICE_ITEM_FK, MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_CODE, MatrixEntitySqlUtil.SERVICE_ITEM_DELETE_CODE});
            Object dataObj = dataService.querySqlValue(selectSql, new Object[]{bizId, status, 0}, null);
            if (dataObj != null) {
                Object[] arr = (Object[]) dataObj;
                int index = 0;
                for (Map.Entry<String, String> entry : fieldMap.entrySet()) {
                    String fieldId = entry.getKey();
                    data.put(fieldId, arr[index++]);
                }
            }
        }
        return data;
    }

    @Override
    public void deleteServiceItem(String bizId, int status) {
        String deleteSql = "";
        SessionFactoryImplementor factory = (SessionFactoryImplementor) DASAgent.getFormDASService().getSessionFactory("");
        JSONObject structObj = DynamicDataListHelper.getDynamicJsonObject();
        if (structObj == null) {
            return;
        }
        if (structObj.containsKey(SERVICE_ITEM_1)) {
            delServiceItem(bizId, status, getTableName(structObj));
        } else if (structObj.containsKey(SERVICE_ITEM_2)) {
            delServiceItem(bizId, status, getTableName(structObj));
        } else if (structObj.containsKey(SERVICE_ITEM_3)) {
            delServiceItem(bizId, status, getTableName(structObj));
        }
    }

    private synchronized LinkedHashMap<String, String> getFieldMapping(JSONObject jsonObject) {
        JSONArray jsonArray = jsonObject.getJSONArray("fields");
        int num = jsonArray.size();
        HashMap<String, String> strMap = new HashMap<String, String>(25);
        HashMap<String, String> numMap = new HashMap<String, String>(15);
        HashMap<String, String> dateMap = new HashMap<String, String>(10);
        // LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
        Map dataMap = getQueryFieldMapping(jsonObject);
        LinkedHashMap<String, String> map = (LinkedHashMap<String, String>) dataMap.get("fieldMap");
        if (map != null && map.size() > 0) {
            return map;
        }
        int strIndex = (int) dataMap.get("strIndex");
        int numIndex = (int) dataMap.get("strIndex");
        int dateIndex = (int) dataMap.get("strIndex");

        for (int i = 0; i < num; i++) {
            StringBuilder insertSql = new StringBuilder("INSERT INTO t_service_item_mapping (c_id, c_category_id, c_version, c_item_type,c_type, c_createdate,  c_createuser, c_name, c_field) VALUES (? ,?, ?, ?, ?, ?, ?, ?, ?)");
            JSONObject fieldObj = jsonArray.getJSONObject(i);
            Object[] params = new Object[9];
            int index = 0;
            int type = MatrixEntitySqlUtil.convertComponentType(fieldObj.getString("type"));
            params[index++] = UUID.randomUUID().toString();
            params[index++] = jsonObject.getString("categoryId");
            params[index++] = jsonObject.getInt("version");
            params[index++] = jsonObject.getInt("itemType");
            params[index++] = type;
            params[index++] = new Date();
            params[index++] = MFormContext.getUser().getUserId();
            params[index++] = fieldObj.getString("id");
            if (strMap.containsKey(fieldObj.getString("id"))) {
                map.put(fieldObj.getString("id"), strMap.get(fieldObj.getString("id")));
                params[index++] = strMap.get(fieldObj.getString("id"));
            } else if (numMap.containsKey(fieldObj.getString("id"))) {
                map.put(fieldObj.getString("id"), numMap.get(fieldObj.getString("id")));
                params[index++] = numMap.get(fieldObj.getString("id"));
            } else if (dateMap.containsKey(fieldObj.getString("id"))) {
                map.put(fieldObj.getString("id"), dateMap.get(fieldObj.getString("id")));
                params[index++] = dateMap.get(fieldObj.getString("id"));
            } else {
                StringBuffer fieldId = null;
                switch (type) {
                    case 1:
                        //字符串
                        fieldId = new StringBuffer("c_str");
                        map.put(fieldObj.getString("id"), fieldId.append("_").append(++strIndex).toString());
                        params[index++] = fieldId.toString();
                        break;
                    case 2:
                        fieldId = new StringBuffer("c_date");
                        map.put(fieldObj.getString("id"), fieldId.append("_").append(++dateIndex).toString());
                        params[index++] = fieldId.toString();
                        break;
                    case 3:
                        fieldId = new StringBuffer("c_num");
                        map.put(fieldObj.getString("id"), fieldId.append("_").append(++numIndex).toString());
                        params[index++] = fieldId.toString();
                        break;
                    default:
                        fieldId = new StringBuffer("c_str");
                        map.put(fieldObj.getString("id"), fieldId.append("_").append(++strIndex).toString());
                        params[index++] = fieldId.toString();
                }
                dataService.executeSql(insertSql.toString(), params, null);
            }

        }


        return map;
    }

    private synchronized Map<String,Object> getQueryFieldMapping(JSONObject jsonObject) {
        JSONArray jsonArray = jsonObject.getJSONArray("fields");
        int num = jsonArray.size();
        int index = 0;
        HashMap<String, Object> map = new HashMap<String, Object>(3);
        HashMap<String, String> strMap = new HashMap<String, String>(25);
        HashMap<String, String> numMap = new HashMap<String, String>(15);
        HashMap<String, String> dateMap = new HashMap<String, String>(10);
        LinkedHashMap<String, String> fieldMap = new LinkedHashMap<String, String>();
        fieldMap = getFieldMap(jsonObject);
        int strIndex = 0;
        int numIndex = 0;
        int dateIndex = 0;
        map.put("fieldMap",fieldMap);
        map.put("strIndex",strIndex);
        map.put("numIndex",numIndex);
        map.put("dateIndex",dateIndex);
        if (fieldMap != null && fieldMap.size() > 0) {
            return map;
        }
        List<String> strFiledlist = dataService.querySqlList("select c_name,c_field from t_service_item_mapping where c_category_id=? and c_item_type=? and c_type=1 group by c_field,c_name", new Object[]{jsonObject.getString("categoryId"), jsonObject.getInt("itemType")}, null);
        List<String> numFiledlist = dataService.querySqlList("select c_name,c_field from  t_service_item_mapping where c_category_id=? and c_item_type=? and c_type=2 group by c_field,c_name", new Object[]{jsonObject.getString("categoryId"), jsonObject.getInt("itemType")}, null);
        List<String> dateFiledlist = dataService.querySqlList("select c_name,c_field from  t_service_item_mapping where c_category_id=? and c_item_type=? and c_type=3 group by c_field,c_name", new Object[]{jsonObject.getString("categoryId"), jsonObject.getInt("itemType")}, null);
        if (strFiledlist != null) {
            for (Object obj :
                    strFiledlist) {
                Object[] arr = (Object[]) obj;
                strMap.put(arr[0].toString(), arr[1].toString());
            }
            strIndex = strFiledlist.size();
        }
        if (numFiledlist != null) {
            for (Object obj :
                    numFiledlist) {
                Object[] arr = (Object[]) obj;
                numMap.put(arr[0]+"", arr[1]+"");
            }
            numIndex = numFiledlist.size();
        }
        if (dateFiledlist != null) {
            for (Object obj :
                    dateFiledlist) {
                Object[] arr = (Object[]) obj;
                dateMap.put(arr[0]+"", arr[1]+"");
            }
            dateIndex = dateFiledlist.size();
        }
        map.put("field",fieldMap);
        map.put("strIndex",strIndex);
        map.put("numIndex",numIndex);
        map.put("dateIndex",dateIndex);
        return map;
    }

    /**
     * 复制正式数据为运行数据
     *
     * @param bizId 业务主键
     */
    @Override
    public void copyServiceItem(String bizId) {
        JSONObject structObj = DynamicDataListHelper.getDynamicJsonObject();
        if (structObj == null) {
            return;
        }
        SessionFactoryImplementor factory = (SessionFactoryImplementor) DASAgent.getFormDASService().getSessionFactory("");
        for (Object key : structObj.keySet()) {
            String keyStr = (String) key;
            if (!keyStr.startsWith("serviceItem")) {
                continue;
            }
            JSONObject jsonObject = structObj.getJSONObject(keyStr);
            LinkedHashMap<String, String> fieldMap = getFieldMapping(jsonObject);
            if (jsonObject != null) {
                String table = getTableName(jsonObject);
                String insertSql = MatrixEntitySqlUtil.getInstance(null).generateSelectIntotString(fieldMap, table, table);
                dataService.executeSql(insertSql.toString(), new Object[]{bizId, MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_1, 0}, "");
            }
        }
    }

    /**
     * 服务项数据运行转正式
     *
     * @param bizId
     */
    @Override
    public void changeExDataRun2Official(String bizId) {
        JSONObject structObj = DynamicDataListHelper.getDynamicJsonObject();
        if (structObj == null) {
            return;
        }
        SessionFactoryImplementor factory = (SessionFactoryImplementor) DASAgent.getFormDASService().getSessionFactory("");
        for (Object key : structObj.keySet()) {
            String keyStr = (String) key;
            if (!keyStr.startsWith("serviceItem")) {
                continue;
            }
            JSONObject jsonObject = structObj.getJSONObject(keyStr);
            LinkedHashMap<String, String> fieldMap = getFieldMapping(jsonObject);
            if (jsonObject != null) {
                String table = getTableName(jsonObject);
                moveServiceItem2History(fieldMap, table, bizId);
                //迁移数据在时物理删除
                dataService.executeSql(new StringBuffer(30).append("DELETE FROM ").append(table).append(" WHERE ").
                                append(MatrixEntitySqlUtil.SERVICE_ITEM_FK).append("=?").append(" AND ").append(MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_CODE).
                                append("=?").toString()
                        , new Object[]{bizId, MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_1}, "");
                updateServicItemStatus(table, bizId, MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_0, MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_1);
            }
        }
    }

    private void delServiceItem(String bizId, int status, String table) {
        dataService.executeSql(new StringBuffer(100).append("UPDATE ").append(table).append(" SET ").append(MatrixEntitySqlUtil.SERVICE_ITEM_DELETE_CODE).
                        append("=1").append(" WHERE ").
                        append(MatrixEntitySqlUtil.SERVICE_ITEM_FK).append("=?").append(" AND ").append(MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_CODE).
                        append("=?").toString()
                , new Object[]{bizId, status}, "");
    }

    /**
     * 修改扩展表数据状态
     *
     * @param table
     * @param bizId
     * @param oldStatus
     * @param newStatus
     */
    private void updateServicItemStatus(String table, String bizId, int oldStatus, int newStatus) {
        StringBuilder updateSql = new StringBuilder(100);
        updateSql.append("UPDATE ").append(table).append(" SET ").append(MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_CODE).append("=?").append(" WHERE ").append(MatrixEntitySqlUtil.SERVICE_ITEM_FK).append("=?").append(" AND ").append(MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_CODE).append("=? ").append(" AND ").append(MatrixEntitySqlUtil.SERVICE_ITEM_DELETE_CODE).append("=0");
        dataService.executeSql(updateSql.toString(), new Object[]{newStatus, bizId, oldStatus}, "");
    }

    /**
     * 迁移历史数据
     *
     * @param fieldMap
     * @param table
     * @param bizId
     */
    private void moveServiceItem2History(LinkedHashMap<String, String> fieldMap, String table, String bizId) {
        if (fieldMap != null) {
            String insertSql = MatrixEntitySqlUtil.getInstance(null).generateSelectIntotString(fieldMap, table, new StringBuffer(table).append("_his").toString());
            dataService.executeSql(insertSql.toString(), new Object[]{bizId, MatrixEntitySqlUtil.SERVICE_ITEM_STATUS_1, 0}, "");
        }
    }

    public String getTableName(JSONObject jsonObject) {
        int type = jsonObject.getInt("itemType");
        StringBuilder tableBuilder = new StringBuilder("t_service");
        tableBuilder.append(type).append("_item");
        return tableBuilder.toString();
    }

    private String getEntity(int itemType) {
        StringBuilder tableBuilder = new StringBuilder("t_service");
        tableBuilder.append(itemType).append("_item");
        return tableBuilder.toString();
    }
    public LinkedHashMap<String, String> getServiceItemFieldMap(){
        LinkedHashMap<String, String> fieldMap=new LinkedHashMap<>();
        JSONObject structObj = DynamicDataListHelper.getDynamicJsonObject();
        if (structObj == null) {
            return fieldMap;
        }
        SessionFactoryImplementor factory = (SessionFactoryImplementor) DASAgent.getFormDASService().getSessionFactory("");
        for (Object key : structObj.keySet()) {
            String keyStr = (String) key;
            if (!keyStr.startsWith("serviceItem")) {
                continue;
            }
            JSONObject jsonObject = structObj.getJSONObject(keyStr);
            fieldMap.putAll(getFieldMap(jsonObject));
        }
        return fieldMap;
    }
    private LinkedHashMap getFieldMap(JSONObject jsonObject){
        LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
        List<String> list = dataService.querySqlList("select c_name,c_field from t_service_item_mapping where c_category_id=? and c_item_type=? and c_version=?", new Object[]{jsonObject.getString("categoryId"), jsonObject.getInt("itemType"), jsonObject.getInt("version")}, null);
        for (Object obj :
                list) {
            Object[] arr = (Object[]) obj;
            map.put(arr[0].toString(), arr[1].toString());
        }
        return map;
    }
    public String getServiceItemField(String categoryId,int itemType,int version,String fieldId) {
        Object field = dataService.querySqlValue("select c_field from t_service_item_mapping where c_category_id=? and c_name=? and c_item_type=? and c_version=?", new Object[]{categoryId, fieldId, itemType, version}, null);
        if(field!=null) {
            return field.toString();
        }
        return  null;
    }
}
