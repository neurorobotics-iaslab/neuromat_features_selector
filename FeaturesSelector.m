function selfeatures = FeaturesSelector(varargin)
 %FEATURESSELECTOR Launcher for the features selection user interface
    % 
    %   INDEX = FeaturesSelector(DATA, CLASSES, RUNS) creates an user
    %   interface for features selection. DATA is a 3D array [S x N x M]
    %   where the first dimension S represents the observations, N and M
    %   two features dimensions. CLASSES and RUNS are 1-dimension vector
    %   with same length of S representing the class labels and the run
    %   labels for each observation, respectively.
    %   
    %   The user interface is composed by a top panel with the
    %   discriminancy of the DATA computed with respect the CLASSES for
    %   each RUN separetely. By default, the discriminancy is computed with
    %   CVA algorithm. In the bottom panel, the left map represents
    %   the discriminancy for all DATA. User can select features in this
    %   map and they will appear in the next map. Concurrently, in the last
    %   plot the projection of the selected features in the canonical space
    %   is shown.
    %
    %   Once the interface is closed, the INDEX of the selected features
    %   are returned. Notice that INDEX refer to the linear combination of
    %   the two input dimensions of DATA. To determine the index of each
    %   feature dimension, please use ind2sub function.
    %   
    %   INDEX = UIFeaturesSelector(..., 'PropertyName', PropertyValue) sets
    %   the properties of the user interface. In particular, it is possible
    %   to set the following properties:
    %      'XLabel'           The name for the x-axis of the maps 
    %                         (default: 'Index')
    %      'YLabel'           The name for the y-axis of the maps 
    %                         (default: 'Index')
    %      'XTickLabel'       The x-tick labels of the maps 
    %                         (default: 1:size(DATA, 2))   
    %      'YTickLabel'       The y-tick labels of the maps 
    %                         (default: 1:size(DATA, 3)) 
    %      'Method'           Function handle to compute the 
    %                         discriminancy. The method must have     
    %                         the following signature:               
    %                         [dp, tf] = method(data, labels)     
    %                         where data is [OBSERVATION x 
    %                         FEATURES] and labels is 1-dimension  
    %                         vector with the class for each 
    %                         observation. The method must return 
    %                         the discriminancy dp and the 
    %                         projection tf into the canonical 
    %                         space 
    %      'SelectedFeatures' The feaures currently selected in 
    %                         the interface
    %   
    %   To use the interface within a script, launch it throught the
    %   function FeaturesSelector
    %   
    %   See also neuromat.ui.UIFEATURESSELECTOR, IND2SUB
    app = neuromat.ui.UIFeaturesSelector(varargin{:});

    waitfor(app, 'IsClosed', true);
    if(isvalid(app))
        selfeatures = app.SelectedFeatures;
    end

    delete(app);
end