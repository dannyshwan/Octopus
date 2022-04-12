package src;
/**
 * Student: Daniel Shwan
 */
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

public class TaxiClusters {

  public static void main(String[] args) {
    
    // Reading the file
    String fileName = args[0]; //Get file name Ex: "./data/data.csv";
    double eps = Double.parseDouble(args[1]); //Get epsilon value
    int minPoints = Integer.parseInt(args[2]); //Get minimum number of points
    int clusterId = 0; //Cluster id
    HashMap<String, Boolean> recordTracker = new HashMap<String, Boolean>(); // Track which data point has been seen/set as noise/set as part of the cluster
    
    try {
      FileReader fileReader = new FileReader(fileName); //Read input file
      PrintWriter writer = new PrintWriter("output.csv"); //Create output file
      BufferedReader bufferedReader = new BufferedReader(fileReader);
      
      String line = bufferedReader.readLine();
      writer.write("Custer ID,Longitude,Latitude,Number of points\n");

      /**
       * Loop through each line in the csv data file
       * 
       * dbscan algorithm is performed here.
       * Reference: https://en.wikipedia.org/wiki/DBSCAN
       */
      while((line = bufferedReader.readLine()) != null) {
        if(recordTracker.containsKey(line)) continue;

        String[] dataPoint = line.split(","); //Split the line into an array
        GPScoord coreStartPoint = new GPScoord(Float.parseFloat(dataPoint[8]), Float.parseFloat(dataPoint[9])); //Get pickup coordinates
        GPScoord coreEndPoint = new GPScoord(Float.parseFloat(dataPoint[12]), Float.parseFloat(dataPoint[13])); //Get dropoff coordinates
        TripRecord coreTripRec = new TripRecord(dataPoint[4], coreStartPoint, coreEndPoint, Float.parseFloat(dataPoint[7])); //Create trip record object

        ArrayList<String> neighbours = coreTripRec.rangeQuery(fileName, coreTripRec, eps); //Find neighbours

        // Check if size of neighbours is less than min point
        // Add 1 to include core record along with the total number of neighbours
        if((neighbours.size()+1) < minPoints) {
          recordTracker.put(line, false);
          continue;
        }

        clusterId++;
        System.out.println(clusterId);
        recordTracker.put(line, true);
        ArrayList<String> set = new ArrayList<String>();

        for (String record : neighbours) {

          // Check if current record is set as noise
          if(recordTracker.containsKey(record) && !recordTracker.get(record)){
            recordTracker.replace(record, true);
          }
          // Continue if record has been tracked and already set as part of the cluster
          else if(recordTracker.containsKey(record)) {continue;}

          recordTracker.put(record, true);

          String[] point = record.split(",");
          GPScoord startPoint = new GPScoord(Float.parseFloat(point[8]), Float.parseFloat(point[9]));
          GPScoord endPoint = new GPScoord(Float.parseFloat(point[12]), Float.parseFloat(point[13]));
          TripRecord tripRec = new TripRecord(point[4], startPoint, endPoint, Float.parseFloat(point[7]));

          //Find expanded neighbours
          ArrayList<String> expand = tripRec.rangeQuery(fileName, tripRec, eps);

          // Check if size of neighbours is less than min point
          // Add 1 to include core record 
          if(expand.size()+1 >= minPoints) {
            set.addAll(expand);
          }
        }
        neighbours.addAll(set);
        Cluster cluster = new Cluster(clusterId,coreStartPoint.getLongitude(), coreEndPoint.getLatitude(), neighbours.size()); //Create cluster
        writer.write(cluster.toString() + "\n"); //Write cluster in csv file
        
      } // End loop
      
      //Close file after reading & writing
      writer.close();
      bufferedReader.close();     

    } catch(IOException ex) {
      System.out.println("Error reading file '" + fileName + "'");                  
    }
  }
}