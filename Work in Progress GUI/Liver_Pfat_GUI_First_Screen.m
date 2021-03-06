function Liver_Pfat_GUI_First_Screen

global uif;
global edbox1;
global edbox2;
global edbox3;
global edbox4;
global edbox5;
global edbox6;
global edbox7;
global lab1;
global lab2;
global lab3;
global lab4;
global lab5;
global lab6;
global lab7;
global predlab;
global predbut;
global vislab;
global visbut;
global waist_cir3;
global bmi3;
global weight3;
% global diabetes_type;
%global age3;
global total_fat_index;
global VAT_index;
global newT;
global newT_with_livfat;
global mean_liver_fat_p;

%All the following is mostly just front-end to make the GUI look good

% Create Window and Axes
uif = uifigure('visible','off','name','Pfabulous Pfun with Liver Pfat: A Story of Correlations and Distributions of Relevant Variables', 'Position',[20 20 1000 1000]);

titleall = uilabel('Text','NAFLD Predictor','Parent',uif,...
            'Position',[350 660 1200 55],'FontSize',40); % Title for all

%Loads saved random forest model
load('liverfatmodel.mat','mdl');

%Waist Circ
edbox1 = uieditfield(uif,'numeric','visible','off','Position',[75 555 100 20],'ValueChangedFcn', @(edbox1, event) callbox1(edbox1));

%BMI
edbox2 = uieditfield(uif,'numeric','visible','off','Position',[75 495 100 20],'ValueChangedFcn', @(edbox2, event) callbox2(edbox2));

%Weight (formerly diabetes type)
edbox3 = uieditfield(uif,'numeric','visible','off','Position',[75 435 100 20],'ValueChangedFcn', @(edbox3, event) callbox3(edbox3));

%Age
%edbox4 = uieditfield(uif,'numeric','visible','off','Position',[75 380 100 20],'ValueChangedFcn', @(edbox4, event) callbox4(edbox4));

%Total Fat Index
edbox5 = uieditfield(uif,'numeric','visible','off','Position',[75 375 100 20],'ValueChangedFcn', @(edbox5, event) callbox5(edbox5));

%VAT Index
edbox6 = uieditfield(uif,'numeric','visible','off','Position',[75 315 100 20],'ValueChangedFcn', @(edbox6, event) callbox6(edbox6));

%SAT Index
edbox7 = uieditfield(uif,'numeric','visible','off','Position',[75 255 100 20],'ValueChangedFcn', @(edbox7, event) callbox7(edbox7));


lab1 = uilabel('Parent',uif,'text','Enter a waist circumference (cm): ','FontWeight','bold',... 
             'Position',[75 585 500 25],'FontSize', 18, 'visible','off');
         
lab2 = uilabel('Parent',uif,'text','Enter a BMI: ','FontWeight','bold',... 
             'Position',[75 525 200 25],'FontSize', 18,'visible','off');

lab3 = uilabel('Parent',uif,'text','Weight (kg): ','FontWeight','bold',... 
             'Position',[75 465 200 25],'FontSize', 18,'visible','off');

%lab4 = uilabel('Parent',uif,'text','Enter age: ','FontWeight','bold',... 
             %'Position',[75 400 350 25],'FontSize', 18,'visible','off');

lab5 = uilabel('Parent',uif,'text','Enter Total Fat Index: ','FontWeight','bold',... 
             'Position',[75 405 350 25],'FontSize', 18,'visible','off');

lab6 = uilabel('Parent',uif,'text','Enter VAT Index: ','FontWeight','bold',... 
             'Position',[75 345 350 25],'FontSize', 18,'visible','off');

lab7 = uilabel('Parent',uif,'text','Enter SAT Index: ','FontWeight','bold',... 
             'Position',[75 285 350 25],'FontSize', 18,'visible','off');

predlab = uilabel('Parent',uif,'text','Are you Likely to Have NAFLD? ','FontWeight','bold',... 
             'Position',[600 560 370 50],'FontSize', 18, 'visible','off');
         
predbut = uibutton(uif,'push',...
               'Text', 'Predict','visible','off','Position',[600, 520, 80, 50], ...
               'ButtonPushedFcn', @(predbut,event) predButtonPushed(predbut)); 

