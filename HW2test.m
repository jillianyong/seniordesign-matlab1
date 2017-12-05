% Create title page

function HW2test

%Create GUI background
f1 = figure;
global uif;



%  global pan;
%  pan = uipanel('Parent',GuiViewFig,'Position',[10 10 400 400],'visible','on');

%  global ax;
%  ax = uiaxes('Parent',figure,'Position',[10 10 400 400],'visible','off');
 global ddmenu;
 global b1;
 global b2;
 global txt;
 global ax;
 global axcat;
 global histy;
 global texty;


% Buttons
% bgroup = uibuttongroup('parent',figure,'units','normalized','position',[.3 .3 .4 .4],'visible','off','title','Choose one of the following:','fontsize',24,'ForegroundColor','red');
b1 = uicontrol( 'Parent',f1,'visible', ...
    'off', 'Style','Pushbutton','Units','normalized',...
    'Position',[.2 .5 .2 .1], 'BackgroundColor',[.8 .6 .9],...
    'String','Scatter Plot','FontSize', 18,'Callback',@scat);
b2 = uicontrol('Parent',f1,'visible', ...
    'off','Style','Pushbutton','Units','normalized',...
    'Position',[.6 .5 .2 .1], 'BackgroundColor',[.6 .4 .7],...
    'String','Histogram','FontSize', 18, 'Callback',@scat);

% Add a text uicontrol for user instructions
txt = uicontrol('Parent',f1,'visible', ...
    'off','Style','text',...
      'Units','normalized',...
      'Position',[.2 .7 .6 .05],...
      'BackgroundColor',[.8 .8 .8],...
      'FontSize', 18,...
      'String','Please select a button to display different figures.');
 



% Creating a dropdown menu
 set([ b1, b2 txt], 'visible','on');
 
 
uif = uifigure('visible','off');
ax = uiaxes('Parent',uif,'Position',[10 10 400 400],'visible','off');
axcat = uiaxes('Parent',uif,'Position',[10 10 400 400],'visible','off');

% Creating a dropdown menu
ddmenu = uidropdown(uif,...
    'Position',[430 210 100 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu),'visible', 'off');



function scat(hObject,eventdata)
    set([f1,b1,b2,txt],'visible','off');
    set([uif,ddmenu],'visible','on');
end


