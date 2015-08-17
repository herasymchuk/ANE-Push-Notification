package com.trembit.extension;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.media.AudioManager;
import android.media.RingtoneManager;
import android.support.v4.app.NotificationCompat;
import android.text.format.DateFormat;
import android.util.Log;
import com.distriqt.extension.util.Resources;
import com.freshplanet.nativeExtensions.Extension;
import com.freshplanet.nativeExtensions.NotificationActivity;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class NotificationManager {

    private String TAG = "NotificationManager";

    private static NotificationManager _instance;

    public static NotificationManager getInstance() {
        if (_instance == null) {
            _instance = new NotificationManager();
        }
        return _instance;
    }

    private Map<Integer, Notification> notificationMap;

    private NotificationManager() {
        initialize();
    }

    private void initialize() {
        notificationMap = new HashMap<Integer, Notification>();
    }

    public void showNotification(Context context, Intent intent) {
        Notification notification = NotificationHelper.getPushNotification(context, intent);
        String replaceType = "";
        if (intent.hasExtra("repType")) {
            replaceType = intent.getStringExtra("repType");
        }
        if (replaceType.equals("2") && notificationMap.containsKey(notification.getId())) {
            notification.setText(notificationMap.get(notification.getId()).getText().concat("/n").concat(notification.getText()));
        }

        notificationMap.put(notification.getId(), notification);

        Intent notificationIntent = new Intent(context, NotificationActivity.class);
        notificationIntent.putExtra("params", Extension.getParametersFromIntent(intent));
        notificationIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP |
                Intent.FLAG_ACTIVITY_SINGLE_TOP);
        PendingIntent contentIntent = PendingIntent.getActivity(context, 0, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT);

        NotificationCompat.Builder nb = new NotificationCompat.Builder(context)
                .setTicker(notification.getTicker())
                .setContentTitle(notification.getTitle())
                .setContentText(notification.getText())
                .setSmallIcon(notification.getSmallIcon())
                //.setLargeIcon(notification.getLargeIcon())
                .setWhen(System.currentTimeMillis())
                .setAutoCancel(true)
                .setContentIntent(contentIntent);

        if (notification.withSound()) {
            nb.setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION), AudioManager.STREAM_NOTIFICATION);
        }

        if (notification.withLights()) {
            nb.setLights(Color.BLUE, 500, 500);
        }

        if (notification.withVibration()) {
//            Vibrator v = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
//            v.vibrate(100);
            nb.setVibrate(new long[]{100, 500, 100});
        }
        //Log.d(TAG, "Version : " + android.os.Build.VERSION.SDK_INT);
        //if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.JELLY_BEAN) {
        NotificationCompat.BigTextStyle inboxStyle = new NotificationCompat.BigTextStyle();
        nb.setStyle(new NotificationCompat.BigTextStyle()
                .bigText(notification.getText()));
//        }

        android.app.NotificationManager notificationManager = (android.app.NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.notify(notification.getId(), nb.build());
    }
}

class NotificationHelper {

    private static String TAG = "NotificationHelper";

    private static int UNCHECKED_NOTIFICATION_COUNTER = 10000;

    public static Notification getPushNotification(Context context, Intent intent) {
        Notification notification = new Notification();
        notification.setId(getNotificationId(intent));
        String contentTitle = "";
        if (intent.hasExtra("contentTitle")) {
            contentTitle = intent.getStringExtra("contentTitle");
        }
        if (contentTitle.length() > 30) {
            contentTitle = contentTitle.substring(0, 30) + "...";
        }
        notification.setTitle(contentTitle);

        String contentText = "";
        if (intent.hasExtra("contentText")) {
            contentText = intent.getStringExtra("contentText");
        }
        notification.setText(contentText);

        notification.setTime(getTimeFromMessage(intent));

        if (intent.hasExtra("sound")) {
            notification.setWithSound(!intent.getStringExtra("sound").equals("none"));
        }
        if (intent.hasExtra("vibrate")) {
            notification.setWithVibration(Boolean.valueOf(intent.getStringExtra("vibrate")));
        }
        if (intent.hasExtra("light")) {
            notification.setWithLights(true);
        }

        Bitmap icon = BitmapFactory.decodeResource(context.getResources(), Resources.getResourseIdByName(context.getPackageName(), "drawable", "app_icon"));
        //icon = Bitmap.createScaledBitmap(icon, icon.getWidth() / 4, icon.getHeight() / 4, true);
        //notification.setLargeIcon(icon);
        notification.setSmallIcon(Resources.getResourseIdByName(context.getPackageName(), "drawable", "status_icon"));

        return notification;
    }

    private static int getNotificationId(Intent intent) {
        int id = -1;
        if (intent.hasExtra("pushId")) {
            id = Integer.parseInt(intent.getStringExtra("pushId"));
        }

        String repType = "";
        if (intent.hasExtra("repType")) {
            repType = intent.getStringExtra("repType");
        }
        if (repType.isEmpty() || repType.equals("0")) {
            id = UNCHECKED_NOTIFICATION_COUNTER;
            UNCHECKED_NOTIFICATION_COUNTER++;
        }
        Log.d(TAG, "Push ID: " + id + " repType: " + repType);
        return id;
    }

    private static String getTimeFromMessage(Intent intent) {
        String when = "";
        if (intent.hasExtra("sentAt")) {
            String timeString = intent.getStringExtra("sentAt");
            double timeValue = Double.parseDouble(timeString) * 1000;
            Timestamp timeStamp = new Timestamp((long) timeValue);
            Date date = new Date(timeStamp.getTime());
            when = DateFormat.format("h:mmaa", date).toString();
        } else {
            when = (String) DateFormat.format("h:mmaa", new Date());
        }
        return when;
    }
}
