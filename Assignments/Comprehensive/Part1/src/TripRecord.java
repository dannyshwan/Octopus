package src;

/**
 * Student: Daniel Shwan
 */
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.lang.Math;
import java.util.ArrayList;

public class TripRecord {
  private String pickupDatetime;
  private GPScoord pickupLocation;
  private GPScoord dropoffLocation;
  private float tripDistance;

  /**
   * Constructor
   * @param pickupDatetime
   * @param pickupLocation
   * @param dropoffLocation
   * @param tripDistance
   */
  public TripRecord(String pickupDatetime, GPScoord pickupLocation, GPScoord dropoffLocation, float tripDistance) {
    this.pickupDatetime = pickupDatetime;
    this.pickupLocation = pickupLocation;
    this.dropoffLocation = dropoffLocation;
    this.tripDistance = tripDistance;
  }

  /**
   * Get pickup date/time
   * @return pickupDatetime
   */
  public String getPickupDatetime() {
    return this.pickupDatetime;
  }

  /**
   * Get pickup location
   * @return pickupLocation
   */
  public GPScoord getPickupLocation() {
    return this.pickupLocation;
  }
  
  /**
   * Get dropoff location
   * @return dropoffLocation
   */
  public GPScoord getDropoffLocation() {
    return this.dropoffLocation;
  }

  /**
   * Get trip distance
   * @return tripDistance
   */
  public float getTripDistance() {
    return this.tripDistance;
  }

  /**
   * Get number of neighbours
   * @param db file being read
   * @param p current record
   * @param eps epsilon
   * @return number of neighbours
   */
  public ArrayList<String> rangeQuery(String db, TripRecord p, double eps) {
    ArrayList<String> records = new ArrayList<String>();
    try {
      FileReader fileReader = new FileReader(db);
      BufferedReader dbReader = new BufferedReader(fileReader);
      String line = dbReader.readLine();

      // Loop through each line
      while((line = dbReader.readLine()) != null) {
        String[] dataPoint = line.split(",");
        GPScoord startPoint = new GPScoord(Float.parseFloat(dataPoint[8]), Float.parseFloat(dataPoint[9]));
        GPScoord endPoint = new GPScoord(Float.parseFloat(dataPoint[12]), Float.parseFloat(dataPoint[13]));
        TripRecord q = new TripRecord(dataPoint[4], startPoint, endPoint, Float.parseFloat(dataPoint[7]));

        // skip if p and q are the same
        if(sameRecord(p,q)) {
          continue;
        }
        double distance = dist(p, q);

        if(distance <= eps) {
          records.add(line);
        }
      }
      dbReader.close();   
    }
    catch(IOException ex) {
      System.out.println("Error reading file");   
    }
    return records;
  }

  /**
   * Get the distance between two starting points
   * @param p origin trip record
   * @param q neighbouring trip record
   * @return distance
   */
  private double dist(TripRecord p, TripRecord q) {
    GPScoord pPickup = p.getPickupLocation();
    GPScoord qPickup = q.getPickupLocation();

    // Get distances between two starting point
    double distance = Math.sqrt(Math.pow(qPickup.getLatitude() - pPickup.getLatitude(), 2) + Math.pow(qPickup.getLongitude() - pPickup.getLongitude(), 2));
    return distance;
  }

  /**
   * Check if two trip records are the same
   * @param p trip record
   * @param q trip record
   * @return boolean
   */
  private boolean sameRecord(TripRecord p, TripRecord q) {
    boolean date = p.pickupDatetime.equals(q.pickupDatetime);
    boolean dist = p.tripDistance == q.tripDistance;
    boolean sameStart = (p.pickupLocation.getLongitude() == q.pickupLocation.getLongitude()) && (p.pickupLocation.getLatitude() == q.pickupLocation.getLatitude());
    boolean sameEnd = (p.dropoffLocation.getLongitude() == q.dropoffLocation.getLongitude()) && (p.dropoffLocation.getLatitude() == q.dropoffLocation.getLatitude());
    return date && dist && sameStart && sameEnd;
  }
}