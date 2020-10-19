package com.matrix.commonservice.data;
/**
 * 数据访问
 *
 * @author msg
 * 日期:2008-11-07
 */

import com.matrix.annotation.MMethod;
import com.matrix.annotation.MParam;
import com.matrix.annotation.MReturn;
import com.matrix.app.api.Page;
import com.matrix.dasservice.DASException;
import commonj.sdo.DataObject;
import org.hibernate.SQLQuery;

import java.util.List;
import java.util.Set;

public interface DataService {
    /**
     * 保存
     * @param o --对象
     */
    @MMethod("保存")
    @MParam(name = "任意类型的对象", type = "Object")
    public void save(Object o);

    /**
     * 批量保存
     * @param d --对象
     */
    @MMethod("批量保存")
    @MParam(name = "list类型的dataObject", type = "List")
    public void saveBatch(List d);

    /**
     * 更新
     * @param o --对象
     *
     */
    @MMethod("更新")
    @MParam(name = "任意类型的对象", type = "Object")
    public void update(Object o);

    /**
     * 保存或更新
     * @param o --对象
     *
     */
    @MMethod("保存或更新")
    @MParam(name = "任意对象", type = "Object")
    public void saveOrUpdate(Object o);

    /**
     * 批量保存或更新
     * @param d --对象
     *
     */
    @MMethod("批量保存或更新")
    @MParam(name = "DataObject对象列表", type = "List")
    public void saveOrUpdateBatch(List d);

    /**
     * 批量更新对象
     * @param d --对象
     */
    @MMethod("批量更新对象")
    @MParam(name = "DataObject对象列表", type = "List")
    public void updateBatch(List d);

    /**
     * 删除对象
     * @param o -- 对象
     */
    @MMethod("删除对象")
    @MParam(name = "任意类型对象", type = "Object")
    public void delete(Object o);

    /**
     * 批量删除对象
     * @param d --对象
     */
    @MMethod("批量删除对象")
    @MParam(name = "DataObject对象列表", type = "List")
    public void deleteBatch(List d);

    @MMethod("以startIndex为开始索引查询maxResults个对象")
    @MParam(name = "查询脚本,查询参数值列表,开始行数,每页行数", type = "String,Object,int,int")
    @MReturn(name = "结果对象列表", type = "List")
    public List queryList2(String hql, Object params, int startIndex, int maxResults);

    /**
     * 执行sql查询对象
     *
     * @param sql --
     *            查询脚本
     * @param params --
     *            查询对象
     * @param dataSourceName --
     *            数据源名称
     * @return anyType -- 任意对象
     */
    @MMethod("执行sql查询对象")
    @MParam(name = "sql查询语句,参数数组,数据源名称", type = "String,Object,String")
    @MReturn(name = "结果对象列表", type = "List")
    public List querySqlList(String sql, Object params, String dataSourceName);

    /**
     * 查询分析功能的结果
     *
     * @param hql --
     *            查询脚本
     * @param params --
     *            查询对象
     * @return anySimpleType -- 任意简单类型
     */
    @MMethod("查询分析功能的结果")
    @MParam(name = "hql查询语句,参数数组", type = "String,Object")
    @MReturn(name = "结果值", type = "Object")
    public Object queryValue(String hql, Object params);

    @MMethod("执行sql值查询")
    @MParam(name = "sql查询语句,参数数组, 数据源名称", type = "String,Object,String")
    @MReturn(name = "结果值", type = "Object")
    public Object querySqlValue(String sql, Object params, String sourceName);

    /**
     * 执行修改
     *
     * @param hql --
     *            更新脚本
     * @param params --
     *            更新对象
     * @return int -- 整数
     */
    @MMethod("执行hql修改")
    @MParam(name = "修改语句,查询参数", type = "String,Object")
    @MReturn(name = "返回更新对象的个数", type = "int")
    public int executeUpdate(String hql, Object params);

    /**
     * 执行删除
     *
     * @param hql --
     *            更新脚本
     * @param params --
     *            更新对象
     * @return int -- 整数
     */
    @MMethod("执行hql修改")
    @MParam(name = "hibernate查询语句,查询参数", type = "String,Object")
    @MReturn(name = "返回删除对象的个数", type = "int")
    public int executeDelete(String hql, Object params);

    /**
     * 执行sql
     *
     * @param sql 执行sql语句
     * @param params 参数数组
     * @param sql 数据源名称
     */
    @MMethod("执行sql")
    @MParam(name = "执行sql语句,参数数组,数据源名称", type = "String,Object,String")
    public void executeSql(String sql, Object params, String dataSourceName);

    /**
     * 从session中删除一个对象
     *
     * @param o --
     *            对象
     */
    @MMethod("从session中删除一个对象")
    @MParam(name = "任意类型对象", type = "Object")
    public void detach(Object o);

    /**
     * 提交session
     *
     * @param entityname --
     *            对象名称
     */
    @MMethod("提交session")
    @MParam(name = "实例对应的类路径名称", type = "String")
    public void flush(String entityname);

    /**
     *刷新对象
     */
    @MMethod("刷新对象")
    @MParam(name = "已有的持久化对象", type = "Object")
    @MReturn(name = "DataObject类型的一个对象", type = "Object")
    public Object refresh(Object oldData);

