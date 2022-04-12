; --------
; CSI2120 Comprehensive Assignment Part 4
; Student: Daniel Shwan
; --------

; FUNCTIONS PROVIDED
(define (readlist filename)
 (call-with-input-file filename
  (lambda (in)
    (read in))))
(define (import)
  (let ((p65 (readlist "partition65.scm"))
        (p74 (readlist "partition74.scm")) 
        (p75 (readlist "partition75.scm"))
        (p76 (readlist "partition76.scm"))
        (p84 (readlist "partition84.scm")) 
        (p85 (readlist "partition85.scm"))
        (p86 (readlist "partition86.scm")))
    (append p65 p74 p75 p76 p84 p85 p86)))

(define (saveList filename L)
  (call-with-output-file filename
    (lambda (out)
      (write L out))
    #:exists `truncate))


; MAIN
; -----------------------------------------------------
; mergeClusters(knowledgeBase)
; input :- imported knowledge base
; output :- clusterList
;
; Main function for merging intersecting clusters from adjacent partitions.
; --------------
; Note that the mergeClusters follows the same algorithm as part 3:
;
; ClusterList := 0 // list of clusters to be produced
; for each cluster C in knowledge base {
;   I := C ∩ ClusterList // List of points in ClusterList intersecting with points in C
;   for each label L in I {
;     change label L in ClusterList to Label(C)
;   }
;   ClusterList := C ∪ ClusterList
; }
;
; This is modified from the original algorithm since the original traverses through all clusters anyway.
; This modified algorithm does the same thing but with a global list instead of a list with each entry being all clusters sorted by partition_ID
(define (mergeClusters knowledgeBase)
  (if (list? knowledgeBase)
    (removeDuplicates (addClusterToList (extractClusters knowledgeBase) `()) `())
    `()
  )
)

; extractClusters(list)
; input :- the imported list
; output :- the imported list without PARTITION_ID
;
; Helper function that returns a global list containing all clusters without the PARTITION_ID property
(define (addClusterToList knowledgeBase clusterList)
  (if (null? knowledgeBase)
    clusterList
    (addClusterToList 
      (cdr knowledgeBase) 
      (cons (car knowledgeBase) (relabelAll (car (cdddr (car knowledgeBase))) (computeIntersection (car knowledgeBase) clusterList `()) clusterList))
    )
  )
)

; extractClusters(list)
; input :- the imported list
; output :- the imported list without PARTITION_ID
;
; Helper function that returns a global list containing all clusters without the PARTITION_ID property
(define (extractClusters list)
  (if (null? list)
    `()
    (append (cons (cdr (car list)) `()) (extractClusters (cdr list)))) ; returns and appends updated cluster without PARTITION_ID
)

; removeDuplicates(clusterList, finalClusterList)
; input :- the clusterList and an empty list for the finalClusterList
; output :- the clusterList without duplicate entries
;
; Returns a global list containing all clusters without the PARTITION_ID property
(define (removeDuplicates clusterList finalClusterList)
  (cond 
    ((null? clusterList) finalClusterList)
    ((member (car clusterList) (cdr clusterList)) (removeDuplicates (cdr clusterList) finalClusterList)) ; check if current cluster exists somewhere in the rest of the list
    (else (removeDuplicates (cdr clusterList) (append (cons (car clusterList) `()) finalClusterList))) ; append current cluster if it does not appear again in the list (ensuring uniqueness)
  )
)

; computeIntersection(cluster, clusterList, intersection)
; input :- current cluster in question, current clusterList, empty list for the final intersection list
; output :- a list of points intersecting between clusters
;
; Returns a list containing points intersecting with the current cluster in question
(define (computeIntersection cluster clusterList intersection)
  (cond 
    ((null? clusterList) `()) ; return empty list of no more clusters to look at
    ((equal? (car cluster) (car (car clusterList))) (append intersection (cons (car clusterList) (computeIntersection cluster (cdr clusterList) intersection))))
    (else (computeIntersection cluster (cdr clusterList) intersection))
  )
)

; relabelAll(newId intersectedClusters clusterList)
; input :- replacement Cluster_ID, list of intersecting clusters, the current clusterList
; output :- an updated clusterList with the intersecting clusters' cluster_id being replaced with the new ID
;
; Traverses through all intersecting clusters and returns an updated clusterList with intersecting clusters' having their cluster_id updated
(define (relabelAll newId intersectedClusters clusterList)
  (if (null? intersectedClusters)
    clusterList ; returns modified if no more intersectedClusters to look at
    (relabelAll newId (cdr intersectedClusters) (relabel (car intersectedClusters) newId clusterList))
  )
)

; relabel(cluster newId clusterList)
; input :- cluster in question, new cluster_ID, current clusterList
; output :- an updated clusterList where the current cluster's ID is replaced
;
; A helper function for relabelAll() that updates clusterList with the current cluster's cluster_ID being updated
(define (relabel cluster newId clusterList)
  (cond 
    ((null? clusterList) `()) 
    ((equal? cluster (car clusterList)) (cons (changeClusterID newId (car clusterList)) (cdr clusterList))) ; updates the same cluster in clusterList if found
    (else (cons (car clusterList) (relabel cluster newId (cdr clusterList)))) ; continue traversing the list
  )
)

; changeClusterID(newId, cluster)
; input :- new cluster_ID, cluster in question
; output :- an updated cluster
;
; Helper function for relabel(). This is the function that actually updates the cluster's cluster_ID and returns the updated cluster
; This function was mainly created for cleaner code
(define (changeClusterID newId cluster)
  (cons (car cluster) (cons (car (cdr cluster)) (cons (car (cddr cluster)) (cons newId `()))))
)