package com.caps.asp.model.firebase;

public class NotificationModel {

    private String name;
    private String value;

    public NotificationModel(String name, String value) {
        this.name = name;
        this.value = value;
    }

    public NotificationModel() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