vislab = uilabel('Parent',uif,'text','Visualize Your Metrics:','FontWeight','bold',... 
             'Position',[600 340 370 50],'FontSize', 18, 'visible','off');
         
visbut = uibutton(uif,'push',...
               'Text', 'Visualize','visible','off','Position',[600, 300, 80, 50], ...
               'ButtonPushedFcn', @(visbut,event) visButtonPushed(visbut)); 
         
set([ uif, edbox1, lab1, edbox2, lab2, edbox3, lab3, edbox5,lab5, edbox6,lab6, edbox7, lab7, predlab, predbut, vislab, visbut], 'visible','on');

%Imaginary Test Subject
waist_cir3 = 0;
bmi3 = 0;
% diabetes_type = 0;
total_fat_index = 0;
weight3 = 0;
%age3 = 0;
VAT_index = 0;
SAT_index = 0;


%All the following functions assign the patient inputted values to their
%respective variables

%Waist Circ
function callbox1(edbox1)
     num = edbox1.Value;
     waist_cir3 = num;
end

%BMI
function callbox2(edbox2)
     num = edbox2.Value;
     bmi3 = num;
end

%Weight
function callbox3(edbox3)
     num = edbox3.Value;
     weight3 = num;
end
 
% function callbox4(edbox4)
%      num = edbox4.Value;
%      age3 = num;
% end

%Total Fat Index
function callbox5(edbox5)
     num = edbox5.Value;
     total_fat_index = num
end

%VAT Index
function callbox6(edbox6)
     num = edbox6.Value;
     VAT_index = num;
end

%SAT Index
function callbox7(edbox7)
     num = edbox7.Value;
     SAT_index = num;
end

function predButtonPushed(predbut)
    callbox1(edbox1)
    callbox2(edbox2)
    callbox3(edbox3)
    callbox5(edbox5)
    callbox6(edbox6)
    callbox7(edbox7)    
      

      %Error checking for valid metric numbers
      if waist_cir3 <= 15 || waist_cir3 > 155 || waist_cir3 == 0
         errordlg('Please enter a number within a valid range of waist circumference.', 'Input Error')
      elseif bmi3 <= 15 || bmi3 > 55 || bmi3 == 0
         errordlg('Please enter a number within a valid range of BMI.', 'Input Error')
      elseif weight3 <= 40 || weight3 > 180 || weight3 == 0
         errordlg('Please enter a number within a valid range of weight.', 'Input Error')
      elseif total_fat_index <= 0 || total_fat_index > 15 
        errordlg('Please enter a number within a valid range of total fat index.', 'Input Error')
      elseif VAT_index <= 0 || VAT_index > 5.5
         errordlg('Please enter a number within a valid range of VAT index.', 'Input Error')
      elseif SAT_index <= 0 || SAT_index > 9
         errordlg('Please enter a number within a valid range of SAT index.', 'Input Error')
      end


      %Creating a new table to run through the model
      newT = table(waist_cir3, bmi3, total_fat_index, weight3, VAT_index,SAT_index);
      
      %Prediction of liver fat and confidence interval using random forest
      %model
      [mean_liver_fat_p, stdlivfat] = predict(mdl, newT);
      if mean_liver_fat_p > 6
          fatresult = 'Yes';
      else
          fatresult = 'No';
      end

      strliv = 'Are you likely to have NAFLD? ';
      strliv = [strliv, fatresult];  

      if (ishandle(predlab))
        set(predlab, 'visible','off');
      end
      predlab = uilabel('Parent',uif,'text',strliv,'FontWeight','bold',... 
             'Position',[600 565 500 40], 'FontSize',18,'visible', 'on');
         
    
      newT_with_livfat = table(waist_cir3, bmi3, total_fat_index, weight3, VAT_index,SAT_index, mean_liver_fat_p);
      
end


%Linker function to open the visualization screen to allow patient to view
%metrics
function visButtonPushed(visbut)
    predButtonPushed; 
    Liver_Pfat_GUI_Visualization(newT_with_livfat);
end

end
