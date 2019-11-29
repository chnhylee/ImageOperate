function varargout = Test4(varargin)
% TEST4 MATLAB code for Test4.fig
%      TEST4, by itself, creates a new TEST4 or raises the existing
%      singleton*.
%
%      H = TEST4 returns the handle to a new TEST4 or the handle to
%      the existing singleton*.
%
%      TEST4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST4.M with the given input arguments.
%
%      TEST4('Property','Value',...) creates a new TEST4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Test4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Test4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Test4

% Last Modified by GUIDE v2.5 27-Nov-2019 14:06:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Test4_OpeningFcn, ...
                   'gui_OutputFcn',  @Test4_OutputFcn, ...
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


% --- Executes just before Test4 is made visible.
function Test4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Test4 (see VARARGIN)

% Choose default command line output for Test4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Test4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Test4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_Offest_X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Offest_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Offest_X as text
%        str2double(get(hObject,'String')) returns contents of edit_Offest_X as a double


% --- Executes during object creation, after setting all properties.
function edit_Offest_X_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_Offest_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbt_Offset.
function pbt_Offset_Callback(hObject, eventdata, handles)
% hObject    handle to pbt_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示平移后的图片
global image;
global image_Offest;
init = image;
[R,C] = size(init);
image_Offest = zeros(R,C);
%获取平移量X,Y
offestX = str2num(get(handles.edit_Offest_X,'string'));
offestY = str2num(get(handles.edit_Offest_Y,'string'));
%平移操作的变换矩阵
tras = [1 0 offestX;0 1 offestY;0 0 1];
for i = 1:R
    for j = 1:C
        temp = [i;j;1];
        temp = tras * temp;
        X = temp(1,1);
        Y = temp(2,1);
        %判断变换后的矩阵是否越界
        if(X<=R)&&(Y<=C)&&(X>=1)&&(Y>=1)
            image_Offest(X,Y) = init(i,j);
        end
    end
end
axes(handles.axes_Offest);
handles.axes_Offest =  imshow(image_Offest);
axis on;


function edit_Offest_Y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Offest_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Offest_Y as text
%        str2double(get(hObject,'String')) returns contents of edit_Offest_Y as a double


% --- Executes during object creation, after setting all properties.
function edit_Offest_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Offest_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbt_Import.
function pbt_Import_Callback(hObject, eventdata, handles)
% hObject    handle to pbt_Import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
[name, dir, index] = uigetfile({'*.jpg';'*.png';'*.bmp'},'打开图片');
if index == 1
    str = [dir name];
    im = imread(str);
    %RGB转换为灰度图，之后进行归一化处理
    image = im2double(rgb2gray(im));
    axes(handles.axes_Original);
    handles.axes_Original =  imshow(image);
    axis on;
end
% --- Executes on button press in pbt_Clear.
function pbt_Clear_Callback(hObject, eventdata, handles)
% hObject    handle to pbt_Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes_Original);
cla(handles.axes_Offest);
cla(handles.axes_Rotate);
cla(handles.axes_Ratio);


% --- Executes on button press in ptn_Save_Ratio.
function ptn_Save_Ratio_Callback(hObject, eventdata, handles)
% hObject    handle to ptn_Save_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_Ratio;
imwrite(image_Ratio,'image_Ratio.png');
set(handles.text_Save_Result,'string',"比例变化保存成功!");

% --- Executes on button press in ptn_Save_Rotate.
function ptn_Sav_PY_Callback(hObject, eventdata, handles)
% hObject    handle to ptn_Save_Rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ptn_Save_Rotate.
function ptn_Save_Rotate_Callback(hObject, eventdata, handles)
% hObject    handle to ptn_Save_Rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_Rotate;
imwrite(image_Rotate,'image_Rotate.png');
set(handles.text_Save_Result,'string',"旋转结果保存成功!");

% --- Executes on button press in ptn_Ratio.
function ptn_Ratio_Callback(hObject, eventdata, handles)
% hObject    handle to ptn_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_Ratio;
[R,C] = size(image); % 获取图像大小
timesX = str2num(get(handles.edit_RatioX,'string')); % X轴缩放量
timesY = str2num(get(handles.edit_RatioY,'string')); % Y轴缩放量

image_Ratio = zeros(timesX * R, timesY * C); % 构造结果矩阵。每个像素点默认初始化为0（黑色）
tras = [1/timesX 0 0; 0 1/timesY 0; 0 0 1]; % 缩放的变换矩阵 
for i = 1:timesX * R
    for j = 1:timesY * C
        temp = [i; j; 1];
        temp = tras * temp; % 矩阵乘法
        X= uint16(temp(1, 1));
        Y= uint16(temp(2, 1));
        % 变换后的位置判断是否越界
        if (X<=R)&&(Y<=C)&&(X>=1)&&(Y>=1)
            image_Ratio(i,j)=image(X,Y);
        end
    end
end
axes(handles.axes_Ratio);
handles.axes_Ratio = imshow(image_Ratio);
axis on;


function edit_RatioX_Callback(hObject, eventdata, handles)
% hObject    handle to edit_RatioX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_RatioX as text
%        str2double(get(hObject,'String')) returns contents of edit_RatioX as a double


% --- Executes during object creation, after setting all properties.
function edit_RatioX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_RatioX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbt_Rotate.
function pbt_Rotate_Callback(hObject, eventdata, handles)
% hObject    handle to pbt_Rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_Rotate;
init = image;%读取原始图像
[R,C] = size(image);%获取图像大小
image_Rotate = zeros(R,C);%构造结果矩阵，每个像素点默认为0
alfa = str2num(get(handles.edit_Rotate,'string')) * 3.1415926/180; %获取旋转角度
tras = [cos(alfa) -sin(alfa) 0; sin(alfa) cos(alfa) 0; 0 0 1 ];%旋转操作的变换矩阵
for i = 1:R
    for j = 1:C
        temp = [i;j;1];
        temp = tras * temp;%矩阵乘法
        X = uint16(temp(1,1));
        Y = uint16(temp(2,1));
        %判断是否越界
        if(X<=R)&&(Y<=C)&&(X>=1)&&(Y>=1)
            image_Rotate(i,j)=init(X,Y);
        end
    end
end
axes(handles.axes_Rotate);
handles.axes_Rotate =  imshow(image_Rotate);
axis on;




function edit_Rotate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Rotate as text
%        str2double(get(hObject,'String')) returns contents of edit_Rotate as a double


% --- Executes during object creation, after setting all properties.
function edit_Rotate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in ptn_Save_Offest.
function ptn_Save_Offest_Callback(hObject, eventdata, handles)
% hObject    handle to ptn_Save_Offest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_Offest;
imwrite(image_Offest,'image_Offest.png');
set(handles.text_Save_Result,'string',"平移结果保存成功!");



function edit_RatioY_Callback(hObject, eventdata, handles)
% hObject    handle to edit_RatioY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_RatioY as text
%        str2double(get(hObject,'String')) returns contents of edit_RatioY as a double


% --- Executes during object creation, after setting all properties.
function edit_RatioY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_RatioY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
