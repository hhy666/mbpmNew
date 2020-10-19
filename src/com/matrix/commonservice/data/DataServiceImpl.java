package com.matrix.commonservice.data;

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.app.MAppContext;
import com.matrix.app.api.Page;
import com.matrix.commonservice.extra.table.MatrixEntitySqlUtil;
import com.matrix.dasservice.DASAgent;
import com.matrix.dasservice.DASException;
import com.matrix.dasservice.DASHelper;
import com.matrix.dasservice.DASService;
import com.matrix.form.api.MFormContext;
import com.matrix.form.designer.action.ActionConstants;
import com.matrix.form.model.FormContainer;
import com.matrix.form.model.config.FormContentHelper;
import com.matrix.form.model.form.FormModel;
import com.matrix.form.model.form.FormVariable;
import com.matrix.form.util.DataObjectHelper;
import commonj.sdo.DataObject;
import org.apache.poi.hssf.record.formula.functions.T;
import org.hibernate.SQLQuery;
import org.hibernate.engine.SessionFactoryImplementor;

import java.io.Serializable;
import java.util.*;

/**
 * 数据访问实现
 *
 * @author msg
 * 日期:2008-11-07
 */

@SuppressWarnings("unchecked")
public class DataServiceImpl implements DataService {

    private DASService getDASService(DataObject obj) {
        String formType = MFormContext.getFormProperties().getType();
        if (!"platform".equalsIgnoreCase(formType)) { //如果不是在平台中,直接用表单服务
            return getDASService();
        }
        String entityname = DASHelper.getEntityName(obj);
        return getDASServiceByEntityName2(entityname);
    }

    private DASService getDASService(String hql) {
        String formType = MFormContext.getFormProperties().getType();
        if (!"platform".equalsIgnoreCase(formType)) { //如果不是在平台中,直接用表单服务
            return getDASService();
        }
        String entityname = DASHelper.getEntityName(hql);
        return getDASServiceByEntityName2(entityname);
    }

    private DASService getDASServiceByEntityName(String entityName) {
        String formType = MFormContext.getFormProperties().getType();
        if (!"platform".equalsIgnoreCase(formType)) { //如果不是在平台中,直接用表单服务
            return getDASService();
        }

        boolean isFormEntity = true;
        if (!(MFormContext.getFormProperties().getEntityAndDSNameMap().containsKey(entityName)))
            isFormEntity = false;
        DASService service = null;
        if (isFormEntity)
            service = DASAgent.getFormDASService();
        else
            service = DASAgent.getDASService();
        return service;
    }

    //内部调用,已经判断过是否为平台类型了
    private DASService getDASServiceByEntityName2(String entityName) {

        boolean isFormEntity = true;
        if (!(MFormContext.getFormProperties().getEntityAndDSNameMap().containsKey(entityName)))
            isFormEntity = false;
        DASService service = null;
        if (isFormEntity)
            service = DASAgent.getFormDASService();
        else
            service = DASAgent.getDASService();
        return service;
    }

    private DASService getDASService() {
        DASService service = DASAgent.getFormDASService();
        return service;
    }


    /**
     * 保存
     *
     * @param o --
     *          对象
     */
    @MMethod("保存")
    @MParam(name = "任意类型的对象", type = "Object")
    public void save(Object o) {
        getDASService((DataObject) o).save(o);
    }

    /**
     * 批量保存
     */
    @MMethod("批量保存")
    @MParam(name = "list类型的dataObject", type = "List")
    public void saveBatch(List list) {
        if (list == null || list.size() == 0)
            return;

        getDASService((DataObject) list.get(0)).saveBatch(list);
    }

    /**
     * 更新
     */
    @MMethod("更新")
    @MParam(name = "任意类型的对象", type = "Object")
    public void update(Object o) {
        getDASService((DataObject) o).update(o);
    }

    /**
     * 保存或更新
     */
    @MMethod("保存或更新")
    @MParam(name = "任意对象", type = "Object")
    public void saveOrUpdate(Object o) {
        getDASService((DataObject) o).saveOrUpdate(o);
    }

    /**
     * 批量保存或更新
     */
    @MMethod("批量保存或更新")
    @MParam(name = "DataObject对象列表", type = "List")
    public void saveOrUpdateBatch(List list) {
        if (list == null || list.size() == 0)
            return;

        DASService service = getDASService((DataObject) list.get(0));
        for (Iterator it = list.iterator(); it.hasNext(); ) {
            Object o = it.next();
            service.saveOrUpdate(o);
        }
    }

