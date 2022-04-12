package src;
/**
 * Student: Daniel Shwan
 */
public class GPScoord {
  private float latitude; // Latitude of the coordinate
  private float longitude;// Longitude of the coordinate

  /**
   * Constructor for the GPS coordinate class
   * @param longitude
   * @param latitude
   */
  public GPScoord(float longitude, float latitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  /**
   * Get the coordinate's longitude
   * @return longitude
   */
  public float getLongitude() {
    return this.longitude;
  }

  /**
   * Get the coordinate's latitude
   * @return latitude
   */
  public float getLatitude() {
    return this.latitude;
  }
}
