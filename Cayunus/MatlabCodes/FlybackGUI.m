function varargout = FlybackGUI(varargin)
% FLYBACKGUI MATLAB code for FlybackGUI.fig
%      FLYBACKGUI, by itself, creates a new FLYBACKGUI or raises the existing
%      singleton*.
%
%      H = FLYBACKGUI returns the handle to a new FLYBACKGUI or the handle to
%      the existing singleton*.
%
%      FLYBACKGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLYBACKGUI.M with the given input arguments.
%
%      FLYBACKGUI('Property','Value',...) creates a new FLYBACKGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FlybackGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FlybackGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FlybackGUI

% Last Modified by GUIDE v2.5 30-Apr-2021 04:58:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FlybackGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FlybackGUI_OutputFcn, ...
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


% --- Executes just before FlybackGUI is made visible.
function FlybackGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FlybackGUI (see VARARGIN)

% Choose default command line output for FlybackGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FlybackGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% ---------Initialization---------
%Slider Init
Slider_LmVal = get(handles.Slider_Lm,'Value');
set(handles.Text_SliderLm,'String',Slider_LmVal*1000);
%set(handles.Text_SliderLm,'String',get(handles.Slider_Lm,'Value'));
assignin('base','Slider_LmVal',Slider_LmVal);

set(handles.Text_SliderTurnsRatio,'String',get(handles.Slider_TurnsRatio,'Value'));
Slider_TurnsRatioVal = get(handles.Slider_TurnsRatio,'Value');
assignin('base','Slider_TurnsRatioVal',Slider_TurnsRatioVal);

set(handles.Text_Sliderfs,'String',get(handles.Slider_fs,'Value'));
Slider_fsVal = get(handles.Slider_fs,'Value');
assignin('base','Slider_fsVal',Slider_fsVal);

set(handles.Text_SliderPout,'String',get(handles.Slider_Pout,'Value'));
Slider_PoutVal = get(handles.Slider_Pout,'Value');
assignin('base','Slider_PoutVal',Slider_PoutVal);
%Input-Output Init -----------------------------
set(handles.Edit_Vo,'String',12);
assignin('base','Edit_VoVal',12);
set(handles.Edit_InMin,'String',220);
assignin('base','Edit_InMinVal',220);
set(handles.Edit_InMax,'String',400);
assignin('base','Edit_InMaxVal',400);

%Core Selection
assignin('base','u0',4*pi*1e-7);
% --- Outputs from this function are returned to the command line.
function varargout = FlybackGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on slider movement.
function Slider_Lm_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Lm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Slider_LmVal = get(hObject,'Value');
assignin('base','Slider_LmVal',Slider_LmVal);
set(handles.Text_SliderLm,'String',num2str(1000*Slider_LmVal));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_Lm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Lm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Edit_Vo_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Vo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Edit_VoVal = str2double(get(handles.Edit_Vo,'String'));
assignin('base','Edit_VoVal',Edit_VoVal);
% Hints: get(hObject,'String') returns contents of Edit_Vo as text
%        str2double(get(hObject,'String')) returns contents of Edit_Vo as a double


% --- Executes during object creation, after setting all properties.
function Edit_Vo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Vo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_InMin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_InMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Edit_InMinVal = str2double(get(handles.Edit_InMin,'String'));
assignin('base','Edit_InMinVal',Edit_InMinVal);
% Hints: get(hObject,'String') returns contents of Edit_InMin as text
%        str2double(get(hObject,'String')) returns contents of Edit_InMin as a double


% --- Executes during object creation, after setting all properties.
function Edit_InMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_InMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_InMax_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_InMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Edit_InMaxVal = str2double(get(handles.Edit_InMax,'String'));
assignin('base','Edit_InMaxVal',Edit_InMaxVal);
% Hints: get(hObject,'String') returns contents of Edit_InMax as text
%        str2double(get(hObject,'String')) returns contents of Edit_InMax as a double


