package com.matrix.commonservice.data;

import net.sf.json.JSONObject;

import java.util.Map;

public interface MServiceItemHelperInterface {
    /**
     * 保存业务服务项数据
     *
     * @param dataJson 要操作服务项数据的json对象
     * @return
     */
    public void saveServiceItem(JSONObject dataJson, String bizId, int bizType, String orderOrWorkId, int status);

    /**
     * 修改业务服务项数据
     *
     * @param dataJson 要操作服务项数据的json对象
     */
    public void updateServiceItem(JSONObject dataJson, String bizId, int status);

    /**
     * 读取业务服务项数据
     *
     * @param bizId  业务主键
     * @param status
     * @return
     */
    public Map loadServiceItem(String bizId, int status);

    /**
     * 删除业务服务项数据
     */
    public void deleteServiceItem(String bizId, int status);

    /**
     * 复制正式数据为运行数据
     *
     * @param bizId 业务主键
     */
    public void copyServiceItem(String bizId);

    /**
     * 服务项数据运行转正式
     *
     * @param bizId 业务主键
     */
    public void changeExDataRun2Official(String bizId);

    public String getServiceItemField(String categoryId, int itemType, int version, String field);
    public String getTableName(JSONObject jsonObject);
}