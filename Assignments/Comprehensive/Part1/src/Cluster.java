package src;
/**
 * Student: Daniel Shwan
 */
public class Cluster {
  private int id; // Cluster Id
  private float longitude;
  private float latitude;
  private int numPoints; // Number of points in a cluster

  /**
   * Constructor for the cluster
   * @param id
   * @param longitude
   * @param latitude
   * @param numPoints
   */
  public Cluster(int id, float longitude, float latitude, int numPoints) {
    this.id = id;
    this.longitude = longitude;
    this.latitude = latitude;
    this.numPoints = numPoints;
  }

  /**
   * Get cluster information
   * @return Cluster information
   */
  public String toString() {
    return this.id + "," + this.longitude + "," + this.latitude + "," + this.numPoints;
  }
}
