# EvaluationScripts
Evaluation scripts used in our manuscript "Electron tomography of mouse LINC complexes at meiotic telomere attachment sites with and without microtubules".

## Distances.m
Calculates the distance measurements between filaments as shown in Figure 6.
Requires the output of 3dmod's model2points function as input with the variable name "input".

## Stretchfactor.m 
Calculates the stretchfactor for individual filaments as shown in Figure 7.
Requires the output of the Distances.m function as input with the variable name "GefilterteFilamente".

## CutoffEval.m
Calculates the difference in average linear distance for filaments for different cutoff values in regard to distance to the microtubule.
Requires the output of 3dmod's model2points function as input with the variable name "Points".
Requires the output of the Distances.m function as input with the variable name "GefilterteFilamente".
