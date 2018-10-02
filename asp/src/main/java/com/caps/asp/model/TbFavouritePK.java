package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbFavouritePK implements Serializable {
    private int userId;
    private int postId;

    @Column(name = "user_id", nullable = false)
    @Id
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Column(name = "post_id", nullable = false)
    @Id
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbFavouritePK that = (TbFavouritePK) o;
        return userId == that.userId &&
                postId == that.postId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(userId, postId);
    }
}
