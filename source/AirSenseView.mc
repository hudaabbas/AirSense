import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;

class AirSenseView extends WatchUi.View {
    hidden var hrText;
    var string_HR;

    function initialize() {
        View.initialize();
        Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
        Sensor.enableSensorEvents( method( :onSensor ) );
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        hrText = new WatchUi.Text({
            :text=>"Heart Rate",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_LARGE,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });

        ActivityMetrics.getUserProfile();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        ActivityMetrics.getHeartRate(); // get Activity heart rate
        ActivityMetrics.getRespirationRate();
        //ActivityMetrics.getIntensityMinutes();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); //sets background color
        dc.clear();
        hrText.setText(string_HR); // update HR text
        hrText.draw(dc);
    }

    function onSensor(sensorInfo as Sensor.Info) as Void {
        var HR = sensorInfo.heartRate;

        //System.println( "Sensor heart rate: " + HR);

        if( sensorInfo.heartRate != null )
        {
            string_HR = HR.toString() + " bpm";

        }
        else
        {
            string_HR = "--- bpm";
        }

        WatchUi.requestUpdate();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