    /**
     * 加载一个对象
     * @param entityname(实体全路径名称)
     *
     * @param id(主键)
     *
     * @return resultEntity(加载对象)
     */
    @MMethod("加载一个对象")
    @MParam(name = "实例对应的类路径名称,实例在数据库中的标识", type = "String,Object")
    @MReturn(name = "DataObject类型的一个对象", type = "DataObject")
    public DataObject load(String entityname, Object id);

    /**
     * 批量级联删除
     * @param d(删除对象)
     *
     */
    @MMethod("批量级联删除")
    @MParam(name = "list类型的DataObject", type = "List")
    public void deleteCascadeBatch(List d);

    /**
     * 合并更新
     * @param o(合并对象)
     *
     */
    @MMethod("合并更新")
    @MParam(name = "处于脱管状态的任意对象", type = "Object")
    public void merge(Object o);

    /**
     * 查询唯一的对象
     * @param hql(查询脚本)
     *
     * @param params(查询对象)
     *
     * @return resultData(查询结果)
     */
    @MMethod("查询唯一的对象")
    @MParam(name = "字符串类型的hibernate查询语句,参数", type = "String,Object")
    @MReturn(name = "结果对象", type = "Object")
    public Object queryObject(String hql, Object params);


    /**
     * 修改数据表格
     * @param saveOrUpdateObs(添加或修改对象列表)
     * @param deleteObs(删除对象列表)
     */
    @MMethod("修改数据列表")
    @MParam(name = "新增和修改列表,删除列表", type = "List,List")
    public void updateDataList(List saveOrUpdateObs, List deleteObs);


    /**
     * @param hql(字符串类型的hibernate查询语句,String)
     * @param params(DataObject类型的对象列表,集合)
     * @return resultData(list类型的DataObject, 集合)
     */
    @MMethod("查询对象集合")
    @MParam(name = "字符串类型的hibernate查询语句,DataObject类型的对象列表", type = "String,Object")
    @MReturn(name = "list类型的DataObject", type = "List")
    public List queryList(String hql, Object params);

    /**
     * @param hql(字符串类型的hibernate查询语句,String)
     * @param params(查询参数绑定到运行时实参,任意对象)
     * @param startIndex(指定输出结果在整个结果集中的起始索引,int)
     * @param maxResults(指定输出结果的最大个数,int)
     * @return resultData(List类型的DataObject, 分页对象)
     */
    @MMethod("执行分页查询")
    @MParam(name = "字符串类型的hibernate查询语句,查询参数绑定到运行时实参,指定输出结果在整个结果集中的起始索引,指定输出结果的最大个数", type = "String,Object,int,int")
    @MReturn(name = "结果Page", type = "Page")
    public Page queryPage(String hql, Object params, int startIndex, int maxResults);

    /*初始扩展数据， 系统根据表单模型中的表单变量和业务主键值自行组织扩展数据对象并放到request attribute中，用于表单渲染
     * id 业务主键值
     */
    public void initExData(String id, int status);

//	/**
//	 * 根据主键加载扩展表数据
//	 * @return
//	 */
//	public Object queryExtraObj(String entityName,String table, Object id) ;
//
//	/**
//	 * 新增扩展表数据
//     */
//	public void saveExtraObj(DataObject o,String table);
//
//	/**
//	 * 修改扩展表数据
//	 */
//	public void updateExtraObj(DataObject o,String table);
//
//	/**
//	 * 保存或更新扩展表数据
//	 */
//	public void saveOrUpdateExtraObj(DataObject o,String table,String id);

    /*添加扩展数据， 系统根据表单模型中的表单变量自行从request attribute中获取表单提交数据进行保存
     * id 业务主键值
     */
    public void saveExData(String id, int status);

    /*修改扩展数据， 系统根据表单模型中的表单变量自行从request attribute中获取表单提交数据进行保存
     * id 业务主键值
     */
    public void updateExData(String id, int status);

    @MParam(name = "关联编码", type = "String")
    public void saveOrUpdateExData(String id, int status);

    /*删除单条业务对应的扩展主表和子表数据
     * formId,定制表单编码
     * id 业务主键值
     */
    public void deleteExData(String formId, String id, int status);

    /*删除多条业务对应的扩展主表和子表数据
     * formId,定制表单编码
     * ids 业务主键值集合
     */
    public void deleteExDatas(String formId, Set ids, int status);

    /**
     * 根据外键加载扩展子表数据
     * @return
     */
//	public List queryExtraList(String entityName, String table,Object id);
//
//	public void saveExtraBatch(List list, String table, String id);

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
    @MMethod("执行设置开始索引和最大条数的sql查询")
    @MParam(name = "字符串类型的sql查询语句,查询参数绑定到运行时实参,指定输出结果在整个结果集中的起始索引,指定输出结果的最大个数", type = "String,Object,int,int,String")
    @MReturn(name = "结果List", type = "List")
    public List querySQLPart(String sql, Object[] params, int startIndex, int maxResults, String sourceName);

    /**
     * 复制正式数据为运行数据
     * @param formId
     * @param id
     */
    public void copyExDatas(String formId, String id);


    /**
     * 扩展表数据运行转正式
     * @param formId
     * @param id
     */
    public void changeExDataRun2Official(String formId, String id);

    public void executeSQL(SQLQuery sqlQuery) throws DASException;

    /**
     * 创建sqlQuery
     * @param sql
     * @return
     * @throws DASException
     */
    public SQLQuery creatQuery(String sql) throws DASException;

    /**
     * 查询扩展历史表 DataObject
     * @param id         业务主键
     * @param status      状态
     * @return List
     */
    public List loadHistoryExData(String id, int status);

}