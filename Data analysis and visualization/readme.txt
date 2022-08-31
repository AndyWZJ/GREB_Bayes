Data analysis and visualization

= = =



introduce

------------

Data Analysis and Visualization is a Data analysis and visualization package based on MATLAB. The code name is consistent with the picture name of the paper, including 2D visualization and 3D visualization

parts

------------

Data Analysis and Visualization contains six different parts:

1.Fig 2.Simulation results of the surface average temperature state. (a) 5 classification; (b) 7 classification; (C) 9 Classification. (Figure 2.m)

2.Fig 3.Simulation results of the atmospheric average temperature state. (a) 5 classification; (b) 7 classification; (c) Classification. (Figure 3.m)

3. Fig.4.com Parison Result of the average Accuracy of Different Methods. (Fig. 4.m)

4.Fig 5.Comparison results of the accuracy of simulation results of surface average temperature. (a) IMPM under 5classification; (b) IMPM under 7 classification; (c) IMPM under 9 classification; (d) GREB under 5 classification; (D) IMPMunder 7 classification; (E) IMPM under 9 Classification. (Figure 5.m)

5.Fig 6.Comparison results of the accuracy of simulation results of atmospheric average temperature. (a) IMPM under 5235classification; (b) IMPM under 7 classification; (c) IMPM under 9 classification; (d) GREB under 5 classification; (D) IMPMunder 7 classification; (E) IMPM under 9 Classification. (Figure 6.m)

6.Fig 7.Average accuracy variation trend results of latitude. (a) surface average temperature; (b) Atmospheric averagetemperature. (Figure 7.m)





data

------------

Average Temperature and Atmospheric Average Temperature Based on the 3.75буб┴3.75бу Global data sets by Environmental Predic-tion(NCEP)/ National Center for Atmospheric Research(NCAR) from 1985 to 2014.

The experimental data used in this paper include five kinds of data, including T temperature data, and the dimensions are all (96 * 48 * 120).

Environmental Predic-tion(NCEP)/ National Center for Atmospheric Research(NCAR) from 1985 to 2014

The experimental data can also be downloaded for free from https://psl.noaa.gov/data/gridded/data.ncep.reanalysis.pressure.html.

The original GREB Model adopts the Model code of GREB Model from Monash Simple Climate Model (MSCM) laboratory repository, and runs the code in Fortran language. Model code can be obtained from https://doi.org/10.5281/zenodo.2232282.



The experimental data can also be downloaded for free from http://doi.org/10.5281/zenodo.3997216.





The environment

------------

An Improved Method of the Globally Resolved Energy Balance Model by the Bayes Network was tested in Windows 10 Professional Workstation Edition (CPU: R7 5800X; Memory: 64GB) using MATLAB R2021a environment.



Before running the experiment code, add the corresponding library (function) to the path and modify the corresponding file path.



Test

------------

Open Fig2.m, Fig3.m, Fig4.m, Fig5.m, Fig6.m, Fig7.m and run according to the data and instructions

Since the higher version of MATLAB cannot use the relative address, the address of the data in the code needs to be changed to the absolute address

Explanation:

%Adaptive_HGFDR function is the main part of adaptive-HGFDR algorithm in this paper.

This code can realize the compression of climate model data.

The input "data" to this function is the input climate model data.

The % function input "error" is the compression error of the climate model data you set.

The input data of % function "P_i1", "P_J1", "P_k1" is the size of each data block in X, y, Z dimension during data partition.

The output data of % function "BOT", "err", "com_ratio", "time", "error_std" and "error_x" are the decompressed data of X, compression error, compression ratio, compression time, standard deviation dimension slice error and X-dimension slice error