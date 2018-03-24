% Auto-generated by cameraCalibrator app on 24-Mar-2018
%-------------------------------------------------------


% Define images to process
imageFileNames = {'/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_1.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_2.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_3.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_4.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_13.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_14.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_15.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_16.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_17.JPG',...
    '/Users/Andrew/Dropbox/Northeastern/2018 Spring/eece5698/lab4/calibration_images/camera_calib_18.JPG',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Generate world coordinates of the corners of the squares
squareSize = 28;  % in units of 'mm'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'mm', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', []);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams, 'BarGraph');

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
originalImage = imread(imageFileNames{1});
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
