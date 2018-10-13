package com.example.kursach.domain;

import javax.persistence.*;

@Entity
public class LikeComment {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;
    private Long comment_id;


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    public LikeComment() {
    }

    public LikeComment(User user) {
        this.author = user;
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
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getComment_id() {
        return comment_id;
    }

    public void setComment_id(Long comment_id) {
        this.comment_id = comment_id;
    }
}
