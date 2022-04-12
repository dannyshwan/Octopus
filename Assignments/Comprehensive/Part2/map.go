// CSI2120 Comprehensive Assignment Part 2
// Winter 2022
// Daniel Shwan
package main

import (
	"encoding/csv"
	"fmt"
	"io"
	"math"
	"os"
	"runtime"
	"strconv"
	"sync"
	"time"
)

type GPScoord struct {

  lat float64
	long float64
}

type LabelledGPScoord struct {
  GPScoord
	ID int     // point ID
	Label int  // cluster ID
}

// Structure for storing the information used for the DBScan jobs
type dbScanInfo struct {
	coords []LabelledGPScoord
	minPts int
	eps float64
	offset int
}

const N int=4
const MinPts int=5
const consumeThreads = 1 // Number of consumer threads. At minimum: 1
const eps float64= 0.0003
const filename string="yellow_tripdata_2009-01-15_9h_21h_clean.csv"

func main() {
	// channel for sending jobs
	jobs := make(chan dbScanInfo)	

	// mutex for synchronisation
	var mutex sync.WaitGroup
	mutex.Add(consumeThreads) 

  start := time.Now(); 
  gps, minPt, maxPt := readCSVFile(filename)
	fmt.Printf("Number of points: %d\n", len(gps))
	
	minPt = GPScoord{40.7, -74.}
	maxPt = GPScoord{40.8, -73.93}
	
	// geographical limits
	fmt.Printf("SW:(%f , %f)\n", minPt.lat, minPt.long)
	fmt.Printf("NE:(%f , %f) \n\n", maxPt.lat, maxPt.long)
	
	// Parallel DBSCAN STEP 1.
	incx := (maxPt.long-minPt.long)/float64(N)
	incy := (maxPt.lat-minPt.lat)/float64(N)
	
	var grid [N][N][]LabelledGPScoord  // a grid of GPScoord slices
	
	// Create the partition
	// triple loop! not very efficient, but easier to understand
	partitionSize:=0

  for j:=0; j<N; j++ {
    for i:=0; i<N; i++ {
	
	  	for _, pt := range gps {
		
		  	// is it inside the expanded grid cell
		  	if (pt.long >= minPt.long+float64(i)*incx-eps) && (pt.long < minPt.long+float64(i+1)*incx+eps) && (pt.lat >= minPt.lat+float64(j)*incy-eps) && (pt.lat < minPt.lat+float64(j+1)*incy+eps) {
				
        	grid[i][j]= append(grid[i][j], pt) // add the point to this slide
					partitionSize++;
       	}				
			}
	  }
	}	

	// Start the consumer threads
	for i:=0; i<consumeThreads; i++ {
		go consume(jobs, &mutex)
	}

	// producer
	// produces the job for each partition
  for j:=0; j<N; j++ {
    for i:=0; i<N; i++ {
			jobs <- dbScanInfo{grid[i][j], MinPts, eps, i*10000000+j*1000000}
		}
	}

	close(jobs) // close the jobs channel
	mutex.Wait() // wait for all goroutine to finish
	
	// Parallel DBSCAN step 3.
	// merge clusters
	// *DO NOT PROGRAM THIS STEP
	
	end := time.Now();
  fmt.Printf("\nExecution time: %s of %d points\n", end.Sub(start), partitionSize)
  fmt.Printf("Number of CPUs: %d", runtime.NumCPU())
}

// Consumer function
// jobs: a dbScanInfo channel
// done: pointer to a sync.WaitGroup
func consume(jobs chan dbScanInfo, done *sync.WaitGroup) {
	for {
		j, more := <-jobs

		if more {
			DBscan(j.coords, j.minPts, j.eps, j.offset) // perform dbscan on a given partition
		} else {
			done.Done() // finish consume goroutine
			return
		}
	}
}

