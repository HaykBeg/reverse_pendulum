function varargout = basiq_pid_motor_gui(varargin)
% BASIQ_PID_MOTOR_GUI MATLAB code for basiq_pid_motor_gui.fig
%      BASIQ_PID_MOTOR_GUI, by itself, creates a new BASIQ_PID_MOTOR_GUI or raises the existing
%      singleton*.
%
%      H = BASIQ_PID_MOTOR_GUI returns the handle to a new BASIQ_PID_MOTOR_GUI or the handle to
%      the existing singleton*.
%
%      BASIQ_PID_MOTOR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASIQ_PID_MOTOR_GUI.M with the given input arguments.
%
%      BASIQ_PID_MOTOR_GUI('Property','Value',...) creates a new BASIQ_PID_MOTOR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before basiq_pid_motor_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to basiq_pid_motor_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help basiq_pid_motor_gui

% Last Modified by GUIDE v2.5 19-Apr-2020 20:51:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @basiq_pid_motor_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @basiq_pid_motor_gui_OutputFcn, ...
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


% --- Executes just before basiq_pid_motor_gui is made visible.
function basiq_pid_motor_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to basiq_pid_motor_gui (see VARARGIN)

% Choose default command line output for basiq_pid_motor_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes basiq_pid_motor_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = basiq_pid_motor_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveState(handles);

function saveState(handles)

state.voltage = get(handles.voltage,'value');
save main.mat state; 
