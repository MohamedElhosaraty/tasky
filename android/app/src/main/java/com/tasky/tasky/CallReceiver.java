//package com.tasky.tasky;
//
//import android.annotation.TargetApi;
//import android.content.BroadcastReceiver;
//import android.content.Context;
//import android.content.Intent;
//import android.os.Build;
//import android.telephony.TelephonyManager;
//import android.util.Log;
//import android.content.SharedPreferences;
//import androidx.core.content.ContextCompat;
//
//public class CallReceiver extends BroadcastReceiver {
//    private static long startTime = 0;
//    private static String incomingNumber = "";
//
//    @TargetApi(Build.VERSION_CODES.CUPCAKE)
//    @Override
//    public void onReceive(Context context, Intent intent) {
//        String state = intent.getStringExtra(TelephonyManager.EXTRA_STATE);
//        TelephonyManager telephonyManager = ContextCompat.getSystemService(context, TelephonyManager.class);
//
//        if (telephonyManager != null) {
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.CUPCAKE) {
//                if (TelephonyManager.EXTRA_STATE_RINGING.equals(state)) {
//                    incomingNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER);
//                    if (incomingNumber == null) {
//                        incomingNumber = "رقم غير معروف";
//                    }
//                    Log.d("CALL_RECEIVER", "\uD83D\uDCDE مكالمة واردة من: " + incomingNumber);
//                }
//                else {
//                    if (TelephonyManager.EXTRA_STATE_OFFHOOK.equals(state)) {
//                        startTime = System.currentTimeMillis();
//                        Log.d("CALL_RECEIVER", "⏳ بدأ الاتصال");
//                    }
//                    else {
//                        if (TelephonyManager.EXTRA_STATE_IDLE.equals(state)) {
//                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD) {
//                                if (startTime > 0 && !incomingNumber.isEmpty()) {
//                                    long duration = (System.currentTimeMillis() - startTime) / 1000;
//                                    saveCallDetails(context, incomingNumber, duration);
//                                    Log.d("CALL_RECEIVER", "✅ انتهت المكالمة مع " + incomingNumber + " بعد " + duration + " ثانية");
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    private void saveCallDetails(Context context, String number, long duration) {
//        Log.d("CALL_RECEIVER", "\uD83D\uDCC2 حفظ المكالمة: " + number + " لمدة " + duration + " ثانية");
//        SharedPreferences prefs = context.getSharedPreferences("CallLogPrefs", Context.MODE_PRIVATE);
//        SharedPreferences.Editor editor = prefs.edit();
//        editor.putString("last_call_number", number);
//        editor.putLong("last_call_duration", duration);
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD) {
//            editor.apply();
//        }
//    }
//}