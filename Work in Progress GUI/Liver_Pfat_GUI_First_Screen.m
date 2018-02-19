function Liver_Pfat_GUI_First_Screen

global uif;
global edbox1;
global edbox2;
global edbox3;
global edbox4;
global edbox5;
global edbox6;
global lab1;
global lab2;
global lab3;
global lab4;
global lab5;
global lab6;
global predlab;
global predbut;
global waist_cir3;
global bmi3;
global diabetes_type;
global total_fat_index;
global ActivityIndex;

% Create Window and Axes
uif = uifigure('visible','off','name','Pfabulous Pfun with Liver Pfat: A Story of Correlations and Distributions of Relevant Variables', 'Position',[20 20 1000 1000]);

%Loads model
load('liverfatmodel.mat','mdl');

%Waist Circ
edbox1 = uieditfield(uif,'numeric','visible','off','Position',[50 635 100 20],'ValueChangedFcn', @(edbox1, event) callbox1(edbox1));
%BMI
edbox2 = uieditfield(uif,'numeric','visible','off','Position',[50 585 100 20],'ValueChangedFcn', @(edbox2, event) callbox2(edbox2));
%Diabetes Type
edbox3 = uieditfield(uif,'numeric','visible','off','Position',[50 535 100 20],'ValueChangedFcn', @(edbox3, event) callbox3(edbox3));
%Total Fat Index
edbox4 = uieditfield(uif,'numeric','visible','off','Position',[50 485 100 20],'ValueChangedFcn', @(edbox4, event) callbox4(edbox4));
%Activity Index
edbox5 = uieditfield(uif,'numeric','visible','off','Position',[50 435 100 20],'ValueChangedFcn', @(edbox5, event) callbox5(edbox5));



lab1 = uilabel('Parent',uif,'text','Enter a waist circumference (cm): ','FontWeight','bold',... 
             'Position',[50 660 200 20],'visible','off');
lab2 = uilabel('Parent',uif,'text','Enter a BMI: ','FontWeight','bold',... 
             'Position',[50 610 200 20],'visible','off');
lab3 = uilabel('Parent',uif,'text','Diabetes Type: ','FontWeight','bold',... 
             'Position',[50 560 200 20],'visible','off');
lab4 = uilabel('Parent',uif,'text','Enter Total Fat Index: ','FontWeight','bold',... 
             'Position',[50 510 200 20],'visible','off');
lab5 = uilabel('Parent',uif,'text','Enter Activity Index: ','FontWeight','bold',... 
             'Position',[50 460 200 20],'visible','off');

predlab = uilabel('Parent',uif,'text','Liver Fat Precentage: ','FontWeight','bold',... 
             'Position',[600 585 200 20],'visible','off');
         
predbut = uibutton(uif,'push',...
               'Text', 'Predict', 'visible','off','Position',[600, 610, 80, 20], ...
               'ButtonPushedFcn', @(predbut,event) predButtonPushed(predbut));         
         
         
set([ uif, edbox1, lab1, edbox2, lab2, edbox3, lab3, edbox4, lab4, edbox5,lab5, predlab, predbut], 'visible','on');





% %Imaginary Test Subject
% waist_cir3 = 90;
% bmi3 = 30;
% diabetes_type = 2;
% total_fat_index = 4;
% ActivityIndex = -1;


function callbox1(edbox1)
     num = edbox1.Value;
     waist_cir3 = num;
end

function callbox2(edbox2)
     num = edbox2.Value;
     bmi3 = num;
end

function callbox3(edbox3)
     num = edbox3.Value;
     diabetes_type = num;
end

function callbox4(edbox4)
     num = edbox4.Value;
     total_fat_index = num;
end

function callbox5(edbox5)
     num = edbox5.Value;
     ActivityIndex = num;
end

function predButtonPushed(predbut)
      newT = table(waist_cir3, bmi3, diabetes_type, total_fat_index, ActivityIndex);

      %Prediction of liver fat and confidence interval
      [livfat, conint] = predict(mdl, newT);
      strliv = 'Liver Fat Precentage: ';
      livnum = num2str(livfat);
      strliv = [strliv, livnum];  

      if (ishandle(predlab))
        set(predlab, 'visible','off');
      end
      predlab = uilabel('Parent',uif,'text',strliv,'FontWeight','bold',... 
             'Position',[600 585 500 20]);
         

end

end