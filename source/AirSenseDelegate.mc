import Toybox.Lang;
import Toybox.WatchUi;

class AirSenseDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new AirSenseMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}