/**
 * Generic heart rate library
 */

using Toybox.System;
using Toybox.ActivityMonitor as Act;
using Toybox.Activity as Activity;

module HeartRate {

function getHeartRate(){
    if (Act has :getHeartRateHistory) {
        var heartRate = Activity.getActivityInfo().currentHeartRate;

        if(heartRate == null) {
            var HRH=Act.getHeartRateHistory(1, true);
            var HRS=HRH.next();
            if(HRS != null && HRS.heartRate != Act.INVALID_HR_SAMPLE){
                heartRate = HRS.heartRate;
            }
        }

        if(heartRate != null) {
            heartRate = heartRate.toString();
        }
        else {
            heartRate = "--";
        }
        System.println(heartRate);
    }
}

}