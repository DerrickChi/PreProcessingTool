function varargout = AlignWindow(varargin)
% ALIGNWINDOW MATLAB code for AlignWindow.fig
%      ALIGNWINDOW, by itself, creates a new ALIGNWINDOW or raises the existing
%      singleton*.
%
%      H = ALIGNWINDOW returns the handle to a new ALIGNWINDOW or the handle to
%      the existing singleton*.
%
%      ALIGNWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALIGNWINDOW.M with the given input arguments.
%
%      ALIGNWINDOW('Property','Value',...) creates a new ALIGNWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AlignWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AlignWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AlignWindow

% Last Modified by GUIDE v2.5 19-Jul-2013 12:11:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AlignWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @AlignWindow_OutputFcn, ...
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


% --- Executes just before AlignWindow is made visible.
function AlignWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlignWindow (see VARARGIN)

% Choose default command line output for AlignWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = AlignWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in matfilename.
function matfilename_Callback(hObject, eventdata, handles)
% hObject    handle to matfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns matfilename contents as cell array
%        contents{get(hObject,'Value')} returns selected item from matfilename


% --- Executes during object creation, after setting all properties.
function matfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to matfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
load([PathName FileName],'data');
handles.MATdata = data;

% Update handles structure
guidata(hObject, handles);

sensorNames = fieldnames(data);
cla(handles.dataplot);
for i = 1:length(sensorNames)
    hold(handles.dataplot,'on');
    plot(handles.dataplot, data.(sensorNames{i})(:,1:3));
end
set(handles.matfilename,'String',[PathName FileName]);
allSensors = sensorNames;
if length(allSensors) > 1
    allSensors = ['Both'; allSensors];
end
set(handles.plotoption,'String', allSensors);
set(handles.filelist,'String',{});


% --- Executes on selection change in plotoption.
function plotoption_Callback(hObject, eventdata, handles)
% hObject    handle to plotoption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plotoption contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plotoption

cla(handles.dataplot);
hold(handles.dataplot,'on');

visibleval = get(handles.plotoption,'Value');
allSensors = get(handles.plotoption,'String');

if strcmp(char(allSensors(visibleval)), 'Both')
    for i=2:length(allSensors)
    plot(handles.dataplot,handles.MATdata.(char(allSensors(i)))(:,1:3));
    end

else
    plot(handles.dataplot,handles.MATdata.(char(allSensors(visibleval)))(:,1:3));
end 

% switch char(allSensors(visibleval))
%     case 'Both'    
%         plot(handles.dataplot,handles.MATdata.LeftFoot(:,1:3));
%         plot(handles.dataplot,handles.MATdata.RightFoot(:,1:3));
%     case 'LeftFoot'
%         plot(handles.dataplot,handles.MATdata.LeftFoot(:,1:3));
%     case 'LeftCalf'
%         plot(handles.dataplot,handles.MATdata.LeftCalf(:,1:3));
%     case 'LeftForearm'
%         plot(handles.dataplot,handles.MATdata.LeftForearm(:,1:3));
%     case 'LeftUpperarm'
%         plot(handles.dataplot,handles.MATdata.LeftUpperarm(:,1:3));
%     case 'RightFoot'
%         plot(handles.dataplot,handles.MATdata.RightFoot(:,1:3));
%     case 'RightCalf'
%         plot(handles.dataplot,handles.MATdata.RightCalf(:,1:3));
%     case 'RightForearm'
%         plot(handles.dataplot,handles.MATdata.RightForearm(:,1:3));
%     case 'RightUpperarm'
%         plot(handles.dataplot,handles.MATdata.RightUpperarm(:,1:3));       
% end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function plotoption_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotoption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectalignmentpoint.
function selectalignmentpoint_Callback(hObject, eventdata, handles)
% hObject    handle to selectalignmentpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

visibleval = get(handles.plotoption,'Value');
allSensors = get(handles.plotoption,'String');
sel_sensor = allSensors{visibleval};

if strcmp(sel_sensor, 'Both') == 1
    msgbox('Error: Cannot use both to select an alignment point!');
    return;
end

count = 0;
del_mark = [];
lines = get(handles.filelist, 'String');
for j = 1:length(lines)
    sensor_num = lines{j}(1:strfind(lines{j}, '=')-1);
    if strcmp(sel_sensor, sensor_num) == 1
        count = count + 1;
        del_mark(count) = j;
        break
    end
end
lines(del_mark) = [];
set(handles.filelist, 'String', lines);
drawnow;

