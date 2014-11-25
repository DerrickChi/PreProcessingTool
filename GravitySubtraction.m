function varargout = GravitySubtraction(varargin)
% GRAVITYSUBTRACTION MATLAB code for GravitySubtraction.fig
%      GRAVITYSUBTRACTION, by itself, creates a new GRAVITYSUBTRACTION or raises the existing
%      singleton*.
%
%      H = GRAVITYSUBTRACTION returns the handle to a new GRAVITYSUBTRACTION or the handle to
%      the existing singleton*.
%
%      GRAVITYSUBTRACTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAVITYSUBTRACTION.M with the given input arguments.
%
%      GRAVITYSUBTRACTION('Property','Value',...) creates a new GRAVITYSUBTRACTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GravitySubtraction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GravitySubtraction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GravitySubtraction

% Last Modified by GUIDE v2.5 02-Nov-2014 23:13:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GravitySubtraction_OpeningFcn, ...
                   'gui_OutputFcn',  @GravitySubtraction_OutputFcn, ...
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


% --- Executes just before GravitySubtraction is made visible.
function GravitySubtraction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GravitySubtraction (see VARARGIN)

% Choose default command line output for GravitySubtraction
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GravitySubtraction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GravitySubtraction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile('*.mat;*.MAT','Select the MAT-file');
if(length(FileName) < 2)
    return;
end
handles.MATPath = PathName;
handles.MATFile = FileName;

% Update handles structure
guidata(hObject, handles);

load([PathName FileName],'data')
handles.MATdata = data;

% Update handles structure
guidata(hObject, handles);

fields = fieldnames(data);
index = zeros(length(fields),1);

for i = 1:length(fields)
    field = char(fields{i});
    index(i) = DetermineInitialWinodw(data.(field)(:,1:3));
end
index1 = min(index);

sensorNames = fieldnames(data);

if sum(strcmp(fields, sensorNames(1))) > 0
    cla(handles.axes1);
    plot(handles.axes1, data.(char(sensorNames(1)))(:,1:3));
    hold(handles.axes1, 'on');
    plot(handles.axes1, [index1 index1], get(handles.axes1, 'YLim'), '--k');
    hold(handles.axes1, 'off');
    
    cla(handles.axes3);
    plot(handles.axes3, data.(char(sensorNames(1)))(:,7:10));
    hold(handles.axes3, 'on');
    plot(handles.axes3, [index1 index1], get(handles.axes3, 'YLim'), '--k');
    hold(handles.axes3, 'off');
    set(handles.sensor1,'String',sensorNames(1)); 
end

if length(sensorNames)>1
    
    if sum(strcmp(fields, sensorNames(2))) > 0
        cla(handles.axes2);
        plot(handles.axes2, data.(char(sensorNames(2)))(:,1:3));
        hold(handles.axes2, 'on');
        plot(handles.axes2, [index1 index1], get(handles.axes2, 'YLim'), '--k');
        hold(handles.axes2, 'off');
        
        cla(handles.axes4);
        plot(handles.axes4, data.(char(sensorNames(2)))(:,7:10));
        hold(handles.axes4, 'on');
        plot(handles.axes4, [index1 index1], get(handles.axes4, 'YLim'), '--k');
        hold(handles.axes4, 'off');
        set(handles.sensor2,'String',sensorNames(2));
    end
end

% if sum(strcmp(fields, 'sensor1')) > 0
%     cla(handles.axes1);
%     plot(handles.axes1, data.sensor1(:,1:3));
%     hold(handles.axes1, 'on');
%     plot(handles.axes1, [index1 index1], get(handles.axes1, 'YLim'), '--k');
%     hold(handles.axes1, 'off');
%     
%     cla(handles.axes3);
%     plot(handles.axes3, data.sensor1(:,7:10));
%     hold(handles.axes3, 'on');
%     plot(handles.axes3, [index1 index1], get(handles.axes3, 'YLim'), '--k');
%     hold(handles.axes3, 'off');
% end
% 
% if sum(strcmp(fields, 'sensor2')) > 0
%     cla(handles.axes2);
%     plot(handles.axes2, data.sensor2(:,1:3));
%     hold(handles.axes2, 'on');
%     plot(handles.axes2, [index1 index1], get(handles.axes2, 'YLim'), '--k');
%     hold(handles.axes2, 'off');
%     
%     cla(handles.axes4);
%     plot(handles.axes4, data.sensor2(:,7:10));
%     hold(handles.axes4, 'on');
%     plot(handles.axes4, [index1 index1], get(handles.axes4, 'YLim'), '--k');
%     hold(handles.axes4, 'off');
% end

set(handles.matfilename,'String',[PathName FileName]);
set(handles.windowlength,'String',num2str(index1));