    /**
     * 批量更新对象
     */
    @MMethod("批量更新对象")
    @MParam(name = "DataObject对象列表", type = "List")
    public void updateBatch(List list) {
        if (list == null || list.size() == 0)
            return;

        getDASService((DataObject) list.get(0)).updateBatch(list);
    }

    /**
     * 删除对象
     */
    @MMethod("删除对象")
    @MParam(name = "任意类型对象", type = "Object")
    public void delete(Object o) {
        if (o == null)
            return;

        getDASService((DataObject) o).delete(o);
    }

    /**
     * 批量删除对象
     */
    @MMethod("批量删除对象")
    @MParam(name = "DataObject对象列表", type = "List")
    public void deleteBatch(List list) {
        if (list == null || list.size() == 0)
            return;

        DASService service = getDASService((DataObject) list.get(0));
        for (Iterator it = list.iterator(); it.hasNext(); ) {
            Object o = it.next();
            try {
                service.delete(o);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 以startIndex为开始索引查询maxResults个对象
     */
    @MMethod("以startIndex为开始索引查询maxResults个对象")
    @MParam(name = "查询脚本,查询参数值列表,开始行数,每页行数", type = "String,Object,int,int")
    @MReturn(name = "结果对象列表", type = "List")
    public List queryList2(String hql, Object params, int startIndex, int maxResults) {
        hql = FormContentHelper.convertExpression(hql);
        return getDASService(hql).executeQuery(hql, params, startIndex, maxResults);
    }

    /**
     * 执行sql查询对象
     */
    @MMethod("执行sql查询对象")
    @MParam(name = "sql查询语句,参数数组,数据源名称", type = "String,Object,String")
    @MReturn(name = "结果对象列表", type = "List")
    public List querySqlList(String sql, Object params, String dataSourceName) {
        sql = FormContentHelper.convertExpression(sql);
        return getDASService().querySQLList(sql, (Object[]) params, dataSourceName);
    }

    /**
     * 查询分析功能的结果
     */
    @MMethod("查询分析功能的结果")
    @MParam(name = "hql查询语句,参数数组", type = "String,Object")
    @MReturn(name = "结果值", type = "Object")
    public Object queryValue(String hql, Object params) {
        hql = FormContentHelper.convertExpression(hql);
        return getDASService(hql).queryValue(hql, params);
    }


    @MMethod("查询sql的结果")
    @MParam(name = "sql查询语句,参数数组", type = "String,Object")
    @MReturn(name = "结果值", type = "Object")
    public Object querySqlValue(String sql, Object params, String sourceName) {
        sql = FormContentHelper.convertExpression(sql);
        return getDASService().querySQLValue(sql, (Object[]) params, sourceName);
    }

    /**
     * 执行刷新
     */
    @MMethod("执行hql修改")
    @MParam(name = "修改语句,查询参数", type = "String,Object")
    @MReturn(name = "返回更新对象的个数", type = "int")
    public int executeUpdate(String hql, Object params) {
        hql = FormContentHelper.convertExpression(hql);
        int count = getDASService(hql).executeUpdate(hql, params);
        return count;
    }

    @MMethod("执行sql")
    @MParam(name = "sql语句,参数,数据源名称", type = "String,Object,String")
    public void executeSql(String sql, Object params, String dataSourceName) {
        sql = FormContentHelper.convertExpression(sql);
        getDASService().executeSQL(sql, (Object[]) params, dataSourceName);
    }

    @MMethod("执行hql")
    @MParam(name = "执行hql语句,参数数组", type = "String,Object")
    @MReturn(name = "返回删除对象的个数", type = "int")
    public int executeDelete(String hql, Object params) {
        hql = FormContentHelper.convertExpression(hql);
        int count = getDASService(hql).executeDelete(hql, params);
        return count;
    }

    /**
     * 从session中删除一个对象
     */
    @MMethod("从session中删除一个对象")
    @MParam(name = "任意类型对象", type = "Object")
    public void detach(Object o) {
        getDASService((DataObject) o).detach(o);
    }

    /**
     * 提交session
     */
    @MMethod("提交session")
    @MParam(name = "实例对应的类路径名称", type = "String")
    public void flush(String entityname) {
        getDASServiceByEntityName(entityname).flush(entityname);
    }

    /**
     * 刷新对象
     */
    @MMethod("刷新对象")
    @MParam(name = "已有的持久化对象", type = "Object")
    @MReturn(name = "DataObject类型的一个对象", type = "Object")
    public Object refresh(Object oldData) {
        getDASService((DataObject) oldData).refresh(oldData);
        return oldData;
    }

    /**
     * 加载一个对象
     *
     * @param entityname(实体全路径名称)
     * @param id(主键)
     * @return resultEntity(加载对象)
     */
    @MMethod("加载一个对象")
    @MParam(name = "实例对应的类路径名称,实例在数据库中的标识", type = "String,Object")
    @MReturn(name = "DataObject类型的一个对象", type = "DataObject")
    public DataObject load(String entityname, Object id) {
        if (entityname == null || entityname.trim().length() == 0) {
            throw new DASException("invalide entityname, can not be null");
        }
        return (DataObject) getDASServiceByEntityName(entityname).load((Serializable) id, entityname);
    }

    /**
     * 批量级联删除
     *
     * @param list(删除对象)
     */
    @MMethod("批量级联删除")
    @MParam(name = "list类型的DataObject", type = "List")
    public void deleteCascadeBatch(List list) {
        if (list == null || list.size() == 0)
            return;

        DASService service = getDASService((DataObject) list.get(0));
        for (Iterator it = list.iterator(); it.hasNext(); ) {
            Object o = it.next();
            service.refresh(o);
            service.delete(o);
        }
    }

    /**
     * 合并更新
     *
     * @param o(合并对象)
     */
    @MMethod("合并更新")
    @MParam(name = "处于脱管状态的任意对象", type = "Object")
    public void merge(Object o) {

        getDASService((DataObject) o).merge(o);
    }

    /**
     * 查询唯一的对象
     *
     * @param hql(查询脚本)
     * @param params(查询对象)
     * @return resultData(查询结果)
     */
    @MMethod("查询唯一的对象")
    @MParam(name = "字符串类型的hibernate查询语句,参数", type = "String,Object")
    @MReturn(name = "结果对象", type = "Object")
    public Object queryObject(String hql, Object params) {
        hql = FormContentHelper.convertExpression(hql);
        return getDASService(hql).queryObject(hql, params);
    }

    /**
     * 修改数据表格
     *
     * @param saveOrUpdateObs(添加或修改对象列表)
     * @param deleteObs(删除对象列表)
     */
    @MMethod("修改数据列表")
    @MParam(name = "新增和修改列表,删除列表", type = "List,List")
    public void updateDataList(List saveOrUpdateObs, List deleteObs) {
        saveOrUpdateBatch(saveOrUpdateObs);
        deleteBatch(deleteObs);
    }

    /**
     * @param hql(字符串类型的hibernate查询语句,String)
     * @param params(DataObject类型的对象列表,集合)
     * @return resultData(list类型的DataObject, 集合)
     */
    @MMethod("查询对象集合")
    @MParam(name = "字符串类型的hibernate查询语句,DataObject类型的对象列表", type = "String,Object")
    @MReturn(name = "list类型的DataObject", type = "List")
    public List queryList(String hql, Object params) {
        hql = FormContentHelper.convertExpression(hql);
        List data = getDASService(hql).executeQuery(hql, params);
        return data;
    }

    @MMethod("执行分页查询")
    @MParam(name = "字符串类型的hibernate查询语句,查询参数绑定到运行时实参,指定输出结果在整个结果集中的起始索引,指定输出结果的最大个数", type = "String,Object,int,int")
    @MReturn(name = "结果Page", type = "Page")
    public Page queryPage(String hql, Object params, int startIndex, int maxResults) {
        hql = FormContentHelper.convertExpression(hql);

        return getDASService(hql).executeQueryPage(hql, params, startIndex, maxResults);
    }

    /**
     * 执行设置开始索引和最大条数的sql查询
     *
     * @param sql
     * @param params
     * @param startIndex
     * @param maxResults
     * @param sourceName
     * @return List
     */
    @Override
    @MMethod("执行设置开始索引和最大条数的sql查询")
    @MParam(name = "字符串类型的sql查询语句,查询参数绑定到运行时实参,指定输出结果在整个结果集中的起始索引,指定输出结果的最大个数", type = "String,Object,int,int,String")
    @MReturn(name = "结果List", type = "List")
    public List querySQLPart(String sql, Object[] params, int startIndex, int maxResults, String sourceName) {
        sql = FormContentHelper.convertExpression(sql);
        return getDASService().querySQLPart(sql, (Object[]) params, startIndex, maxResults, sourceName);
    }


    /**
     * 查询扩展表DataObject
     *
     * @param entityName 实体路径
     * @param table      表名
     * @param id         业务主键
     * @return
     */
    private DataObject queryExtraObjData(String entityName, String table, Object id, int status,int isDelete) {
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        DataObject dataObject = DataObjectHelper.getDataObjectOfEntity(entityName);
        String sql = MatrixEntitySqlUtil.getInstance(factory).generateSelectString(dataObject, table, new String[]{MatrixEntitySqlUtil.BUSINESS_PK_CODE,MatrixEntitySqlUtil.COL_STATUS_CODE,MatrixEntitySqlUtil.COL_IS_DELETE_CODE});
        Object obj = getDASService().querySQLValue(sql, new Object[]{id, status,isDelete}, "");
        if (obj != null) {
            Object[] arrs = (Object[]) obj;
            int index = 0;
            for (Object o : arrs) {
                MatrixEntitySqlUtil.getInstance(factory).setValue(dataObject, index++, o);
            }
            return dataObject;
        }
        return null;
    }

    /**
     * 查询扩展表子表List
     *
     * @param entityName 实体路径
     * @param table      表名
     * @param id         业务主键
     * @return
     */
    private List queryExtraListData(String entityName, String table, Object id) {
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        DataObject dataObject = DataObjectHelper.getDataObjectOfEntity(entityName);
        String sql = MatrixEntitySqlUtil.getInstance(factory).generateSelectString(dataObject, table, new String[]{MatrixEntitySqlUtil.FK_CODE});
        List dataList = new ArrayList();
        List result = getDASService().querySQLList(sql, new Object[]{id}, "");
        if (result != null) {
            for (Iterator iter3 = result.iterator(); iter3.hasNext(); ) {
                DataObject entity = DataObjectHelper.getDataObjectOfEntity(entityName);
                if (entity == null) {
                    DASException dase = new DASException("invalid entityName:" + entityName);
                    throw dase;
                }
                Object[] arrs = (Object[]) iter3.next();
                if (arrs != null && arrs.length > 0) {
                    int index = 0;
                    for (Object o : arrs) {
                        MatrixEntitySqlUtil.getInstance(factory).setValue(entity, index++, o);
                    }
                }
                dataList.add(entity);
            }
        }
        return dataList;
    }

    /**
     * 保存扩展表对象
     *
     * @param o
     * @param table
     */
    private void saveExtraObjData(DataObject o, String table) {
        o.set(MatrixEntitySqlUtil.COL_CREATE_DATE_ID, new Date());
        o.set(MatrixEntitySqlUtil.COL_CREATE_USER_ID, MFormContext.getUser().getUserId());
        o.set(MatrixEntitySqlUtil.COL_ORG_ID, MAppContext.getOrgId());
        o.set(MatrixEntitySqlUtil.COL_LOCK_USER_ID, MFormContext.getUser().getUserId());
        o.set(MatrixEntitySqlUtil.COL_IS_DELETE_ID, 0);
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        String insertSql = MatrixEntitySqlUtil.getInstance(factory).generateInsertString(o, table);
        SQLQuery sqlQuery = creatQuery(insertSql);
        sqlQuery = MatrixEntitySqlUtil.getParam(o, sqlQuery);
        executeSQL(sqlQuery);
    }

    private void updateExtraObjData(DataObject o, String table) {
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        if (o == null) {
            return;
        }
        String updateSql = MatrixEntitySqlUtil.getInstance(factory).generateUpdateString(o, table);
        try {
            SQLQuery sqlQuery = creatQuery(updateSql);
            sqlQuery = MatrixEntitySqlUtil.getUpdateParam(o, sqlQuery);
            executeSQL(sqlQuery);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void initExData(String id, int status) {
        // TODO Auto-generated method stub
        FormModel model = (FormModel) MFormContext.getRequestAttribute(ActionConstants.FORM_MODEL);
        List<FormVariable> formVariables = model.getFormVariables();
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(null).isExFormVariable(formVariable)) {
                String type = formVariable.getType();
                String formVariableId = formVariable.getId();
                String entityName = formVariable.getEntity();
                String table = FormContainer.getInstance().getTableName(formVariable);
                if (MatrixEntitySqlUtil.getInstance(null).isExtraMainTable(formVariable)) {
                    DataObject dataObject = queryExtraObjData(entityName, table, id, status,0);
                    if (dataObject != null)
                        MFormContext.setRequestAttribute(formVariableId, dataObject);
                } else {
                    List list = queryExtraListData(entityName, table, id);
                    if (list != null)
                        MFormContext.setRequestAttribute(formVariableId, list);
                }
            }
        }
    }

    /**
     * 保存表单下所有扩展表数据
     *
     * @param id
     */
    @Override
    public void saveExData(String id, int status) {
        // TODO Auto-generated method stub
        FormModel model = (FormModel) MFormContext.getRequestAttribute(ActionConstants.FORM_MODEL);
        List<FormVariable> formVariables = model.getFormVariables();
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        String deleteSql = "";
        String pk = UUID.randomUUID().toString();
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(factory).isExFormVariable(formVariable)) {
                String type = formVariable.getType();
                String table = FormContainer.getInstance().getTableName(formVariable);
                if (MatrixEntitySqlUtil.getInstance(factory).isExtraMainTable(formVariable)) {
                    DataObject dataObject = (DataObject) MFormContext.getRequestAttribute(formVariable.getId());
                    if (dataObject != null) {
                        dataObject.setString(MatrixEntitySqlUtil.PK_ID, pk);
                        dataObject.setString(MatrixEntitySqlUtil.BUSINESS_PK_ID, id);
                        dataObject.setInt(MatrixEntitySqlUtil.COL_STATUS_ID, status);
                        saveExtraObjData(dataObject, table);
                    }
//						saveOrUpdateExtraObj(dataObject,table, id);
                } else {
                    deleteSql = MatrixEntitySqlUtil.getInstance(factory).generateDeleteString(table, MatrixEntitySqlUtil.FK_CODE + " = ?");
                    getDASService().executeSQL(deleteSql.toString(), new Object[]{pk}, "");
                    List list = (List) MFormContext.getRequestAttribute(formVariable.getId());
                    if (list != null) {
                        saveExtraBatch(list, table, pk);
                    }
                }
            }
        }
    }

    @Override
    public void updateExData(String id, int status) {
        // TODO Auto-generated method stub
        FormModel model = (FormModel) MFormContext.getRequestAttribute(ActionConstants.FORM_MODEL);
        List<FormVariable> formVariables = model.getFormVariables();
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        String deleteSql = "";
        String pk = "";
        int index = 1;
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(factory).isExFormVariable(formVariable)) {
                if (MatrixEntitySqlUtil.getInstance(factory).isExtraMainTable(formVariable)) {
                    String table = FormContainer.getInstance().getTableName(formVariable);
                    DataObject dataObject = (DataObject) MFormContext.getRequestAttribute(formVariable.getId());
                    if (dataObject != null) {
                        dataObject.setString(MatrixEntitySqlUtil.BUSINESS_PK_ID, id);
                        dataObject.setInt(MatrixEntitySqlUtil.COL_STATUS_ID, status);
                        updateExtraObjData(dataObject, table);
                        if (index == 1) {
                            pk = (String) querySqlValue("SELECT " + MatrixEntitySqlUtil.PK_CODE + " FROM " + table + " WHERE " + MatrixEntitySqlUtil.BUSINESS_PK_CODE + "=? AND " + MatrixEntitySqlUtil.COL_STATUS_CODE + "=?", new Object[]{id, status},"");
                        }
                        index++;
                    }
                }
            }
        }
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(factory).isExFormVariable(formVariable)) {
                if (!MatrixEntitySqlUtil.getInstance(factory).isExtraMainTable(formVariable)) {
                    String table = FormContainer.getInstance().getTableName(formVariable);
                    deleteSql = MatrixEntitySqlUtil.getInstance(factory).generateDeleteString(table, MatrixEntitySqlUtil.FK_CODE + " = ?");
                    getDASService().executeSQL(deleteSql.toString(), new Object[]{id}, "");
                    List list = (List) MFormContext.getRequestAttribute(formVariable.getId());
                    if (list != null) {
                        saveExtraBatch(list, table, pk);
                    }
                }
            }
        }
    }


    @Override
    public void saveOrUpdateExData(String id, int status) {
        // TODO Auto-generated method stub
        String hasExData = MFormContext.getParameter("matrix_has_ex_data");
        if ("true".equals(hasExData)) {
            updateExData(id, status);
        } else {
            saveExData(id, status);
        }
    }

    private void saveExtraBatch(List list, String table, String id) {
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        int size = list.size();
        //分隔后的集合个数
        int count = (size + 30 - 1) / 30;
        for (int i = 0; i < count; i++) {
            List<T> subList = list.subList(i * 30, ((i + 1) * 30 > size ? size : 30 * (i + 1)));
            executeExtraBatch( factory, subList,  table,  id);
        }
    }
    private void executeExtraBatch(SessionFactoryImplementor factory,List list, String table, String id) {
        for (Object obj:list) {
            DataObject dataObject= (DataObject) obj;
            String insertSql = MatrixEntitySqlUtil.getInstance(factory).generateInsertString(dataObject, table);
            SQLQuery sqlQuery = creatQuery(insertSql);
            sqlQuery = MatrixEntitySqlUtil.getParam(dataObject, sqlQuery);
            executeSQL(sqlQuery);
        }
    }

    /**
     * 删除扩展数据
     * @param formId 关联表单编码
     * @param id  业务主键
     * @param status 状态
     */
    @Override
    public void deleteExData(String formId, String id,int status) {
        if (formId == null || formId.trim().length() == 0)
            return;

        // TODO Auto-generated method stub
        FormModel model = null;
        try {
            model = MFormContext.getExecutionService().getLatestFormModelByFDID(formId);
            //(FormModel)MFormContext.getRequestAttribute(ActionConstants.FORM_MODEL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (model == null)
            return;
        int index = 1;
        String pk = "";
        List<FormVariable> formVariables = model.getFormVariables();
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        //删除主表
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(factory).isExFormVariable(formVariable)) {
                StringBuffer deleteSql = new StringBuffer(200);
                if (MatrixEntitySqlUtil.getInstance(factory).isExtraMainTable(formVariable)) {
                    String table = FormContainer.getInstance().getTableName(formVariable);
                    if (index == 1) {
                        pk = (String) querySqlValue(new StringBuffer("SELECT " ).append(MatrixEntitySqlUtil.PK_CODE ).append(" FROM ").append(table ).append(" where ").append(MatrixEntitySqlUtil.BUSINESS_PK_CODE).append("=? AND ").append(MatrixEntitySqlUtil.COL_STATUS_CODE ).append("=?").toString(), new Object[]{id, status}, "");
                    }
                    index++;
                    deleteExtMainTable(id, status, table);
                }

            }
        }
        //删除子表
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(factory).isExFormVariable(formVariable)) {
                StringBuffer deleteSql = new StringBuffer(200);
                if (!MatrixEntitySqlUtil.getInstance(factory).isExtraMainTable(formVariable)) {
                    String table = FormContainer.getInstance().getTableName(formVariable);
                    deleteSql.append("UPDATE ").append(table).append(" SET ").append(MatrixEntitySqlUtil.COL_IS_DELETE_CODE).append("=?").append(" WHERE ").append(MatrixEntitySqlUtil.FK_CODE).append("=?");
                    getDASService().executeSQL(deleteSql.toString(), new Object[]{pk}, "");
                }
            }
        }
    }

    private void deleteExtMainTable(String id, int status, String table) {
        StringBuffer deleteSql = new StringBuffer(100);
        //逻辑删除
        deleteSql.append("UPDATE  ").append(table).append(" SET ").append(MatrixEntitySqlUtil.COL_IS_DELETE_CODE).append("=1").append(" ").append(" WHERE ").append(MatrixEntitySqlUtil.BUSINESS_PK_CODE).append("=?").append(" AND ").append(MatrixEntitySqlUtil.COL_STATUS_CODE).append("=?");
        getDASService().executeSQL(deleteSql.toString(), new Object[]{id, status}, "");
    }

    @Override
    public void deleteExDatas(String formId, Set ids,int status) {
        // TODO Auto-generated method stub
        if (formId == null || formId.trim().length() == 0)
            return;

        StringBuffer paramsBuffer = new StringBuffer("(");
        StringBuffer strBuffer = new StringBuffer("");
        for (Object obj : ids) {
            if (strBuffer.length() > 0) {
                strBuffer.append(",");
            }
            strBuffer.append("?");
        }
        paramsBuffer.append(strBuffer).append(")");

        FormModel model = null;
        try {
            model = MFormContext.getExecutionService().getLatestFormModelByFDID(formId);
            //(FormModel)MFormContext.getRequestAttribute(ActionConstants.FORM_MODEL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (model == null)
            return;
        int index=1;
        List<String> pks=null;
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        List<FormVariable> formVariables = model.getFormVariables();
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(factory).isExFormVariable(formVariable)) {
                String type = formVariable.getType();
                String table = FormContainer.getInstance().getTableName(formVariable);
                StringBuffer deleteSql = new StringBuffer(200);
                if (MatrixEntitySqlUtil.getInstance(factory).isExtraMainTable(formVariable)) {
                    if (index == 1) {
                        pks = (List<String>) querySqlList("SELECT " + MatrixEntitySqlUtil.PK_CODE + " FROM " + table + " WHERE " +MatrixEntitySqlUtil.BUSINESS_PK_CODE+" in "+paramsBuffer+" AND " + MatrixEntitySqlUtil.COL_STATUS_CODE + "='"+status+"'",ids.toArray(), "");
                    }
                    index++;
                    //逻辑删除
                    deleteSql.append("UPDATE  ").append(table).append(" SET ").append(MatrixEntitySqlUtil.COL_IS_DELETE_CODE).append("=1").append(" WHERE ").append(MatrixEntitySqlUtil.BUSINESS_PK_CODE).append(" in ").append(paramsBuffer).append(" AND ").append(MatrixEntitySqlUtil.COL_STATUS_CODE).append("='").append(status).append("'");
                    getDASService().executeSQL(deleteSql.toString(), ids.toArray(), "");
                } else {
                    if(pks!=null&&pks.size()>0) {
                        StringBuffer pksBuffer = new StringBuffer("(");
                        StringBuffer placeBuffer = new StringBuffer("");
                        for (Object obj : pks) {
                            if (placeBuffer.length() > 0) {
                                placeBuffer.append(",");
                            }
                            placeBuffer.append("?");
                        }
                        pksBuffer.append(strBuffer).append(")");
                        deleteSql.append("UPDATE  ").append(table).append(" SET ").append(MatrixEntitySqlUtil.COL_IS_DELETE_CODE).append("=1").append(" WHERE ").append(MatrixEntitySqlUtil.FK_CODE).append(" in ").append(pksBuffer).append(" AND ").append(MatrixEntitySqlUtil.COL_STATUS_CODE).append("='").append(status).append("'");
                        getDASService().executeSQL(deleteSql.toString(), pks.toArray(), "");
                    }
                }
            }
        }
    }
    /**
     * 复制正式数据为运行数据
     * @param formId
     * @param id
     */
    @Override
    public void copyExDatas(String formId,String id) {
        FormModel model = null;
        try {
            //model = MFormContext.getExecutionService().getFormModelByFTID(formId);
            model =(FormModel)MFormContext.getRequestAttribute(ActionConstants.FORM_MODEL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (model == null)
            return;
        int index=1;
        List<String> pks=null;
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        List<FormVariable> formVariables = model.getFormVariables();
        String pk = UUID.randomUUID().toString();
        String oldPk = "";
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(factory).isExFormVariable(formVariable)) {
                String type = formVariable.getType();
                String table = FormContainer.getInstance().getTableName(formVariable);
                if (MatrixEntitySqlUtil.getInstance(factory).isExtraMainTable(formVariable)) {
                    DataObject dataObject = (DataObject) queryExtraObjData( formVariable.getEntity(),  table, id,MatrixEntitySqlUtil.EX_STATUS_1,0);
                    if (dataObject != null) {
                        oldPk=dataObject.getString(MatrixEntitySqlUtil.PK_ID);
                        dataObject.setString(MatrixEntitySqlUtil.PK_ID, pk);
                        dataObject.setString(MatrixEntitySqlUtil.BUSINESS_PK_ID, id);
                        dataObject.setInt(MatrixEntitySqlUtil.COL_STATUS_ID, MatrixEntitySqlUtil.EX_STATUS_0);
                        saveExtraObjData(dataObject, table);
                    }
                } else {
                    List list  = (List) queryExtraListData(formVariable.getEntity(), table, oldPk);
                    if (list != null) {
                        saveExtraBatch(list, table, pk);
                    }
                }
            }
        }
    }

    /**
     * 扩展表数据运行转正式
     * @param formId
     * @param id
     */
    @Override
    public void changeExDataRun2Official(String formId, String id) {
        FormModel model = null;
        try {
            //model = MFormContext.getExecutionService().getFormModelByFTID(formId);
            model =(FormModel)MFormContext.getRequestAttribute(ActionConstants.FORM_MODEL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (model == null)
            return;
        int index=1;
        List<String> pks=null;
        SessionFactoryImplementor factory = (SessionFactoryImplementor) getDASService().getSessionFactory("");
        List<FormVariable> formVariables = model.getFormVariables();
        String pk = UUID.randomUUID().toString();
        String oldPk = "";
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(factory).isExFormVariable(formVariable)) {
                String type = formVariable.getType();
                String table = FormContainer.getInstance().getTableName(formVariable);
                if (MatrixEntitySqlUtil.getInstance(factory).isExtraMainTable(formVariable)) {
                    moveExtData2History( formVariable.getEntity(), table, id);
                    StringBuffer deleteSql = new StringBuffer(100);
                    //逻辑删除
                    deleteSql.append("DELETE FROM  ").append(table).append(" WHERE ").append(MatrixEntitySqlUtil.BUSINESS_PK_CODE).append("=?").append(" AND ").append(MatrixEntitySqlUtil.COL_STATUS_CODE).append("=?").append(" AND ").append(MatrixEntitySqlUtil.COL_IS_DELETE_CODE).append("=0");
                    getDASService().executeSQL(deleteSql.toString(), new Object[]{id, MatrixEntitySqlUtil.EX_STATUS_1}, "");
                    updateExtDataStatus(table,id,MatrixEntitySqlUtil.EX_STATUS_0,MatrixEntitySqlUtil.EX_STATUS_1);
                } else {
                   //待处理（有没有历史表）
                }
            }
        }
    }

    /**
     * 修改扩展表数据状态
     * @param table
     * @param id
     * @param oldStatus
     * @param newStatus
     */
    private void updateExtDataStatus(String table,String id,int oldStatus,int newStatus){
        StringBuilder updateSql = new StringBuilder(100);
        updateSql.append("UPDATE ").append(table).append(" SET ").append(MatrixEntitySqlUtil.COL_STATUS_CODE).append("=?").append(" WHERE ").append(MatrixEntitySqlUtil.BUSINESS_PK_CODE).append("=?").append(" AND ").append(MatrixEntitySqlUtil.COL_STATUS_CODE).append("=?").append(" AND ").append(MatrixEntitySqlUtil.COL_IS_DELETE_CODE).append("=0");
        getDASService().executeSQL(updateSql.toString(), new Object[]{newStatus,id,oldStatus}, "");
    }

    /**
     * 迁移历史数据
     * @param entity
     * @param table
     * @param id
     */
    private void moveExtData2History(String entity,String table,String id){
        DataObject dataObject = (DataObject) queryExtraObjData( entity,  table, id,MatrixEntitySqlUtil.EX_STATUS_1,0);
        if(dataObject!=null){
            DataObject objHistory= DataObjectHelper.getDataObjectOfEntity(new StringBuffer(entity).toString());
            String insertSql = MatrixEntitySqlUtil.getInstance(null).generateInsertString(objHistory, new StringBuffer(table).append("_his").toString());
            objHistory=MatrixEntitySqlUtil.mergeHistoryObj(objHistory, dataObject);
            SQLQuery sqlQuery = creatQuery(insertSql);
            sqlQuery = MatrixEntitySqlUtil.getParam(objHistory, sqlQuery);
            executeSQL(sqlQuery);
        }
    }

    public void executeSQL(SQLQuery sqlQuery) throws DASException {
        try {
            sqlQuery.executeUpdate();
        } catch (Exception var5) {
            var5.printStackTrace();
            DASException dase = new DASException("execute sql error", DASException.ExecuteSQLQueryErr, var5);
            throw dase;
        }
    }

    public SQLQuery creatQuery(String sql) throws DASException {
        try {
            SQLQuery sqlQuery = getDASService().getSession().createSQLQuery(sql);
            return sqlQuery;
        } catch (Exception var5) {
            throw var5;
        }
    }

    /**
     * 查询扩展历史表 DataObject
     * @param id         业务主键
     * @param status      状态
     * @return
     */
    @Override
    public List loadHistoryExData(String id, int status) {
        // TODO Auto-generated method stub
        List list=new ArrayList();
        FormModel model = (FormModel) MFormContext.getRequestAttribute(ActionConstants.FORM_MODEL);
        List<FormVariable> formVariables = model.getFormVariables();
        for (FormVariable formVariable : formVariables) {
            if (MatrixEntitySqlUtil.getInstance(null).isExFormVariable(formVariable)) {
                String type = formVariable.getType();
                String formVariableId = formVariable.getId();
                String entityName = formVariable.getEntity();
                String table = FormContainer.getInstance().getTableName(formVariable);
                if (MatrixEntitySqlUtil.getInstance(null).isExtraMainTable(formVariable)) {
                    DataObject dataObject = queryExtraObjData(entityName+"His", table+"_HIS", id, status,0);
                    if (dataObject != null)
                        list.add(dataObject);
                }
            }
        }
        return list;
    }
}