[x,~] = ginput(1);
x = round(x);
plot(handles.dataplot, [x,x], get(handles.dataplot, 'ylim'), 'k--');
classLine = sprintf('%s=%f', sel_sensor, x);
set(handles.filelist, 'String', [get(handles.filelist,'String');{classLine}]);
set(handles.filelist, 'Value', length(get(handles.filelist,'String')));   

guidata(hObject, handles);


% --- Executes on selection change in sensoroption.
function sensoroption_Callback(hObject, eventdata, handles)
% hObject    handle to sensoroption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sensoroption contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sensoroption


% --- Executes during object creation, after setting all properties.
function sensoroption_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensoroption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in filelist.
function filelist_Callback(hObject, eventdata, handles)
% hObject    handle to filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filelist


% --- Executes during object creation, after setting all properties.
function filelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in removeselected.
function removeselected_Callback(hObject, eventdata, handles)
% hObject    handle to removeselected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

lines = get(handles.filelist, 'String');

selection = get(handles.filelist,'Value');
trimmed = get(handles.filelist,'String');
trimmed = [reshape({trimmed{1:selection-1}},length(1:selection-1),1);reshape({trimmed{selection+1:end}},length(selection+1:length(trimmed)),1)];
set(handles.filelist,'String',trimmed);
set(handles.filelist,'Value',1);

guidata(hObject, handles);


% --- Executes on button press in alignsignal.
function alignsignal_Callback(hObject, eventdata, handles)
% hObject    handle to alignsignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

lines = get(handles.filelist,'String');
temp_num = cell(1, length(lines));
temp_ref = zeros(1, length(lines));
for i = 1:length(lines)
    temp_num{i} = lines{i}(1:strfind(lines{i}, '=')-1);
    temp_ref(i) = str2double(lines{i}(strfind(lines{i}, '=')+1:end));
end

if length(lines) < length(fieldnames(handles.MATdata))
    msgbox('Error: Alignment indexes for both sides need to be selected!');
    return;
end

set(hObject, 'Enable', 'off');
set(hObject, 'String', 'Aligning, please wait...');
drawnow;

new_pos = zeros(2,2);
for i = 1:length(temp_ref)
    new_pos(i,:) = ...
        temp_ref(i) - min(temp_ref) + [1 min(temp_ref)+size(handles.MATdata.(char(temp_num{i})), 1)-max(temp_ref)]; 
    newdata.(char(temp_num{i})) = handles.MATdata.(char(temp_num{i}))(new_pos(i,1):new_pos(i,2),:);
end
 
cla(handles.dataplot);
field = fieldnames(newdata);
for l = 1:length(field)
    hold(handles.dataplot,'on');
    plot(handles.dataplot,newdata.(char(field{l}))(:,1:3));
end
hold(handles.dataplot,'off');
zoom(handles.dataplot,'out');

handles.MATdata = newdata;
data = handles.MATdata;
handles.MATFile = ['align_', handles.MATFile];
save([handles.MATPath, handles.MATFile],'data');
msgbox([handles.MATPath, handles.MATFile, ' has been successfully generated!']);
set(handles.filelist, 'String', {});
set(hObject, 'Enable', 'on');
set(hObject, 'String', 'Align Signals');
set(handles.plotoption,'Value',1);

guidata(hObject, handles);


% --- Executes on button press in truncatesignals.
function truncatesignals_Callback(hObject, eventdata, handles)
% hObject    handle to truncatesignals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(hObject, 'Enable', 'off');
set(hObject, 'String', 'Truncating, please wait...');
drawnow;

x = get(handles.dataplot, 'xlim');
x = round(x);
data = handles.MATdata;
field = fieldnames(data);

if x(1) < 1
    x(1) = 1;
end
for i = 1:length(field)
    if x(2) > length(data.(char(field{i}))(:,1))
        x(2) = length(data.(char(field{i}))(:,1));
    end
end
for i = 1:length(field)
    newdata.(char(field{i})) =  data.(char(field{i}))(x(1):x(2),:);
end

cla(handles.dataplot);
for l = 1:length(field)
    hold(handles.dataplot,'on');
    plot(handles.dataplot,newdata.(char(field{l}))(:,1:3));
end
hold(handles.dataplot,'off');
zoom(handles.dataplot,'out');

handles.MATdata = newdata;
data = handles.MATdata;
handles.MATFile = ['truncate_', handles.MATFile];
save([handles.MATPath, handles.MATFile],'data');
msgbox([handles.MATPath, handles.MATFile, ' has been successfully generated!']);
set(hObject, 'Enable', 'on');
set(hObject, 'String', 'Truncate Signals');
set(handles.plotoption,'Value',1);

guidata(hObject, handles);
