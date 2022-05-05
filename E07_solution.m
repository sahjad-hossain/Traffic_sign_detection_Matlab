clear all;
close all;
clc;



%% Task a: FAST,SURF,HoG

I = imread('lena.bmp');

% %FAST
% corners = detectFASTFeatures(I);
% imshow(I); hold on;
% plot(corners.selectStrongest(50)); 
% hold off;
% 
% %SURF
% points = detectSURFFeatures(I);
% figure; imshow(I); hold on;
% plot(points.selectStrongest(10));
% hold off;
% 
% %HoG
% [featureVector, hogVisualization] = extractHOGFeatures(I);
% figure;
% imshow(I); hold on;
% plot(hogVisualization);
% hold off;


















%% Task b: Test Detector

% bodyDetector = vision.CascadeObjectDetector('UpperBody'); 
% % bodyDetector.MinSize = [80 80];
% % bodyDetector.ScaleFactor = 1.05;
% 
% I = imread('lena.bmp');
% bboxBody = step(bodyDetector, I);
% 
% IBody = insertObjectAnnotation(I, 'rectangle',bboxBody,'UpperBody');
% figure, imshow(IBody), title('Detected Faces');
% 
% I2 = imread('gruppenfoto.jpg');
% bboxBody = step(bodyDetector, I2);
% 
% IBody = insertObjectAnnotation(I2, 'rectangle',bboxBody,'UpperBody');
% figure, imshow(IBody), title('Detected Faces');
















%% Task c: Train Detector

%Training the stop sign dtetector
load('stopSignsAndCars.mat');
positiveInstances = stopSignsAndCars(:,1:2);
imDir = fullfile(matlabroot, 'toolbox', 'vision', 'visiondata','stopSignImages');
addpath(imDir);

% negativeFolder = fullfile(matlabroot, 'toolbox', 'vision','visiondata', 'non_Stop_Signs');
negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata',...
    'nonStopSigns');
negativeImages = imageDatastore(negativeFolder);

trainCascadeObjectDetector('stopSignDetector.xml', positiveInstances, negativeFolder, 'FalseAlarmRate', 0.1, 'NumCascadeStages', 5);
rmpath(imDir);

%test the detector
detector = vision.CascadeObjectDetector('stopSignDetector.xml');
img = imread('stopsigntest2.jpg');
bbox = step(detector, img);
detectedImg = insertObjectAnnotation(img, 'rectangle', bbox, 'stop sign');
figure; imshow(detectedImg);


