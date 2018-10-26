package com.example.kursach.controller;

import com.example.kursach.domain.*;
import com.example.kursach.repos.CommentRepo;
import com.example.kursach.repos.LikeRepo;
import com.example.kursach.repos.MessageRepo;
import com.example.kursach.repos.RangRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class MessagesController {
@Autowired
private MessageRepo messageRepo;
@Autowired
private CommentRepo commentRepo;
@Autowired
private RangRepo rangRepo;
@Autowired
private LikeRepo likeRepo;
@Value("${upload.path}")
private String uploadPath;

    @PostMapping("main/delete")
    public String messageDelete(@RequestParam("messageId") Message message,
                                RedirectAttributes redirectAttributes,
                                @RequestHeader(required = false) String referer) {
        Iterable<Comment> comments = commentRepo.findAll();
        for (Comment com :comments) {
            if (com.getMes_id() == message.getId()) {
                Iterable<LikeComment> likes = likeRepo.findAll();
                for (LikeComment like : likes) {
                    if (like.getComment_id() == com.getId()) {
                        likeRepo.delete(like);
                    }
                }
                commentRepo.delete(com);
            }
        }
        Iterable<RangMessage> rangMessages = rangRepo.findAll();
        for (RangMessage rang: rangMessages) {
            if(rang.getMessage_id() == message.getId()){
                rangRepo.delete(rang);
            }
        }
        messageRepo.delete(message);

        return "redirect:" + ControllerUtils.path(redirectAttributes,referer);
    }
    @GetMapping("user/profile/{user}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(value = "sort",defaultValue = "") String numberSort,
            @RequestParam(required = false) Message message
    ){
        Page<Message> page;
        Pageable pageable;
        switch(numberSort) {
            case "text.asc": {
                pageable = new PageRequest(0, 10, Sort.Direction.ASC, "text");
                break;
            }
            case "text.desc": {
                pageable = new PageRequest(0, 10, Sort.Direction.DESC, "text");
                break;
            }
            case "tag.asc": {
                pageable = new PageRequest(0, 10, Sort.Direction.ASC, "tag");
                break;
            }
            case "tag.desc": {
                pageable = new PageRequest(0, 10, Sort.Direction.DESC, "tag");
                break;
            }
            case "rang.asc": {
                pageable = new PageRequest(0, 10, Sort.Direction.ASC, "rang");
                break;
            }
            default: {
                pageable = new PageRequest(0, 10, Sort.Direction.DESC, "rang");
                break;
            }
        }
        page = messageRepo.findByAuthor(user,pageable);
        model.addAttribute("page", page);
        model.addAttribute("url", "");
        model.addAttribute("message",message);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        Iterable<Comment> comments = commentRepo.findAll();

        model.addAttribute("comments", comments);

        Iterable<LikeComment> likeComments = likeRepo.findAll();
        model.addAttribute("likeComments",likeComments);
        return "profile";
    }

    @PostMapping("user/profile/{user}")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("name") String name,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            RedirectAttributes redirectAttributes,
            @RequestHeader(required = false) String referer
    ){
        if(message.getAuthor().equals(currentUser) || currentUser.isAdmin()){
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
        return "redirect:" + ControllerUtils.path(redirectAttributes,referer);
    }

    @PostMapping("main/rang")
    public String updateRang(@AuthenticationPrincipal User user,
                             @RequestParam("messageId") Message message,
                             @RequestParam("rang") int noteNew,
                             RangMessage rangMessage,
                             RedirectAttributes redirectAttributes,
                             @RequestHeader(required = false) String referer){

        message=rangAdd(message,user,rangMessage,noteNew);

        messageRepo.save(message);
        return "redirect:" + ControllerUtils.path(redirectAttributes,referer);
    }

    private Message rangAdd(Message message,User user,RangMessage rangMessage,int noteNew){
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

        return message;
    }

    private void saveFile(@Valid Message message, @RequestParam("file") MultipartFile file)throws IOException {
        if(file != null && !file.getOriginalFilename().isEmpty()){
            File uploadDir = new File(uploadPath);

            if(!uploadDir.exists()){
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File("C:" + uploadPath + "/" + resultFileName));
            message.setFilename(resultFileName);
        }
    }
    @PostMapping("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @Valid Message message,
            BindingResult bindingResult,
            Model model,
            @RequestParam("file") MultipartFile file,
            RedirectAttributes redirectAttributes,
            @RequestHeader(required = false) String referer
    ) throws IOException {
        message.setAuthor(user);

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", message);
        } else {
            saveFile(message, file);
            model.addAttribute("message", null);
            messageRepo.save(message);
        }
        Iterable<Message> messages = messageRepo.findAll();
        model.addAttribute("messages", messages);
        Iterable<Comment> comments = commentRepo.findAll();
        model.addAttribute("comments", comments);

        return "redirect:" + ControllerUtils.path(redirectAttributes,referer);
    }
}

