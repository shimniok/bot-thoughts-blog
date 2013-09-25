/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sobrietyfx;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.application.Platform;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.XYChart;
import javax.ws.rs.client.WebTarget;

/**
 *
 * @author shimniom
 */
class DistanceMonitor {
 
    private static final long FIXED_DELAY = 5000; // 5s
    private final XYChart.Series distanceData;
    private final WebTarget targetDistance;
    private StringProperty distanceProperty = new SimpleStringProperty();
    
    public StringProperty distanceProperty() {
        return distanceProperty;
    }

    public DistanceMonitor(WebTarget webTarget, LineChart chart) {
        distanceData = new XYChart.Series();
        distanceData.setName("Distance");

        chart.getData().addAll(distanceData, distanceData);
        targetDistance = webTarget.path("/distance");

    }

    public void start() {
        Timer timer = new Timer(true);
        timer.schedule(new DistanceMonitor.MonitorService(), 5000, FIXED_DELAY);
    }

    class MonitorService extends TimerTask {

        private static final int MAX_ITEMS = 18;
        private SimpleDateFormat sdf = new SimpleDateFormat("mm:ss");

        @Override
        public void run() {
            // temperatures
            String sDistance = targetDistance.request().get(String.class);
            try {
                Thread.sleep(500);
            } catch (InterruptedException ex) {
                Logger.getLogger(DistanceMonitor.class.getName()).log(Level.SEVERE, null, ex);
            }

            final float distanceOut = new Float(sDistance);
            
            // category time
            Calendar cal = Calendar.getInstance();
            Date date = cal.getTime();
            final String category = sdf.format(date);

            Platform.runLater(new Runnable() {
                @Override
                public void run() {
                    if (distanceData.getData().size() == MAX_ITEMS) {
                        distanceData.getData().remove(0);
                    }
                    distanceProperty.set(Float.toString(distanceOut));
                    distanceData.getData().add(new XYChart.Data(category, distanceOut));
                }
            });
        }
    }   
}
