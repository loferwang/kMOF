# kMOF
A novel local outlier detection algorithm based on substructures

Abstract:
 Many local outlier detection techniques have been proposed to recognize meaningful local outliers, and precious research usually use k-nearest neighbors to quantify local neighborhood (kNN neighborhood) and design outlier scoring functions. However, kNN neighborhood can not exactly express local feature of datasets presenting non-spherical distribution. Furthermore, the scoring functions are based on a potential assumption that all reference neighbors of an observation are normal, which often leads to low detection performance. In addition, kNNbased methods are often sensitive to k. To solve the problems, new deﬁnitions of local neighborhood and outlier scoring function are proposed, named minimum spinning tree with k nodes (k-MST) and k-MST-based outlier factor (kMOF), respectively. The k-MST has no special requirement on data and is insensitive to k, and close data points can share the same k-MST. Unlike traditional scoring functions, the kMOF scores each substructure instead of each data point for a dataset. Based on these new design, the proposed algorithm is highly eﬀective for detecting outliers and groups of outliers, and has potential to improve eﬃciency. Experimental results both on synthetic and real-world datasets demonstrate that the proposed algorithm is eﬀective and robust. 

%%%%%%%%%%%%%%%%%%%%%%

This code is supported in MATLAB 2013a and above.

%%%%%%%%%%%%%%%%%%%%%

