% --- Executes on button press in subtractgravity.
function subtractgravity_Callback(hObject, eventdata, handles)
% hObject    handle to subtractgravity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

wlen = str2num(get(handles.windowlength,'String'));
data = handles.MATdata;

fields = fieldnames(data);
for i = 1:length(fields)
    field = char(fields{i});
    [acc_ref.(field) acc.(field) acc_energy.(field)] = preprocess(data.(field), wlen);
end

% save aligned data
save([handles.MATPath, 'motion_acceleration.mat'],'acc_ref', 'acc', 'acc_energy');
msgbox([handles.MATPath, 'motion_acceleration.mat has been successfully generated!']);

sensorNames = fieldnames(data);
if sum(strcmp(fields, sensorNames(1))) > 0
    cla(handles.axes5);
    plot(handles.axes5, acc.(char(sensorNames(1))));
end

if length(sensorNames)>1
    if sum(strcmp(fields, sensorNames(2))) > 0
        cla(handles.axes6);
        plot(handles.axes6, acc.(char(sensorNames(2))));
    end
end

% if sum(strcmp(fields, 'sensor1')) > 0
%     cla(handles.axes5);
%     plot(handles.axes5, acc.sensor1);
% end
% 
% if sum(strcmp(fields, 'sensor2')) > 0
% cla(handles.axes6);
% plot(handles.axes6, acc.sensor2);
% end

% Update handles structure
guidata(hObject, handles);


function windowlength_Callback(hObject, eventdata, handles)
% hObject    handle to windowlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowlength as text
%        str2double(get(hObject,'String')) returns contents of windowlength as a double


% --- Executes during object creation, after setting all properties.
function windowlength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in updatewindowlength.
function updatewindowlength_Callback(hObject, eventdata, handles)
% hObject    handle to updatewindowlength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = handles.MATdata;
fields = fieldnames(data);
wlen = str2num(get(handles.windowlength,'String'));
index1 = wlen;


sensorNames = fieldnames(data);

if sum(strcmp(fields, sensorNames(1))) > 0
    cla(handles.axes1);
    plot(handles.axes1, data.(char(sensorNames(1)))(:,1:3));
    hold(handles.axes1, 'on');
    plot(handles.axes1, [index1 index1], get(handles.axes1, 'YLim'), '--k');
    hold(handles.axes1, 'off');
    
    cla(handles.axes3);
    plot(handles.axes3, data.(char(sensorNames(1)))(:,7:10));
    hold(handles.axes3, 'on');
    plot(handles.axes3, [index1 index1], get(handles.axes3, 'YLim'), '--k');
    hold(handles.axes3, 'off');
end

if length(sensorNames)>1
    if sum(strcmp(fields, sensorNames(2))) > 0
        cla(handles.axes2);
        plot(handles.axes2, data.(char(sensorNames(2)))(:,1:3));
        hold(handles.axes2, 'on');
        plot(handles.axes2, [index1 index1], get(handles.axes2, 'YLim'), '--k');
        hold(handles.axes2, 'off');
        
        cla(handles.axes4);
        plot(handles.axes4, data.(char(sensorNames(2)))(:,7:10));
        hold(handles.axes4, 'on');
        plot(handles.axes4, [index1 index1], get(handles.axes4, 'YLim'), '--k');
        hold(handles.axes4, 'off');
    end
end

% if sum(strcmp(fields, 'sensor1')) > 0
%     cla(handles.axes1);
%     plot(handles.axes1, data.sensor1(:,1:3));
%     hold(handles.axes1, 'on');
%     plot(handles.axes1, [index1 index1], get(handles.axes1, 'YLim'), '--k');
%     hold(handles.axes1, 'off');
%     
%     cla(handles.axes3);
%     plot(handles.axes3, data.sensor1(:,7:10));
%     hold(handles.axes3, 'on');
%     plot(handles.axes3, [index1 index1], get(handles.axes3, 'YLim'), '--k');
%     hold(handles.axes3, 'off');
% end
% 
% if sum(strcmp(fields, 'sensor2')) > 0
%     cla(handles.axes2);
%     plot(handles.axes2, data.sensor2(:,1:3));
%     hold(handles.axes2, 'on');
%     plot(handles.axes2, [index1 index1], get(handles.axes2, 'YLim'), '--k');
%     hold(handles.axes2, 'off');
%     
%     cla(handles.axes4);
%     plot(handles.axes4, data.sensor2(:,7:10));
%     hold(handles.axes4, 'on');
%     plot(handles.axes4, [index1 index1], get(handles.axes4, 'YLim'), '--k');
%     hold(handles.axes4, 'off');
% end
