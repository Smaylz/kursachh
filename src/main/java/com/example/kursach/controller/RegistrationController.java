package com.example.kursach.controller;

import com.example.kursach.domain.User;
import com.example.kursach.service.UserSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class RegistrationController {
    @Autowired
    private UserSevice userSevice;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@RequestParam("password2") String passwordConfirm, @Valid User user, BindingResult bindingResult, Model model) {
        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);
        if(isConfirmEmpty){
            model.addAttribute("password2Error","Password confirmation cannot be emdois");

        }
        if( user.getPassword().equals("")){

            model.addAttribute("passwordError","Password cannot be empty");
        }
        if(!user.getPassword().equals("") && !user.getPassword().equals(passwordConfirm)){

            model.addAttribute("passwordError", "Passwords are different!");
            return "registration";
        }

        if(isConfirmEmpty || bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errors);
            return "registration";
        }
        if (!userSevice.addUser(user)) {
            model.addAttribute("usernameError", "User exists!");
            return "registration";
        }
        return "redirect:/loginpage";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code){
        boolean isActivated = userSevice.activateUser(code);
        if(isActivated){
            model.addAttribute("message","User successfully activated");
        }else{
            model.addAttribute("message","Activation vode is not found");
        }
        return "loginpage";
    }
}