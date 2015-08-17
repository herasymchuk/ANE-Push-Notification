package com.freshplanet.nativeExtensions;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.util.Date;

import android.os.Vibrator;
import android.support.v4.app.NotificationCompat;
import android.text.format.DateFormat;
import android.util.Log;
import org.json.JSONObject;
import org.json.JSONTokener;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.AudioManager;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.AsyncTask;

import com.distriqt.extension.util.Resources;

public class CreateNotificationTask extends AsyncTask<Void, Void, Boolean>
{
	private static int NOTIFICATION_ID = 1;
	
	private Context _context;
	private Intent _intent;
	private Bitmap _picture;

	public CreateNotificationTask(Context context, Intent intent)
	{
		super();
		_context = context;
		_intent = intent;
	}

	@Override
	protected Boolean doInBackground(Void... params)
	{
		// Try to download the picture
		try
		{
			// Get picture URL from parameters
			String jsonParameters = _intent.getStringExtra("parameters");
			String pictureUrl = null;
			if (jsonParameters != null)
			{
				try
				{
					JSONObject parameters = (JSONObject)new JSONTokener(jsonParameters).nextValue();
					if (parameters != null)
					{
						if (parameters.has("pictureUrl"))
						{
							pictureUrl = parameters.getString("pictureUrl");
						}
						else if (parameters.has("facebookId"))
						{
							pictureUrl = "http://graph.facebook.com/"+parameters.getString("facebookId")+"/picture?type=normal";
						}
					}
				}
				catch (Exception e)	
				{
					e.printStackTrace();
				}
			}
			if (pictureUrl == null) return false;
			
			// Download picture
			HttpURLConnection connection = (HttpURLConnection)(new URL(pictureUrl)).openConnection();
			connection.setDoInput(true);
			connection.connect();
			InputStream input = connection.getInputStream();
			Bitmap rawPicture = BitmapFactory.decodeStream(input);
			
			// Center-crop the picture as a square
			if (rawPicture.getWidth() >= rawPicture.getHeight())
			{
				_picture = Bitmap.createBitmap(
						rawPicture, 
						rawPicture.getWidth()/2 - rawPicture.getHeight()/2, 0,
						rawPicture.getHeight(), rawPicture.getHeight());

			}
			else
			{
				_picture = Bitmap.createBitmap(
						rawPicture,
						0, rawPicture.getHeight()/2 - rawPicture.getWidth()/2,
						rawPicture.getWidth(), rawPicture.getWidth() );
			}
			
			if (rawPicture.getWidth() > 100)
			{
				_picture = Bitmap.createScaledBitmap(_picture, 100, 100, false);
			}
			
			return true;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}

	@Override
	protected void onPostExecute(Boolean downloadSuccess)
	{
		if (_context == null || _intent == null)
		{
			Extension.log("Couldn't create push notification: _context or _intent was null (CreateNotificationTask.onPostExecute)");
			return;
		}

		// Notification texts
		CharSequence contentTitle = _intent.getStringExtra("contentTitle");
		if (contentTitle != null && contentTitle.length() > 22)
		{
			contentTitle = contentTitle.subSequence(0, 20) + "...";
		}

		CharSequence contentText = _intent.getStringExtra("contentText");
		CharSequence tickerText = _intent.getStringExtra("tickerText");

		Integer nID = -1;
		if (_intent.hasExtra("pushId")){
			nID = Integer.parseInt(_intent.getStringExtra("pushId"));
		}

		String rType = "";
		if (_intent.hasExtra("repType")){
			rType = _intent.getStringExtra("repType");
		}

		if(rType.equals("0")) {
			nID = NOTIFICATION_ID;
			NOTIFICATION_ID++;
		}

		Log.d("!!!!!!!!!!!!!!!!!!!!!!!!!!", "Send notif with id: " + nID.toString() + " rType: " +  rType);

		// Notification images
		int smallIconId = Resources.getResourseIdByName(_context.getPackageName(), "drawable", "status_icon");
		int largeIconId = Resources.getResourseIdByName(_context.getPackageName(), "drawable", "app_icon");
		Bitmap largeIcon;
		if (downloadSuccess)
		{
			largeIcon = _picture;
		}
		else
		{
			largeIcon = BitmapFactory.decodeResource(_context.getResources(), largeIconId);
		}
		
		// Notification sound
		Uri soundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
		Boolean withSound = !_intent.getStringExtra("sound").equals("none");
		Boolean withVibration = Boolean.valueOf(_intent.getStringExtra("vibrate"));
		
		// Notification action
		Intent notificationIntent = new Intent(_context, NotificationActivity.class);;
		notificationIntent.putExtra("params", Extension.getParametersFromIntent(_intent));
		notificationIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP |
				Intent.FLAG_ACTIVITY_SINGLE_TOP);
		PendingIntent contentIntent = PendingIntent.getActivity(_context, 0, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT);

//		RemoteViews _contentView = new RemoteViews(_context.getPackageName(), Resources.getResourseIdByName(_context.getPackageName(),
//				"layout", "contentview"));
//		_contentView.setTextViewText(Resources.getResourseIdByName(_context.getPackageName(), "id", "contentviewtext"),
//				contentText);
//		_contentView.setTextViewText(Resources.getResourseIdByName(_context.getPackageName(), "id", "contentviewtitle"),
//				contentTitle);
//		_contentView.setTextViewText(Resources.getResourseIdByName(_context.getPackageName(), "id", "contentviewtime"),
//				getTimeFromMessage(_intent));
//		_contentView.setImageViewResource(Resources.getResourseIdByName(_context.getPackageName(), "id", "contentviewsmalllogo"),
//				smallIconId);

		// Create notification
		NotificationCompat.Builder builder = new NotificationCompat.Builder(_context)
				.setContentTitle(contentTitle)
				.setContentText(contentText)
				.setSmallIcon(smallIconId)
				.setLargeIcon(largeIcon)
				.setTicker(tickerText)
				.setWhen(System.currentTimeMillis())
				.setAutoCancel(true)
				//.setContent(_contentView)
				.setContentIntent(contentIntent);

		if(withSound) {
			builder.setSound(soundUri, AudioManager.STREAM_NOTIFICATION);
		}
		if(withVibration) {
			Vibrator v = (Vibrator) _context.getSystemService(Context.VIBRATOR_SERVICE);
			v.vibrate(100);
			//builder.setVibrate(new long[] {1000, 1000, 1000});
		}

		Notification notification = builder.build();
		NotificationManager notificationManager = (NotificationManager)_context.getSystemService(Context.NOTIFICATION_SERVICE);
		notificationManager.notify(nID, notification);
	}

	private String getTimeFromMessage(Intent intent)
	{
		String when = "";
		if (intent.hasExtra("sentAt"))
		{
			String timeString = intent.getStringExtra("sentAt");
			double timeValue = Double.parseDouble(timeString) * 1000;
			Timestamp timeStamp = new Timestamp((long) timeValue);
			Date date = new Date(timeStamp.getTime());
			when = DateFormat.format("h:mmaa", date).toString();
		} else
		{
			when = (String) DateFormat.format("h:mmaa", new Date());
		}
		return when;
	}
}
