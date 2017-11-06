%Author: Jannic Holzer
%Date: 20/09/2017

% Copyright University of Southampton 2017.
% No warranty either expressed or implied is given to the results produced 
% by this software.  Neither the University, students or its employees 
%accept any responsibility for use of or reliance on results produced by 
%this software.

function varargout = FrontEndUI(varargin)
% FRONTENDUI MATLAB code for FrontEndUI.fig
%      FRONTENDUI, by itself, creates a new FRONTENDUI or raises the existing
%      singleton*.
%
%      H = FRONTENDUI returns the handle to a new FRONTENDUI or the handle to
%      the existing singleton*.
%
%      FRONTENDUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRONTENDUI.M with the given input arguments.
%
%      FRONTENDUI('Property','Value',...) creates a new FRONTENDUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FrontEndUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FrontEndUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FrontEndUI

% Last Modified by GUIDE v2.5 15-Oct-2017 20:42:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FrontEndUI_OpeningFcn, ...
    'gui_OutputFcn',  @FrontEndUI_OutputFcn, ...
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


% --- Executes just before FrontEndUI is made visible.
function FrontEndUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FrontEndUI (see VARARGIN)

% Choose default command line output for FrontEndUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Write default MATLAB path based on OS
if strcmp(computer, 'PCWIN64')
    handles.edit4.String = 'C:\Program Files\REFPROP'
elseif strcmp(computer, 'PCWIN32')
    handles.edit4.String = 'C:\Program Files (x86)\REFPROP'
end

% UIWAIT makes FrontEndUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FrontEndUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lbxFilePaths.
function lbxFilePaths_Callback(hObject, eventdata, handles)
% hObject    handle to lbxFilePaths (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbxFilePaths contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbxFilePaths


% --- Executes during object creation, after setting all properties.
function lbxFilePaths_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbxFilePaths (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.dat'})
% inputFileNames = get(handles.lbxFilePaths, 'String');

% Define arrays for holding input file names and paths if first addition.
if isempty(handles.pushbutton1.UserData) == 1
    inputFileNames = []
    inputPathNames = []
    blnOneZoneArray = []
else
    inputFileNames = handles.pushbutton1.UserData(:,1)
    blnOneZoneArray = handles.pushbutton1.UserData(:,2)
    inputPathNames = handles.pushbutton1.UserData(:,3)
end

%
if FileName ~= 0
    inputFileNames = [inputFileNames; {FileName}];
    inputPathNames = [inputPathNames; {PathName}];
    
    blnOneZone = handles.checkbox3.Value
    blnOneZoneArray = [blnOneZoneArray; {blnOneZone}]
    
    lbxEntries = inputFileNames
    for idx = 1:numel(inputFileNames)
        if blnOneZoneArray{idx} == 1
            lbxEntries(idx) = strcat(lbxEntries(idx), ' (One Zone)')
        end
    end
    set(handles.lbxFilePaths,'String',lbxEntries)
end

% Generates array of user defined data relating to config files and assigns
% it to the uicontrol userdata ready for access in pushbutton3 callback
handles.pushbutton1.UserData = [inputFileNames, blnOneZoneArray, inputPathNames]

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback (hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NewInputFile


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

blnUseStandardData = handles.checkbox1.Value

if blnUseStandardData == 0
    PressureDataFile = handles.pushbutton5.UserData
    TempDataFile = handles.pushbutton6.UserData
else
    PressureDataFile = []
    TempDataFile = []
end

pushbutton1data = handles.pushbutton1.UserData
inputFileNames = pushbutton1data(:,1)
blnOneZoneArray = pushbutton1data(:,2)
inputPathNames = pushbutton1data(:,3)

OutputFileName = handles.edit1.String(find(~isspace(handles.edit1.String)))
OutputFolder = handles.edit2.String

refpropdir = handles.edit4.String

ConstTempC = str2num(handles.edit5.String)
ConstPressBar = str2num(handles.edit6.String)

ConstTempK = ConstTempC + 273.15
ConstPressKPa = ConstPressBar * 100

% Generate struct of userdata to pass to the main function
PassData = {inputFileNames, inputPathNames, blnUseStandardData, PressureDataFile, ...
        TempDataFile, blnOneZoneArray, OutputFileName, OutputFolder, refpropdir, ConstTempK, ConstPressKPa}

set(0, 'userdata', PassData)

% Close the front end UI
close(FrontEndUI);

% Call the main function
LuxferTPSMainRoutine

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputFileNames = handles.pushbutton1.UserData
PosToRemove = handles.lbxFilePaths.Value
inputFileNames(PosToRemove, :) = []
handles.pushbutton1.UserData = inputFileNames

ConfigFiles = get(handles.lbxFilePaths, 'String')
ConfigFiles(PosToRemove) = []
set(handles.lbxFilePaths, 'String', ConfigFiles)
set(handles.lbxFilePaths, 'Value', 1)

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
blnUseStandardData = get(handles.checkbox1, 'Value')
handles.checkbox1.UserData = blnUseStandardData
if blnUseStandardData == 1
    set(handles.pushbutton5, 'Enable', 'off')
    set(handles.pushbutton6, 'Enable', 'off')
    
    set(handles.listbox4, 'Enable', 'off')
    set(handles.listbox4, 'String', '')
    
    set(handles.listbox5, 'Enable', 'off')
    set(handles.listbox5, 'String', '')
    
    set(handles.edit5, 'Enable', 'on')
    set(handles.edit6, 'Enable', 'on')
else
    set(handles.pushbutton5, 'Enable', 'on')
    set(handles.pushbutton6, 'Enable', 'on')
    
    set(handles.listbox4, 'Enable', 'on')
    set(handles.listbox5, 'Enable', 'on')
    
    set(handles.edit5, 'Enable', 'off')
    set(handles.edit6, 'Enable', 'off')
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[PressureDataFName, PressureDataPName] = uigetfile({'.xlsx'})
handles.pushbutton5.UserData = strcat(PressureDataPName, PressureDataFName)
set(handles.listbox4, 'String', PressureDataFName)

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[TempDataFName, TempDataPName] = uigetfile({'.xlsx'})
handles.pushbutton6.UserData = strcat(TempDataPName, TempDataFName)
set(handles.listbox5, 'String', TempDataFName)


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OutputFolder = uigetdir
handles.edit2.String = strcat(OutputFolder, '\')



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.edit4.String = uigetdir



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
