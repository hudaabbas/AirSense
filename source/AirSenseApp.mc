import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class AirSenseApp extends Application.AppBase {
    //var airSensor;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        //airSensor = new AirSenseDataField();
        //airSensor.open();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        //airSensor.close();
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new AirSenseView() , new AirSenseDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as AirSenseApp {
    return Application.getApp() as AirSenseApp;
}