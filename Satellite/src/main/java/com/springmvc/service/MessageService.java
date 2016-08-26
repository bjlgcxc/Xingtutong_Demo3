package com.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springmvc.dao.MessageDao;
import com.springmvc.entity.Message;

@Service
public class MessageService {

	@Autowired
	MessageDao messageDao;
	
	public void saveMessage(Message message){
		messageDao.save(message);
	}
	
	public void saveMessage(List<Message> messageList){
		for(Message message:messageList){
			messageDao.save(message);
		}
	}
	
	public List<Message> getAllMessage(){
		return messageDao.findAll();
	}
	
}
