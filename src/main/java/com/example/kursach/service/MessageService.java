package com.example.kursach.service;

import com.example.kursach.domain.Message;
import com.example.kursach.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
    @Autowired
    private MessageRepo messageRepo;

    public Page<Message> MessageList(Pageable pageable,String filter){
        if (filter != null && !filter.isEmpty()) {
            return messageRepo.findByTextLike("%" + filter + "%", pageable);
        }else{
            return messageRepo.findAll(pageable);}
    }
}
