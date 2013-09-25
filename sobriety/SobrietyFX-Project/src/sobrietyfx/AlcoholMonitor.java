/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sobrietyfx;

import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.application.Platform;
import javafx.beans.property.FloatProperty;
import javafx.beans.property.ReadOnlyFloatProperty;
import javafx.beans.property.ReadOnlyStringProperty;
import javafx.beans.property.SimpleFloatProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javax.ws.rs.client.WebTarget;

/**
 *
 * @author shimniom
 */
class AlcoholMonitor {
    
    private static final long DELAY = 2000; // milliseconds
    private FloatProperty floatValue = new SimpleFloatProperty();
    private StringProperty value = new SimpleStringProperty();
    private final WebTarget target;

    public AlcoholMonitor(WebTarget target) {
        this.target = target.path("/alcohol");
    }

    public void start() {
        Timer timer = new Timer(true);
        timer.schedule(new AlcoholMonitor.MonitorService(), 5000, 5000);
    }

    class MonitorService extends TimerTask {

        @Override
        public void run() {
            try {
                Thread.sleep(500);
            } catch (InterruptedException ex) {
                Logger.getLogger(AlcoholMonitor.class.getName()).log(Level.SEVERE, null, ex);
            }
            String sAlcohol = target.request().get(String.class);
            try {
                Thread.sleep(500);
            } catch (InterruptedException ex) {
                Logger.getLogger(AlcoholMonitor.class.getName()).log(Level.SEVERE, null, ex);
            }
            final float alcohol = new Float(sAlcohol);
            Platform.runLater(new Runnable() {
                @Override
                public void run() {
                    floatValue.set(alcohol);
                    value.set(Float.toString(alcohol));
                }
            });
        }
    }

    public ReadOnlyStringProperty alcoholProperty() {
        return value;
    }

    public ReadOnlyFloatProperty floatProperty() {
        return floatValue;
    }
}
