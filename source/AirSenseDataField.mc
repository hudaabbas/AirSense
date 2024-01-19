using Toybox.FitContributor as Fit;
using Toybox.ActivityRecording;
using Toybox.WatchUi;

class AirSenseDataField extends WatchUi.DataField {
    hidden var activityRunning = 0;
    // Field ID from resources.
    const AIR_EXPOSURE_FIELD_ID = 0;
    hidden var mAirExposureField; //means protected
    
    hidden var sesh = null;
    hidden var airExposureScore;
    hidden var value;

    // Initializes the new field in the activity file
    function initialize(session) {
        DataField.initialize();
        airExposureScore = 0.0f;

        setupField(session);
    }

    function setupField(session) {
        //sesh = session;

        if( null == mAirExposureField ) {
            //Create the custom FIT data field we want to record.
            mAirExposureField = session.createField(
            WatchUi.loadResource(Rez.Strings.air_exposure_label), 
            AIR_EXPOSURE_FIELD_ID,
            FitContributor.DATA_TYPE_FLOAT, 
            { :mesgType=>Fit.MESG_TYPE_SESSION, :units=>WatchUi.loadResource(Rez.Strings.air_exposure_units) }   //    FitContributor.MESG_TYPE_RECORD for graph information (FitContributor.MESG_TYPE_SESSION` for summary information)
            );

            mAirExposureField.setData(0.0);
        }
    }

    // Get the field layout
    function onLayout(dc) {
        View.setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() as Void {
        value = new WatchUi.Text({
            :text=>"Air Exposure Value",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_LARGE,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    public function calculateAirExposureFactor(){
        var airExposure = 14.9 //makeRequest(); //14.9;
        System.println("Air exposure score: " + airExposure);

        if(airExposure !=null) {
            mAirExposureField.setData(airExposure);
        }

        return airExposure;
    }

    function compute(info) {
        if (info != null && info.currentHeartRate != null) {
            airExposureScore++;
            // Calculate and set data to be written to the Field
            //airExposureScore = (info.currentHeartRate / 10).toFloat();
        } else{

            airExposureScore = (ActivityMetrics.getHeartRate() / 10).toFloat();
        }
        System.println("Air exposure score: " + airExposureScore);

        if(sesh !=null && sesh.isRecording()) {
            mAirExposureField.setData(airExposureScore);
        }

        // Display the data on the screen of the device
        //WatchUi.requestUpdate();
        return airExposureScore;
    }

    function close() {
        sesh = null;
    }

    function onTimerStart(){
        if(!activityRunning){
            System.println("timer is running");
            activityRunning = true;
        }
    }

    function onTimerStop(){
        activityRunning = false;
        System.println("timer is stop");
    } 

    // Update the field layout and display the field data
    function onUpdate(dc) {
        View.onUpdate(dc);

        //View.findDrawableById("Background").setColor(getBackgroundColor());
        //var value = WatchUi.View.findDrawableById("AirExposureLabel");
        value.setColor(Graphics.COLOR_BLACK);
        value.setText(airExposureScore.format("%.2f"));
    }

    // Can alert user when their mAirExposureField gets over the threshold
   function showAlert(alertView){

   }


}