// Applies DBSCAN algorithm on LabelledGPScoord points
// LabelledGPScoord: the slice of LabelledGPScoord points
// MinPts, eps: parameters for the DBSCAN algorithm
// offset: label of first cluster (also used to identify the cluster)
// returns number of clusters found
//
// Reference: https://en.wikipedia.org/wiki/DBSCAN#Original_query-based_algorithm
func DBscan(coords []LabelledGPScoord, MinPts int, eps float64, offset int) (nclusters int) {

  time.Sleep(3)
  nclusters=0 // number of clusters

  for _, p := range coords {

		// if Label is not set, it is automatically 0. Check for the 0
		if p.Label != 0 {
			continue;
		}

		// Find neighbours
		neighbours := rangeQuery(coords, p.GPScoord, eps)

		// density check
		// We add 1 to compensate the current point p itself.
		if len(neighbours)+1 < MinPts {
			p.Label = -1; // Mark as noise
			continue;
		}
		nclusters++ // Increment numbers of clusters
		p.Label = nclusters + offset // Label initial point
		
		seed := neighbours

		for _, q := range seed {

			// Check if current point is set as noise
			if q.Label == -1 {
				q.Label = nclusters + offset
			}

			// Checks if current point is not labelled
			if q.Label != 0 {
				continue
			}
			q.Label = nclusters + offset

			// Find the neighbours for the current point
			nNeighbours := rangeQuery(coords, q.GPScoord, eps)

			// If number of neighbours surpasses minPts. Append nNeighbours to seed.
			if len(nNeighbours)+1 >= MinPts {
				seed = append(seed , nNeighbours...)
			}
		}
	}
  
  // End of DBscan function
  // Printing the result (do not remove)
  fmt.Printf("Cluster %10d : [%4d,%6d]\n", offset, nclusters, len(coords))
  
  return nclusters
}

// Get number of neighbours
// LabelledGPScoord: the slice of LabelledGPScoord points
// q: GPScoord point
// eps: parameter for the DBSCAN algorithm
// returns an array of neighbours surrounding point q
func rangeQuery(coords []LabelledGPScoord, q GPScoord,eps float64) (neighbours []LabelledGPScoord){

	for _, p := range coords{

		// Checks if point q is point p
		// Also calculates the distance between the two points and checks if it's less than or equal to eps
		// If so, append P to neighbours
		if (q.lat == p.lat && q.long == p.long && distFunc(q, p.GPScoord) <= eps) {
			neighbours = append(neighbours, p)
		}
	}
	return neighbours
}

// Get the distance between two points
// q: the origin point
// p: the neighbouring point
// returns the distance between q and p
func distFunc(q GPScoord, p GPScoord) (dist float64){
	sum := math.Pow(p.lat - q.lat, 2) + math.Pow(p.long - q.long, 2)
	dist = math.Sqrt(sum)
	return dist
}

// reads a csv file of trip records and returns a slice of the LabelledGPScoord of the pickup locations  
// and the minimum and maximum GPS coordinates
func readCSVFile(filename string) (coords []LabelledGPScoord, minPt GPScoord, maxPt GPScoord) {

  coords= make([]LabelledGPScoord, 0, 5000)

  // open csv file
  src, err := os.Open(filename)
	defer src.Close()
  if err != nil {
    panic("File not found...")
  }
	
	// read and skip first line
  r := csv.NewReader(src)
  record, err := r.Read()
  if err != nil {
      panic("Empty file...")
  }

  minPt.long = 1000000.
  minPt.lat = 1000000.
  maxPt.long = -1000000.
  maxPt.lat = -1000000.
	
	var n int=0
	
    for {
      // read line
      record, err = r.Read()

      // end of file?
      if err == io.EOF {
        break
      }

      if err != nil {
        panic("Invalid file format...")
      }
		
			// get lattitude
			lat, err := strconv.ParseFloat(record[9], 64)
    	if err != nil {
    	  panic("Data format error (lat)...")
    	}

    	// is corner point?
			if lat>maxPt.lat {
			  maxPt.lat= lat
			}		
			if lat<minPt.lat {
			    minPt.lat= lat
			}

			// get longitude
			long, err := strconv.ParseFloat(record[8], 64)
    	  if err != nil {
    	    panic("Data format error (long)...")
    	  }
			
    	  // is corner point?
			if long>maxPt.long {
			  maxPt.long= long
			}

			if long<minPt.long {
			  minPt.long= long
			}

      // add point to the slice
			n++
      pt:= GPScoord{lat,long}
      coords= append(coords, LabelledGPScoord{pt,n,0})
    }
  return coords, minPt,maxPt
}