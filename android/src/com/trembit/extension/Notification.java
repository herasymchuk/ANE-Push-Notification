package com.trembit.extension;


import android.graphics.Bitmap;

public class Notification {

    private int id;
    private String title;
    private String text;
    private int smallIcon;
    private Bitmap largeIcon;
    private String time;
    private Boolean withSound = false;
    private Boolean withVibration = false;
    private Boolean withLights = false;
    private String ticker = "";

    public Notification() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getSmallIcon() {
        return smallIcon;
    }

    public void setSmallIcon(int smallIcon) {
        this.smallIcon = smallIcon;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Boolean withSound() {
        return withSound;
    }

    public void setWithSound(Boolean withSound) {
        this.withSound = withSound;
    }

    public Boolean withVibration() {
        return withVibration;
    }

    public void setWithVibration(Boolean withVibration) {
        this.withVibration = withVibration;
    }

    public Boolean withLights() {
        return withLights;
    }

    public void setWithLights(Boolean withLights) {
        this.withLights = withLights;
    }

    public String getTicker() {
        return ticker;
    }

    public void setTicker(String ticker) {
        this.ticker = ticker;
    }

    public Bitmap getLargeIcon() {
        return largeIcon;
    }

    public void setLargeIcon(Bitmap largeIcon) {
        this.largeIcon = largeIcon;
    }
}
