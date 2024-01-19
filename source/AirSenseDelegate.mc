import Toybox.Lang;
import Toybox.WatchUi;

class AirSenseDelegate extends WatchUi.BehaviorDelegate {
    var session = null;
    var airSensor = null;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new AirSenseMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(evt) {
        var key = evt.getKey();
        if (WatchUi.KEY_START == key || WatchUi.KEY_ENTER == key) { //if the Start/Enter key is pressed
            return onSelect();
        }
        return false;
    }

    // use the select Start/Stop or touch for recording
    function onSelect() {
        if (Toybox has :ActivityRecording) {                         // check device for activity recording
            if ((session == null) || (session.isRecording() == false)) {
                System.println("Start activity recording!!");
                session = ActivityRecording.createSession({          // set up recording session
                        :name=>"Air Sensor Run",                              // set session name
                        :sport=>Activity.SPORT_GENERIC,                // set sport type
                        :subSport=>Activity.SUB_SPORT_GENERIC          // set sub sport type
                });
                airSensor = new AirSenseDataField(session); // set up new air exposure factor data field
                session.start();                                     // call start session
                //airSensor.setupField(session); 
            }
            else if ((session != null) && session.isRecording()) {
                //update();
                airSensor.calculateAirExposureFactor();
                System.println("Stop activity recording!!");
                session.stop();                                      // stop the session
                session.save();                                      // save the session
                session = null;                                      // set session control variable to null
                //airSensor.close(); // pass null back to AirSenseDataField
            }
        }
        return true;                                                 // return true for onSelect function
    }

    // TODO: figure out where/how to call this to update the Air Exposure Factor data field
    function update(){
        airSensor.compute(Activity.getActivityInfo());
    }

}