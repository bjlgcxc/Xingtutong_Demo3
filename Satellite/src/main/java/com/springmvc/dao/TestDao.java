package com.springmvc.dao;

import java.util.Iterator;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import com.springmvc.entity.Test_;

@SuppressWarnings("unchecked")
@Repository
public class TestDao {

	@Autowired
	HibernateTemplate hibernateTemplate;
	@Autowired
	SessionFactory sessionFactory;
	
	//get
	public Test_ get(Long id){
		return hibernateTemplate.get(Test_.class, id);
	}
	
	//load?
	public Test_ load(Long id){
		return hibernateTemplate.load(Test_.class, id);
	}

	//find 
	public List<Test_> find(){
		return (List<Test_>)hibernateTemplate.find("from Test_ t where t.number>=2");
	}
	
	//iterate?
	public Iterator<Test_> iterate(){
		return (Iterator<Test_>)hibernateTemplate.iterate("from Test_ t where t.number>=2");
	} 
	
	//save
	public void save(Test_ base){
		hibernateTemplate.save(base);
	}
	
	//update
	public void update(Test_ test){
		hibernateTemplate.update(test);
	}
	
	//save or update
	public void savaOrUpdate(Test_ test){
		hibernateTemplate.saveOrUpdate(test);
	}
	
	//delete
	public void delete(Test_ test){
		hibernateTemplate.delete(test);
	}
	
	//bulkUpdate
	public void bulkUpdate(){
		hibernateTemplate.bulkUpdate("update Test_ t set t.string=? where t.number>=111", new Object[]{"a"});
		hibernateTemplate.bulkUpdate("delete Test_ where string=? and number=?",new Object[]{"a",123});
	}
	
	//sql query
	public List<Test_> sqlQuery(){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select * from t_test");
		//添加持久化对象类型
		query.addEntity(Test_.class);
		List<Test_> result = query.list();
		session.close();
		return result;
	}
	
	//sql executeUpdate(save、delete、update)
	public void slqDelete(String string,int number){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("delete from t_test where string=? and number=?");
		query.setParameter(0, string);
		query.setParameter(1, number);
		query.executeUpdate();
		//需要手动关闭session
		session.close();
	}
	
}
