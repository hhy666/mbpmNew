package com.matrix.demo;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.matrix.form.render.util.SdoJsonConverter;
import com.matrix.form.util.DataObjectHelper;

import commonj.sdo.DataObject;

/**
 * Created by Administrator on 2016/11/7.
 */
@RestController
@RequestMapping(value = "/rest", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
public class RestHelloController {

    /**
     * get method
     *
     * @param name
     * @return
     */
//    public String hello(@RequestParam("name") String name) {
    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    public String hello() {
    
//    	String name = "test";
//        System.out.println("name:" + name);
//        com.fasterxml.jackson.core.util.DefaultIndenter a;
//        return name;
    	
    	List list = new ArrayList();
    	
    	DataObject dataObj = DataObjectHelper.getDataObjectOfEntity("com.matrix.form.model.MCode");
		dataObj.setString("id", "id01");
		dataObj.setString("name", "name01");
		list.add(dataObj);
    	
    	dataObj = DataObjectHelper.getDataObjectOfEntity("com.matrix.form.model.MCode");
		dataObj.setString("id", "id01");
		dataObj.setString("name", "name01");
		list.add(dataObj);

//		SdoJsonConverter.convertDataObjectToJsonString(DataObject data)
		
		return SdoJsonConverter.convertListToJsonString((List)list);
//		return new ArrayList();
    }
    
    
    
//    @RequestMapping(value = "/hello", method = RequestMethod.GET)
//    public String hello(@RequestParam("name")  String name) {
//        System.out.println("name:" + name);
//        return name;
//    }


//    @RequestMapping(value = "/save", method = RequestMethod.POST)
//    public User save(HttpServletRequest request, @RequestBody User user) {
//        System.out.println(user.getId());
//        System.out.println(user.getName());
//        return user;
//
//    }


}