function varargout = kmeans_gui(varargin)
% KMEANS_GUI MATLAB code for kmeans_gui.fig
%      KMEANS_GUI, by itself, creates a new KMEANS_GUI or raises the existing
%      singleton*.
%
%      H = KMEANS_GUI returns the handle to a new KMEANS_GUI or the handle to
%      the existing singleton*.
%
%      KMEANS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KMEANS_GUI.M with the given input arguments.
%
%      KMEANS_GUI('Property','Value',...) creates a new KMEANS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kmeans_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kmeans_gui_OpeningFcn via varargin.
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kmeans_gui

% Last Modified by GUIDE v2.5 27-Jul-2021 13:23:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kmeans_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @kmeans_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before kmeans_gui is made visible.
function kmeans_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for kmeans_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kmeans_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = kmeans_gui_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% Generate Data button callback
rng(0); % For reproducibility
num_samples = 300;
num_clusters = 4;
cluster_std = 0.60;

% Generate random data using 'mvnrnd' function
mu = [1 1; 5 5; 9 1; 3 7]; % Cluster centers
sigma = cat(3, cluster_std * eye(2), cluster_std * eye(2), cluster_std * eye(2), cluster_std * eye(2));
X = [];
for i = 1:num_clusters
    X = [X; mvnrnd(mu(i, :), sigma(:, :, i), num_samples / num_clusters)];
end

% Store generated data in handles
handles.X = X;
guidata(hObject, handles);

% Display message
msgbox('Data generated successfully.');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% Apply K-means button callback
if ~isfield(handles, 'X')
    msgbox('Please generate data first.');
    return;
end

X = handles.X;
num_clusters = 4;

% Apply K-means with k=4
[idx, centroids] = kmeans(X, num_clusters);

% Visualize the data and centroids
axes(handles.axes1); % Set the current axes to axes1
cla; % Clear the current axes
gscatter(X(:, 1), X(:, 2), idx, 'bgmr', 'o', 8);
hold on;
plot(centroids(:, 1), centroids(:, 2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
title('K-means Clustering Ejemplo');
xlabel('Temperaura');
ylabel('humedad');
legend('Temp = 25°C,Hum = 70%', 'Temp = 25°C,Hum = 30%', 'Temp = 10°C,Hum = 70%', 'Temp = 10°C,Hum = 30%', 'Centroides', 'Location', 'Best');
hold off;
