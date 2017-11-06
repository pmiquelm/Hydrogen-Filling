%Author: Jannic Holzer
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

function varargout = OutputUI(varargin)
% OUTPUTUI MATLAB code for OutputUI.fig
%      OUTPUTUI, by itself, creates a new OUTPUTUI or raises the existing
%      singleton*.
%
%      H = OUTPUTUI returns the handle to a new OUTPUTUI or the handle to
%      the existing singleton*.
%
%      OUTPUTUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OUTPUTUI.M with the given input arguments.
%
%      OUTPUTUI('Property','Value',...) creates a new OUTPUTUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OutputUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OutputUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OutputUI

% Last Modified by GUIDE v2.5 07-Sep-2017 11:12:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OutputUI_OpeningFcn, ...
                   'gui_OutputFcn',  @OutputUI_OutputFcn, ...
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


% --- Executes just before OutputUI is made visible.
function OutputUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OutputUI (see VARARGIN)

% Choose default command line output for OutputUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
PassStruct = get(0, 'userdata')
tank_number = PassStruct{1};
time = PassStruct{2};
Temp_gas = PassStruct{3};
plotStyle = PassStruct{4};
inputFileNames = PassStruct{5};
maxt = PassStruct{6};
mfr = PassStruct{7};
blnOneZone = PassStruct{8};
Temp_wall = PassStruct{9};
int_pt_liner_laminate = PassStruct{10};

for i=1:tank_number
    
    axes(handles.axes1)
    plot(time,Temp_gas(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 14)
    ylabel('Cylinder gas temperature (°C)', 'fontsize', 14)
    if blnOneZone{i} == 1
        legendInfo{i} = [strcat(inputFileNames{i}(1:end-4), ' (One Zone)')]
    else
        legendInfo{i} = [inputFileNames{i}(1:end-4)]
    end
    legend(legendInfo, 'Location', 'southeast')
end

for i=1:tank_number
    
    axes(handles.axes5)
    plot(time,mfr(i,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    hold on
    xlabel('Time (s)', 'fontsize', 14)
    ylabel('Mass flow rate (kg/s)', 'fontsize', 14)
    legend(legendInfo, 'Location', 'northeast')
    
end

for i=1:tank_number

    axes(handles.axes6)
    if blnOneZone{i} == 1
        plot(time,Temp_wall{i}(1,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    else
        plot(time,Temp_wall{i}(1,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    end
    hold on
    xlabel('Time (s)', 'fontsize', 14)
    ylabel('Max. Liner Temp.', 'fontsize', 14)
    legend(legendInfo, 'Location', 'southeast')
    
end

for i=1:tank_number
    
    axes(handles.axes7)
    if blnOneZone{i} == 1
        plot(time, Temp_wall{i}(int_pt_liner_laminate(1) + 1,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    else
        plot(time, Temp_wall{i}(int_pt_liner_laminate(1) + 1,1:maxt+1), plotStyle{i}, 'linewidth', 2)
    end
    hold on
    xlabel('Time (s)', 'fontsize', 14)
    ylabel('Max. Laminate Temp.', 'fontsize', 14)
    legend(legendInfo, 'Location', 'southeast')
    
end
% UIWAIT makes OutputUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OutputUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
