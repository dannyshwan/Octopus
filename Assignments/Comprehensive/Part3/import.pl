% --------
% CSI2120 Comprehensive Assignment Part 3
% Student: Daniel Shwan
% --------
import:-
  csv_read_file('partition65.csv', Data65, [functor(partition)]),maplist(assert, Data65),
  csv_read_file('partition74.csv', Data74, [functor(partition)]),maplist(assert, Data74),
  csv_read_file('partition75.csv', Data75, [functor(partition)]),maplist(assert, Data75),
  csv_read_file('partition76.csv', Data76, [functor(partition)]),maplist(assert, Data76),
  csv_read_file('partition84.csv', Data84, [functor(partition)]),maplist(assert, Data84),
  csv_read_file('partition85.csv', Data85, [functor(partition)]),maplist(assert, Data85),
  csv_read_file('partition86.csv', Data86, [functor(partition)]),maplist(assert, Data86),listing(partition).

% MAIN
% -----------------------
% Note that the mergeClusters follows the following algorithm:
%
% ClusterList := 0 // list of clusters to be produced
% for each cluster C in knowledge base {
%   I := C ∩ ClusterList // List of points in ClusterList intersecting with points in C
%   for each label L in I {
%     change label L in ClusterList to Label(C)
%   }
%   ClusterList := C ∪ ClusterList
% }
%
% This is modified from the original algorithm because I've decided to use the findAll predicate provided in the assignment PDF.
% This modified algorithm takes in consideration of this change.

% mergeClusters/1
% mergeClusters(ClusterList)
% merge intersecting clusters from adjacent partitions.
mergeClusters(L) :- 
  findall([D,X,Y,C],partition(_,D,X,Y,C),GlobalClusterList), 
  addClusterToClusterList(GlobalClusterList,[],LWithDuplicates),
  sort(LWithDuplicates,L). % Remove duplicate entries & sorts list

% addClusterToClusterList/3
% addClusterToClusterList(AllClusters, CurrentClusterList, FinalClusterList)
% Traverses through each cluster and merge it to the ClusterList
addClusterToClusterList([],R,R).
addClusterToClusterList([[P_Id,X,Y,C_Id]| GCLs], CurrMergedCluster,Result) :- 
  intersectingClusters([P_Id,X,Y,C_Id], CurrMergedCluster, Intersected), % Get list of points in ClusterList intersecting with points in the current cluster
  relabelAll(C_Id, Intersected, CurrMergedCluster, Temp), % Relabel every intersected point with its new clusterId; produces modified ClusterList
  append(Temp, [[P_Id,X,Y,C_Id]], NewMergedCluster), % Add the current cluster to the newly modified ClusterList
  addClusterToClusterList(GCLs, NewMergedCluster, Result). % Continue loop

% relabelAll/4
% relabelAll(newClusterId, ListofIntersectedPoints, ClusterList, modifiedClusterList)
% modifies all of the intersected points with the new specified clusterId
relabelAll(_,[],R,R).
relabelAll(C_Id, [H|T], CurrMergedCluster, L) :- relabel(H,C_Id, CurrMergedCluster, Temp), relabelAll(C_Id,T,Temp,L).

% relabel/4
% relabel(O,R,clusterListIn, clusterListOut)
% relabels the label of cluster O with label R
relabel(_,_,[],[]).
relabel([P,X,Y,O],R,[[P1,X1,Y1,O1]|ListInTail], [[P,X,Y,R]| ListOut]) :- 
  P =:= P1, % Checks if Cluster O is the same as the cluster in ClusterList
  X =:= X1,
  Y =:= Y1,
  O =:= O1,
  relabel(O,R,ListInTail,ListOut).
relabel(O,R,[Cluster|ListInTail], [Cluster|ListOut]) :- relabel(O,R,ListInTail,ListOut). % For if O and List are not the same

% intersectingClusters/3
% intersectingClusters(Cluster, ClusterList, IntersectingClusters)
% This predicate finds the points in clusterList intersecting with the current Cluster.
% It uses the POINT_ID to compare the points
intersectingClusters(_,[],[]).
intersectingClusters([P_Id,_,_,_], [[ClusterListP_Id,X,Y,C_Id]|CLs], [[P_Id,X,Y,C_Id]|Is]) :- 
  P_Id =:= ClusterListP_Id, % Check if the point_id is the same as the point_id in clusterlist
  intersectingClusters([P_Id,_,_,_], CLs, Is).
intersectingClusters([P_Id,_,_,_], [_|CLs], Is) :- intersectingClusters([P_Id,_,_,_], CLs, Is).



% TESTING
% -----------------------
% Test mergeClusters predicate
test(mergeClusters) :- write('mergeClusters(L)'),nl,
  mergeClusters(L),
  write(L).

% Test addClusterToClusterList predicate
test(addClusterToClusterList) :- write('addClusterToClusterList([[1,2,2,3],[2,1,2,3],[1,2,2,4],[3,2,1,2]],[],L).'),nl,
  addClusterToClusterList([[1,2,2,3],[2,1,2,3],[1,2,2,4],[3,2,1,2]],[],L),
  write(L).

% ------------------------------
% Test intersectingClusters predicate
test(intersectingClusters) :-  write('intersectingClusters([1,1,1,1],[[1,2,2,3],[1,3,3,4],[2,1,1,2]],L)'),nl,
  intersectingClusters([1,1,1,1],[[1,2,2,3],[1,3,3,4],[2,1,1,2]],L),
  write(L).

% Should return empty list
test(intersectingClustersNoIntersect) :-  write('intersectingClusters([5,1,1,1],[[1,2,2,3],[1,3,3,4],[2,1,1,2]],L)'),nl,
  intersectingClusters([5,1,1,1],[[1,2,2,3],[1,3,3,4],[2,1,1,2]],L),
  write(L).

% ------------------------------
% Test relabelAll predicate
test(relabelAll) :- write('relabelAll(999,[[28,12,222,14],[1,2,3,4],[-23,44,12,33]], [[28,12,222,14],[1,2,3,4],[12,13,77,12313],[1,666,-42,1092401],[789,41,98,22],[-23,44,12,33]], L)'),nl,
  relabelAll(999,[[28,12,222,14],[1,2,3,4],[-23,44,12,33]], [[28,12,222,14],[1,2,3,4],[12,13,77,12313],[1,666,-42,1092401],[789,41,98,22],[-23,44,12,33]], L),
  write(L).

% Should return original ClusterList
test(relabelAllNoIntersect) :- write('relabelAll(999,[], [[28,12,222,14],[1,2,3,4],[12,13,77,12313],[1,666,-42,1092401],[789,41,98,22],[-23,44,12,33]], L)'),nl,
  relabelAll(999,[], [[28,12,222,14],[1,2,3,4],[12,13,77,12313],[1,666,-42,1092401],[789,41,98,22],[-23,44,12,33]], L),
  write(L).

% Test relabel predicate
test(relabel) :- write('relabel(33, 77,
  [[1,2.2,3.1,33], [2,2.1,3.1,22], [3,2.5,3.1,33], [4,2.1,4.1,33],[5,4.1,3.1,30]],Result)'),nl,
  relabel(33,77,
  [[1,2.2,3.1,33], [2,2.1,3.1,22], [3,2.5,3.1,33], [4,2.1,4.1,33], [5,4.1,3.1,30]],Result),
  write(Result). 