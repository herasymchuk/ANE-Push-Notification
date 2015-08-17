package com.freshplanet.nativeExtensions;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

public class CancelLocalNotificationFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		Context appContext = arg0.getActivity().getApplicationContext();
		Intent intent = new Intent(appContext, LocalBroadcastReceiver.class);
		
		int notificationId = 0;
		
		try {
			notificationId = arg1[0].getAsInt();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		PendingIntent sender = PendingIntent.getBroadcast(appContext, notificationId, intent, PendingIntent.FLAG_UPDATE_CURRENT);

		AlarmManager am = (AlarmManager) appContext.getSystemService(Context.ALARM_SERVICE);
		am.cancel(sender);

		
		return null;
	}

}
