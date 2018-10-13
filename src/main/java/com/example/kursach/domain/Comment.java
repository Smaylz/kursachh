package com.example.kursach.domain;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
public class Comment {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;
    private Long mes_id;
    private int likec;
    @NotBlank(message = "Please fill in the text field ")
    @Length(max = 2048,message = "Message too long")
    private String text;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    public Comment() {
    }

    public Comment(String text, String tag, User user) {
        this.author = user;
        this.text = text;
    }

    public String getAuthorName() {
        return author != null ? author.getUsername() : "<none>";
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMes_id() {
        return mes_id;
    }

    public void setMes_id(Long mes_id) {
        this.mes_id = mes_id;
    }

    public int getLikec() {
        return likec;
    }

    public void setLikec(int likec) {
        this.likec = likec;
    }
}