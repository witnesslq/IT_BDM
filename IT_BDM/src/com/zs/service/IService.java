package com.zs.service;

import java.io.Serializable;
import java.util.List;

import com.zs.tools.Page;

public interface IService {
	
	public List find(String hql,String[] ss);
	
	//分页查询
	public List findOfFenYe(String hql,int start,int size);
	
	public Object get(Class c,Serializable id);
	
	public void save(Object obj);
	
	public void update(Object obj);
	
	public void delete(Object obj);

	
	public List query(String hql1,String ss[],String hql2,Page page,IService ser);
	
	public void timeLine(String state,String tableName,String id);

}
