/**
 * Generic heart rate library
 */
using Toybox.System;
using Toybox.ActivityMonitor as Act;
using Toybox.Activity as Activity;
using Toybox.UserProfile;
using Toybox.Time;
using Toybox.Time.Gregorian;

module ActivityMetrics {

// TODO: figure out what metrics are required for the algorithm, can pull a bunch different things from a Activity/User
/* https://developer.garmin.com/connect-iq/core-topics/quantifying-the-user/ */

    function getHeartRate(){
        var heartRate = 0;
        if (Act has :getHeartRateHistory) {
            heartRate = Activity.getActivityInfo().currentHeartRate;

            if(heartRate == null) {
                var HRH=Act.getHeartRateHistory(1, true);
                var HRS=HRH.next();
                if(HRS != null && HRS.heartRate != Act.INVALID_HR_SAMPLE){
                    heartRate = HRS.heartRate;
                }
            }

            var heartRateStr = "--";
            if(heartRate != null) {
                heartRateStr = heartRate.toString();
            }

            System.println("Activity heart rate: " + heartRateStr);
        }
        return heartRate;
    }

    function getRespirationRate(){        
        var info = Act.getInfo();
        var respRate = info.respirationRate;

        if(respRate != null) {
            respRate = respRate.toString();
        }
        else {
            respRate = "--";
        }
        System.println("Respiration rate: " + respRate);
    }

    function getIntensityMinutes(){
        var info = Act.getInfo();
        var intensityMin = info.activeMinutesDay.total;
        //var intensityMinModerate = info.activeMinutesWeek.moderate;
        //var intensityMinVigorous = info.activeMinutesDay.vigorous;

        //SensorHistory.getStressHistory()

        if(intensityMin != null) {
            intensityMin = intensityMin.toString();
        }
        else {
            intensityMin = "--";
        }
        System.println("Total intensity: " + intensityMin + " minutes");
    }

    function getUserProfile(){
        var profile = UserProfile.getProfile();
        //Average Resting Heart Rate	
        var avgHR = profile.averageRestingHeartRate;	//The user’s seven day average resting heart rate (bpm)
        var sex = profile.gender; //user's gender
        var birth = profile.birthYear; // year user was born

        var age = "--";
        if(birth != null) {
            var now = Time.now();
            var info = Gregorian.info(now, Time.FORMAT_LONG);
            age = info.year - birth;
        } 

        if(avgHR != null){
            avgHR = avgHR.toString();
        } else{
            avgHR = "--";
        }

        if(sex == UserProfile.GENDER_FEMALE){
            sex = "Female";
        } else if(sex == UserProfile.GENDER_MALE){
            sex = "Male";
        } else{
            sex = "--"; //UserProfile.GENDER_UNSPECIFIED;
        }
        System.println("User profile -> \n" + age + " years old, " + sex + ", " + "Avg resting heart rate: " + avgHR + " bpm");
    }

}