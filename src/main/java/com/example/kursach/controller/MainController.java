package com.example.kursach.controller;

import com.example.kursach.domain.Comment;
import com.example.kursach.domain.LikeComment;
import com.example.kursach.domain.Message;
import com.example.kursach.repos.CommentRepo;
import com.example.kursach.repos.LikeRepo;
import com.example.kursach.repos.MessageRepo;
import com.example.kursach.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;
    @Autowired
    private CommentRepo commentRepo;
    @Autowired
    private LikeRepo likeRepo;
    @Autowired
    private MessageService messageService;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "redirect:/main";
    }

    @GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter,
                       Model model,
                       @PageableDefault(sort = {"rang"}, direction = Sort.Direction.DESC) Pageable pageable) {
        Page<Message> page = messageService.MessageList(pageable,filter);


        model.addAttribute("page", page);
        model.addAttribute("url", "/main");
        model.addAttribute("filter", filter);
        Iterable<Comment> comments = commentRepo.findByOrderByLikecDesc();

        model.addAttribute("comments", comments);

        Iterable<LikeComment> likeComments = likeRepo.findAll();

        model.addAttribute("likeComments", likeComments);
        return "main";
    }


}
