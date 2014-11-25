function varargout = MergeWindow(varargin)
% MERGEWINDOW MATLAB code for MergeWindow.fig
%      MERGEWINDOW, by itself, creates a new MERGEWINDOW or raises the existing
%      singleton*.
%
%      H = MERGEWINDOW returns the handle to a new MERGEWINDOW or the handle to
%      the existing singleton*.
%
%      MERGEWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MERGEWINDOW.M with the given input arguments.
%
%      MERGEWINDOW('Property','Value',...) creates a new MERGEWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MergeWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MergeWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MergeWindow

% Last Modified by GUIDE v2.5 17-Jul-2013 23:05:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MergeWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @MergeWindow_OutputFcn, ...
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


% --- Executes just before MergeWindow is made visible.
function MergeWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MergeWindow (see VARARGIN)

% Choose default command line output for MergeWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = MergeWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in adddatafromfile.
function adddatafromfile_Callback(hObject, eventdata, handles)
% hObject    handle to adddatafromfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

codepath = cd;
[FileNames,PathName] = uigetfile('*.txt;*.TXT','Select the TXT-file','MultiSelect','off');
handles.MATpath = PathName;
addpath(codepath);
cd(PathName);

% if ispc
%     cd('toolboxes/Merge Tool');
%     if iscell(FileNames)
%         count = 0;
%         FileName_temp = cell(0);
%         for i = 1:length(FileNames)
%             if isempty(strfind(FileNames{i}, '-CLEAN'))
%                 count = count + 1;
%                 modified by Jay on 11/17/11
%                 change the extension of "ParseData.exe" to skip the test
%                 of gmail server
%                 if exist('ParseData.mm', 'file')
%                     movefile('ParseData.mm', 'ParseData.exe');
%                 end
%                 system(['ParseData "', PathName, FileNames{i}, '"']);
%                 movefile('ParseData.exe', 'ParseData.mm');
%                 [~, temp] = fileparts([PathName, FileNames{i}]);
%                 if exist([PathName, temp, '-CLEAN.csv'], 'file')
%                     set(handles.Text_status, 'String', [PathName, FileNames{i}, ' is corrupted, use ', PathName, temp, '-CLEAN.csv instead']);
%                     drawnow
%                     FileName_temp{count} = [temp, '-CLEAN.csv'];
%                 else
%                     FileName_temp{count} = FileNames{i};
%                 end
%             end
%         end
%         FileNames = FileName_temp;
%     else
%         if isempty(strfind(FileNames, '-CLEAN'))
%             % change the extension of "ParseData.exe" to skip the test
%             % of gmail server
%             if exist('ParseData.mm', 'file')
%                 movefile('ParseData.mm', 'ParseData.exe');
%             end
%             system(['ParseData "', PathName, FileNames, '"']);
%             movefile('ParseData.exe', 'ParseData.mm');
%             
%             [~, temp] = fileparts([PathName, FileNames]);
%             if exist([PathName, temp, '-CLEAN.csv'], 'file')
%                 set(handles.Text_status, 'String', [PathName, FileNames, ' is corrupted, use', PathName, temp, '-CLEAN.csv instead']);
%                 FileNames = [temp, '-CLEAN.csv'];
%             end
%         end
%     end
%     cd ..
%     cd ..   
% end

if(length(FileNames) > 1)
    file = {[PathName FileNames]};
end
set(handles.filelist,'String',file);

guidata(hObject, handles);


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


% --- Executes on selection change in addedfilelist.
function addedfilelist_Callback(hObject, eventdata, handles)
% hObject    handle to addedfilelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns addedfilelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from addedfilelist


% --- Executes during object creation, after setting all properties.
function addedfilelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to addedfilelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in adddatafromfolder.
function adddatafromfolder_Callback(hObject, eventdata, handles)
% hObject    handle to adddatafromfolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in addtodataset.
function addtodataset_Callback(hObject, eventdata, handles)
% hObject    handle to addtodataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sensorName = get(handles.nameoption,'String');
val = get(handles.nameoption, 'Value');

if(isfield(handles,'merge'))
    merge = handles.merge;
    fields = fieldnames(merge);
    if sum(strcmp(fields, sensorName{val})) > 0
        msgbox('Error: This side has alraedy been added!');
        return;
    end
end

field = char(sensorName{val});
file = get(handles.filelist,'String');
merge.(field) = file;
handles.merge = merge;
    
guidata(hObject, handles);

fields = fieldnames(merge);
totalFiles = {};
for i = 1:length(fields)
    field = char(fields{i});
    totalFiles{end+1} = [field ': ' char(merge.(field))];
end
set(handles.addedfilelist,'String',totalFiles);


% --- Executes on button press in removeselectedfile.
function removeselectedfile_Callback(hObject, eventdata, handles)
% hObject    handle to removeselectedfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

allStrings = get(handles.addedfilelist,'String');
selection = get(handles.addedfilelist,'Value');
if isempty(allStrings)
    return;
elseif isempty(selection)
    msgbox('Error: No file has been selected!');
    return;
end

if(~isempty(selection) && sum(selection) > 0)
    merge = handles.merge;
    fields = fieldnames(merge);
    for l=1:length(selection)
        [sensorName,rem] = strtok(allStrings{selection(l)},': ');
        for i = 1:length(fields)
            if strcmp(fields{i}, sensorName) == 1
                merge = rmfield(merge, sensorName);
            end
        end
    end
    handles.merge = merge;
    
    guidata(hObject, handles);
        
    fields = fieldnames(merge);
    totalFiles = {};
    for i = 1:length(fields)
        field = char(fields{i});
        totalFiles{end+1} = [field ': ' char(merge.(field))];
    end
    set(handles.addedfilelist,'Value',1);
    set(handles.addedfilelist,'String',totalFiles);
end


% --- Executes on button press in mergedata.
function mergedata_Callback(hObject, eventdata, handles)
% hObject    handle to mergedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(~isfield(handles,'merge'))
    msgbox('Error: No file has been added!');
    return;
end
set(handles.mergedata,'String','Processing...Please Wait');
set(handles.mergedata,'Enable','off');
drawnow;
% pause(0.1);

merge = handles.merge;
fields = fieldnames(merge);
for i = 1:length(fields)
    field = char(fields{i});
    data.(field) = ReadData(char(merge.(field)));
    if isempty(data.(field))
        msgbox(['Data file of ' field ' is empty!']);
        data = rmfield(data,field);
    end
end

% if ispc
%     idx = strfind(path, '\');
% else
%     idx = strfind(path, '/');
% end
    
[FileName,PathName] = uiputfile('*.mat;*.MAT','Select the MAT-file');
if FileName == 0
    set(handles.mergedata,'String','Merge data');
    set(handles.mergedata,'Enable','on');
    return;
else
    save([PathName FileName], 'data');
    uiwait(msgbox([PathName FileName, ' has been successfully generated!']));
    close(gcbf);
end


% --- Executes on selection change in nameoption.
function nameoption_Callback(hObject, eventdata, handles)
% hObject    handle to nameoption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns nameoption contents as cell array
%        contents{get(hObject,'Value')} returns selected item from nameoption


% --- Executes during object creation, after setting all properties.
function nameoption_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nameoption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
