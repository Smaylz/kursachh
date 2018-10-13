package com.example.kursach.controller;

import com.example.kursach.domain.Comment;
import com.example.kursach.domain.LikeComment;
import com.example.kursach.domain.User;
import com.example.kursach.repos.CommentRepo;
import com.example.kursach.repos.LikeRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class CommentController {
    @Autowired
    private CommentRepo commentRepo;

    @Autowired
    private LikeRepo likeRepo;

    @PostMapping("main/comment/delete")
    public String commentDelete(@RequestParam("commentId") Comment comment) {

        commentRepo.delete(comment);

        return "redirect:/main";
    }

    @PostMapping("add")
    public String add(
            @AuthenticationPrincipal User user,
            @Valid Comment comment,
            BindingResult bindingResult,
            Model model
    ) {
        comment.setAuthor(user);
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("comment", comment);
        } else {
            model.addAttribute("comment", null);
            commentRepo.save(comment);
        }
        Iterable<Comment> comments = commentRepo.findAll();

        model.addAttribute("comments", comments);

        return "redirect:/main";
    }
    @PostMapping("main/comment/update")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("id")Comment comment,
            @RequestParam("text") String text
    ){
        if(comment.getAuthor().equals(currentUser)){
            if(!StringUtils.isEmpty(text)){
                comment.setText(text);
            }
            commentRepo.save(comment);
        }
        return "redirect:/main";
    }
    @PostMapping("main/like")
    public String like(@AuthenticationPrincipal User user, @RequestParam("commentId") Comment comment, LikeComment likeNew){

        int cou = 0;
        Iterable<LikeComment> likes = likeRepo.findAll();
        for (LikeComment like :likes) {
            if(like.getAuthor().getId() == user.getId() && like.getComment_id() == comment.getId()){
                comment.setLikec(comment.getLikec()-1);
                likeRepo.delete(like);
                cou=1;
                break;
            }
        }
        if(cou != 1) {
            comment.setLikec(comment.getLikec()+1);
            likeNew.setAuthor(user);
            likeNew.setComment_id(comment.getId());
            likeRepo.save(likeNew);
        }
        commentRepo.save(comment);
        return "redirect:/user/profile/"+ user.getId();
}
}
