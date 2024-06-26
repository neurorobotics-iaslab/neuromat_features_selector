# NEUROMAT | Features Selector Package

This package provides a MATLAB user interface to select features in a BMI processing pipeline.

**FeaturesSelector** Launcher for the features selection user interface

```OUTPUT = FeaturesSelector(DATA, CLASSES, RUNS)``` creates an user interface for features selection. ```DATA``` is a 3D array [S x N x M] where the first dimension S represents the observations, N and M two features dimensions. ```CLASSES``` and ```RUNS``` are 1-dimension vector with same length of S representing the class labels and the run labels for each observation, respectively.
    
The user interface is composed by a top panel with the discriminancy of the ```DATA``` computed with respect the ```CLASSES``` for each ```RUN``` separetely. By default, the discriminancy is computed with CVA algorithm. In the bottom panel, the left map represents the discriminancy for all ```DATA```. User can select features in this map and they will appear in the next map. Concurrently, in the last plot the projection of the selected features in the canonical space is shown.
 
Once the interface is closed, the index of the selected features are returned in the ```OUTPUT``` structure. Notice that index refer to the linear combination of the two input dimensions of ```DATA```. To determine the index of each feature dimension, please use ```ind2sub``` function. Furthermore, in the ```OUTPUT``` structure are also stored the indexes of the runs included in the analysis.

```OUTPUT = FeaturesSelector(..., 'PropertyName', PropertyValue)``` sets the properties of the user interface. In particular, it is possible to set the following properties:
  - ```'XLabel'```: The name for the x-axis of the maps (default: 'Index')
  - ```'YLabel'```: The name for the y-axis of the maps (default: 'Index')
  - ```'XTickLabel'```: The x-tick labels of the maps (default: 1:size(DATA, 2))
  - ```'YTickLabel'```: The y-tick labels of the maps (default: 1:size(DATA, 3))
  - ```'Method'```: Function handle to compute the discriminancy. The method must have the following signature: ```[dp, tf] = method(data, labels)``` where data is [OBSERVATION x FEATURES] and labels is 1-dimension  vector with the class for each observation. The method must return the discriminancy dp and the projection tf into the canonical space
  - ```'UserData'```: The indexes of the selected feaures and of the included runs.

To use the interface within a script, launch it throught the function ```FeaturesSelector```
    
See also ```neuromat.ui.UIFeaturesSelector```, ```ind2sub```