% Create ValueChangedFcn callback:
function selection(ddmenu, eventdata, handles)
    x = detectImportOptions('liver_fat_with_covariates.csv');
    T = readtable('liver_fat_with_covariates.csv',x);
    choice = get(ddmenu,'Value');
    switch choice
        case {'Waist Circumference'}
            set(axcat,'visible','off');
            cla(ax);
            cla(axcat);
            set(ax,'visible','on');
            waist_cir = T.waist_cir3;
            histy = histogram(ax,waist_cir);
            waist_cir(isnan(waist_cir)) = [];
            meanwaistcir = mean(waist_cir);
            medianwaistcir = median(waist_cir);
            fivepwaistcir = prctile(waist_cir,5);
            ninefivepwaistcir = prctile(waist_cir,95);
            circstr1 = sprintf("Mean: %d",meanwaistcir); 
            circstr2 = sprintf("Median: %d",medianwaistcir);
            circstr3 = sprintf("5th Percentile: %d",fivepwaistcir);
            circstr4 = sprintf("95th Percentile: %f",ninefivepwaistcir);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,110,250,circstr);
        case {'Mean Liver Fat p'}
            set(axcat,'visible','off');
            cla(ax);
            cla(axcat);
            set(ax,'visible','on');
            mean_liver_fat_p = T.mean_liver_fat_p;
            histy = histogram(ax,mean_liver_fat_p);
            mean_liver_fat_p(isnan(mean_liver_fat_p)) = [];
            meanlivfatp = mean(mean_liver_fat_p);
            medianlivfatp = median(mean_liver_fat_p);
            fiveplivfatp = prctile(mean_liver_fat_p,5);
            ninefiveplivfatp = prctile(mean_liver_fat_p,95);
            circstr1 = sprintf("Mean: %d",meanlivfatp); 
            circstr2 = sprintf("Median: %d",medianlivfatp);
            circstr3 = sprintf("5th Percentile: %d",fiveplivfatp);
            circstr4 = sprintf("95th Percentile: %f",ninefiveplivfatp);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,20,800,circstr);
        case {'Total Fat'}
            set(axcat,'visible','off');
            cla(ax);
            cla(axcat);
            set(ax,'visible','on');
            total_fat = T.total_fat;
            histy = histogram(ax,total_fat);
            total_fat(isnan(total_fat)) = [];
            meantotfat = mean(total_fat);
            mediantotfat = median(total_fat);
            fiveptotfat = prctile(total_fat,5);
            ninefiveptotfat = prctile(total_fat,95);
            circstr1 = sprintf("Mean: %d",meantotfat); 
            circstr2 = sprintf("Median: %d",mediantotfat);
            circstr3 = sprintf("5th Percentile: %d",fiveptotfat);
            circstr4 = sprintf("95th Percentile: %f",ninefiveptotfat);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,20,200,circstr);            
        case {'Age'}
            set(axcat,'visible','off');
            cla(ax);
            cla(axcat);
            set(ax,'visible','on');age = T.age3;
            histy = histogram(ax,age);
            age(isnan(age)) = [];
            meanage = mean(age);
            medianage = median(age);
            fivepage = prctile(age,5);
            ninefivepage = prctile(age,95);
            circstr1 = sprintf("Mean: %d",meanage); 
            circstr2 = sprintf("Median: %d",medianage);
            circstr3 = sprintf("5th Percentile: %d",fivepage);
            circstr4 = sprintf("95th Percentile: %f",ninefivepage);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,42,300,circstr);            
        case {'Weight'}
            set(axcat,'visible','off');
            cla(ax);
            cla(axcat);
            set(ax,'visible','on');
            weight = T.weight3;
            histy = histogram(ax,weight);
            weight(isnan(weight)) = [];
            meanweight = mean(weight);
            medianweight = median(weight);
            fivepweight = prctile(weight,5);
            ninefivepweight = prctile(weight,95);
            circstr1 = sprintf("Mean: %d",meanweight); 
            circstr2 = sprintf("Median: %d",medianweight);
            circstr3 = sprintf("5th Percentile: %d",fivepweight);
            circstr4 = sprintf("95th Percentile: %f",ninefivepweight);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,100,200,circstr); 
        case {'Height'}
            set(axcat,'visible','off');
            cla(ax);
            cla(axcat);
            set(ax,'visible','on');
            height = T.height3;
            histy = histogram(ax,height);
            height(isnan(height)) = [];
            meanheight = mean(height);
            medianheight = median(height);
            fivepheight = prctile(height,5);
            ninefivepheight = prctile(height,95);
            circstr1 = sprintf("Mean: %d",meanheight); 
            circstr2 = sprintf("Median: %d",medianheight);
            circstr3 = sprintf("5th Percentile: %d",fivepheight);
            circstr4 = sprintf("95th Percentile: %f",ninefivepheight);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,175,230,circstr);
        case {'BMI'}
            set(axcat,'visible','off');
            cla(ax);
            cla(axcat);
            set(ax,'visible','on');
            bmi = T.bmi3;
            histy = histogram(ax,bmi);
            bmi(isnan(bmi)) = [];
            meanbmi = mean(bmi);
            medianbmi = median(bmi);
            fivepbmi = prctile(bmi,5);
            ninefivepbmi = prctile(bmi,95);
            circstr1 = sprintf("Mean: %d",meanbmi); 
            circstr2 = sprintf("Median: %d",medianbmi);
            circstr3 = sprintf("5th Percentile: %d",fivepbmi);
            circstr4 = sprintf("95th Percentile: %f",ninefivepbmi);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,33,250,circstr);
        case {'Sex'}
            set(axcat,'visible','on');
            cla(ax);
            cla(axcat);
            set(ax,'visible','off');
            sex = T.sex;
            c1 = categorical(sex);
            histy = histogram(axcat,c1);
        case {'Race'}
            set(axcat,'visible','on');
            cla(ax);
            cla(axcat);
            set(ax,'visible','off');
            race = T.race3;
            c2 = categorical(race);
            histy = histogram(axcat,c2);
        case {'Diabetes'}
            set(axcat,'visible','on');
            cla(ax);
            cla(axcat);
            set(ax,'visible','off');
            diabetes = T.diabetes3;
            c3 = categorical(diabetes);
            histy = histogram(axcat,c3);
    end
end
end  