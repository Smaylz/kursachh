package com.example.kursach.controller;

import com.example.kursach.domain.Comment;
import com.example.kursach.domain.Message;
import com.example.kursach.domain.RangMessage;
import com.example.kursach.domain.User;
import com.example.kursach.repos.CommentRepo;
import com.example.kursach.repos.MessageRepo;
import com.example.kursach.repos.RangRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessagesController {
@Autowired
private MessageRepo messageRepo;
@Autowired
private CommentRepo commentRepo;
@Autowired
private RangRepo rangRepo;

    @PostMapping("main/delete")
    public String messageDelete(@RequestParam("messageId") Message message) {
        Iterable<Comment> comments = commentRepo.findAll();
        for (Comment com :comments) {
            if(com.getMes_id() == message.getId())
                commentRepo.delete(com);
        }

        messageRepo.delete(message);

        return "redirect:/main";
    }
    @GetMapping("user/profile/{user}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Message message,
            @PageableDefault(sort = {"rang"}, direction = Sort.Direction.DESC) Pageable pageable
    ){
        Page<Message> page = messageRepo.findByAuthor(user,pageable);
        model.addAttribute("page", page);
        model.addAttribute("url", "user/profile/{user}");
        model.addAttribute("message",message);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        Iterable<Comment> comments = commentRepo.findAll();

        model.addAttribute("comments", comments);
        return "profile";
    }
    @PostMapping("user/profile/{user}")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("name") String name,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag
    ){
        if(message.getAuthor().equals(currentUser)){
            if(!StringUtils.isEmpty(name)){
                message.setName(name);
            }
            if(!StringUtils.isEmpty(text)){
                message.setText(text);
            }
            if(!StringUtils.isEmpty(tag)){
                message.setTag(tag);
            }
            messageRepo.save(message);
        }
        return "redirect:/user/profile/"+ user;
    }

    @PostMapping("main/rang")
    public String updateRang(@AuthenticationPrincipal User user,
                             @RequestParam("messageId") Message message,
                             @RequestParam("rang") int noteNew,
                             RangMessage rangMessage){

        int count = 0, sumNote = 0;
        Iterable<RangMessage> rangMessages = rangRepo.findAll();
        for (RangMessage rang :rangMessages) {
            if(rang.getAuthor().getId() == user.getId() && rang.getMessage_id() == message.getId()){
                rangRepo.delete(rang);
            }
        }

        rangMessage.setAuthor(user);
        rangMessage.setMessage_id(message.getId());
        rangMessage.setNote(noteNew);
        rangRepo.save(rangMessage);
        rangMessages = rangRepo.findAll();
        for(RangMessage rang :rangMessages){
            if(rang.getMessage_id() == message.getId()){
                count++;
                sumNote+=rang.getNote();
            }
        }

        message.setRang(sumNote/count);

        messageRepo.save(message);
        return "redirect:/user/profile/"+ user.getId();
    }
}