% --- Executes during object creation, after setting all properties.
function Edit_InMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_InMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Slider_TurnsRatio_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_TurnsRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Slider_TurnsRatioVal = get(hObject,'Value');
assignin('base','Slider_TurnsRatioVal',Slider_TurnsRatioVal);
set(handles.Text_SliderTurnsRatio,'String',num2str(Slider_TurnsRatioVal));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_TurnsRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_TurnsRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_fs_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Slider_fsVal = get(hObject,'Value');
assignin('base','Slider_fsVal',Slider_fsVal);
set(handles.Text_Sliderfs,'String',num2str(Slider_fsVal));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Slider_Pout_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Pout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Slider_PoutVal = get(hObject,'Value');
assignin('base','Slider_PoutVal',Slider_PoutVal);
set(handles.Text_SliderPout,'String',num2str(Slider_PoutVal));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Slider_Pout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Pout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushPlot.
function pushPlot_Callback(hObject, eventdata, handles)
% hObject    handle to pushPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InMin = evalin('base','Edit_InMinVal');
InMax = evalin('base','Edit_InMaxVal');
VoltageRange = linspace(InMin,InMax,100);
TurnRatio = evalin('base','Slider_TurnsRatioVal');
Vo = evalin('base','Edit_VoVal');
i = 1; % index value for arrays in the while loop
while(i <= numel(VoltageRange))
    D(i) = 1/[((VoltageRange(i)/Vo)*(1/TurnRatio))+1]; % CCM Duty cycle
    i = i+1;
end
axes(handles.DutyCycle);
plot(VoltageRange,D);
title('Duty Cycle')
xlabel('Voltage')
%ylabel('Duty Cycle')
xlim([220 400])


% --- Executes on button press in pushDCMBoundary.
function pushDCMBoundary_Callback(hObject, eventdata, handles)
% hObject    handle to pushDCMBoundary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InMin = evalin('base','Edit_InMinVal');
InMax = evalin('base','Edit_InMaxVal');
VoltageRange = linspace(InMin,InMax,100);
TurnRatio = evalin('base','Slider_TurnsRatioVal');
Vo = evalin('base','Edit_VoVal');
fs = evalin('base','Slider_fsVal');
Lm = evalin('base','Slider_LmVal');
i = 1; % index value for arrays in the while loop
while(i <= numel(VoltageRange))
    D(i) = 1/[((VoltageRange(i)/Vo)*(1/TurnRatio))+1]; % CCM Duty cycle
    ILripple(i) = [D(i)*VoltageRange(i)]/[fs*Lm];
    P(i) = VoltageRange(i)*ILripple(i)*0.5*D(i);
    i = i+1;
end
axes(handles.DCMBoundary);
plot(VoltageRange,P);
title('DCM Boundary Power')
xlabel('Voltage')
%ylabel('Duty Cycle')
xlim([220 400])


% --- Executes on button press in pushIrmsIpeak.
function pushIrmsIpeak_Callback(hObject, eventdata, handles)
% hObject    handle to pushIrmsIpeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InMin = evalin('base','Edit_InMinVal');
InMax = evalin('base','Edit_InMaxVal');
VoltageRange = linspace(InMin,InMax,100);
TurnRatio = evalin('base','Slider_TurnsRatioVal');
Vo = evalin('base','Edit_VoVal');
Pout = evalin('base','Slider_PoutVal');
fs = evalin('base','Slider_fsVal');
Lm = evalin('base','Slider_LmVal');
R = (Vo^2)/Pout;
Ipeak = zeros(1,numel(VoltageRange));
i = 1; % index value for arrays in the while loop
while(i <= numel(VoltageRange))
    D(i) = 1/[((VoltageRange(i)/Vo)*(1/TurnRatio))+1]; % CCM Duty cycle
    ILripple(i) = [D(i)*VoltageRange(i)]/[fs*Lm];
    ILdc(i) = Pout/(VoltageRange(i)*D(i));
    A(i) = ILdc(i)-ILripple(i)/2;
    Irms(i) = sqrt(D(i))*sqrt([(ILripple(i)^2)/3]+[ILripple(i)*A(i)]+[A(i)^2]);
    % Determine peak value of IL - CCM
    if (Ipeak(i) <= ILdc(i)+ILripple(i)/2 && ILripple(i)/2 < ILdc(i))
        Ipeak(i) = ILdc(i)+ILripple(i)/2;
    end
    
    if (ILripple(i)/2 > ILdc(i)) % Transition to DCM
        %D(i) = [(1/VoltageRange(i))*sqrt(2*Pout*Lm*fs)]; % Constant Po Duty
        D(i) = [(Vo/VoltageRange(i))/sqrt(R/(2*Lm*fs))]; % Constant Vo Duty
        ILripple(i) = [D(i)*VoltageRange(i)]/[fs*Lm];
        ILdc(i) = ILripple(i)/2;
        Irms(i) = sqrt(D(i))*(ILripple(i)/sqrt(3));
        %Ddcm(i) = [(ILripple(i)*Lm*fs)/(Vo*TurnRatio)];
        %Doff = 1-D(i)-Ddcm(i);
        if (Ipeak(i) <= ILripple(i)) % Determine peak value of IL - DCM
            Ipeak(i) = ILripple(i);
        end
    end
    i = i+1;
end
IpeakText = max(Ipeak);
assignin('base','Ipeak',IpeakText);
set(handles.Text_Ipeak,'String',IpeakText);
axes(handles.IRMS);
plot(VoltageRange,Irms,VoltageRange,Ipeak);
title('Irms and Ipeak')
legend('Irms','Ipeak')
xlabel('Voltage')
%ylabel('Duty Cycle')
xlim([220 400])



function Edit_AL_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_AL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Edit_AL = str2double(get(handles.Edit_AL,'String'));
assignin('base','Edit_AL',Edit_AL);
% Hints: get(hObject,'String') returns contents of Edit_AL as text
%        str2double(get(hObject,'String')) returns contents of Edit_AL as a double


% --- Executes during object creation, after setting all properties.
function Edit_AL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_AL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_uPermability_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_uPermability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Edit_uPermability = str2double(get(handles.Edit_uPermability,'String'));
assignin('base','Edit_uPermability',Edit_uPermability);
% Hints: get(hObject,'String') returns contents of Edit_uPermability as text
%        str2double(get(hObject,'String')) returns contents of Edit_uPermability as a double


% --- Executes during object creation, after setting all properties.
function Edit_uPermability_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_uPermability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Bsat_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Bsat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Edit_Bsat = str2double(get(handles.Edit_Bsat,'String'));
assignin('base','Edit_Bsat',Edit_Bsat);
% Hints: get(hObject,'String') returns contents of Edit_Bsat as text
%        str2double(get(hObject,'String')) returns contents of Edit_Bsat as a double


% --- Executes during object creation, after setting all properties.
function Edit_Bsat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Bsat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_lePath_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_lePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Edit_lePath = str2double(get(handles.Edit_lePath,'String'));
assignin('base','Edit_lePath',Edit_lePath);
% Hints: get(hObject,'String') returns contents of Edit_lePath as text
%        str2double(get(hObject,'String')) returns contents of Edit_lePath as a double


% --- Executes during object creation, after setting all properties.
function Edit_lePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_lePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_AeArea_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_AeArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Edit_AeArea = str2double(get(handles.Edit_AeArea,'String'));
assignin('base','Edit_AeArea',Edit_AeArea);
% Hints: get(hObject,'String') returns contents of Edit_AeArea as text
%        str2double(get(hObject,'String')) returns contents of Edit_AeArea as a double


% --- Executes during object creation, after setting all properties.
function Edit_AeArea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_AeArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushCoreDesign.
function pushCoreDesign_Callback(hObject, eventdata, handles)
% hObject    handle to pushCoreDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
u0 = evalin('base','u0');
uCu = 1*u0;
AL = evalin('base','Edit_AL'); 
u = evalin('base','Edit_uPermability');
u = u*u0;
Bsat = evalin('base','Edit_Bsat');
le = evalin('base','Edit_lePath');
Ae = evalin('base','Edit_AeArea');
Lm = evalin('base','Slider_LmVal');
TurnsRatio = evalin('base','Slider_TurnsRatioVal');
Ipeak = evalin('base','Ipeak');
Npri = sqrt(Lm/AL); % Turns of primary winding
Nsec = Npri/TurnsRatio;
Bmax = (Npri*Ipeak*u)/le; % Tesla - Needed max B (Flux density)
Isat = (Bsat*Ae)/sqrt(Lm*AL); % A - Saturation current of the core

set(handles.Text_Isat,'String',Isat);
set(handles.Text_Bmax,'String',Bmax);
set(handles.Text_Npri,'String',Npri);
set(handles.Text_Nsec,'String',Nsec);



% --- Executes on button press in pushWindingDesign.
function pushWindingDesign_Callback(hObject, eventdata, handles)
% hObject    handle to pushWindingDesign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Text_SkinDepth,'String',Nsec);