%% Copyright 2017
% Rita Chen richen@bu.edu
% Max Christ mmchrist@bu.edu
% Jillian Yong jeyong@bu.edu
% All Rights Reserved

%%
function HW2AllRita_FinalVersion
global T;
global Thist;
global Tscat;
global male_ind;
global female_ind;
global choice2;
global choice3;


x = detectImportOptions('BCP_Activity6021.xlsx');
T = readtable('BCP_Activity6021.xlsx',x);
male_ind = (strcmp(T.sex, 'Male'));
female_ind = (strcmp(T.sex, 'Female'));
Thist = T;
Tscat = T;

%Create GUI background
 global uif;
 global ddmenu;
 global ddmenu2;
 global ddmenu3;
 global b3;
 global ax;
 global ax2;
 global histy;
 global texty;
 global m_scatter_x;
 global m_scatter_y;
 global f_scatter_x;
 global f_scatter_y;
 global xaxis_label;
 global yaxis_label;
 global label1;
 global label2;
 global bg1;
 global bg2;
 global bg3;
 global tb1;
 global tb2;
 global tb3;
 global tb4;
 global tb5;
 global tb6;
 global tb7;
 global tb8;
 global tb9;
 global histmf;
 global histage;
 global histhealth;

histmf = 'All';
histage = 'All';
histhealth = 'All';

 
 
 
uif = uifigure('visible','off','name','HW2');
ax = uiaxes('Parent',uif,'Position',[10 10 200 200],'visible','off');
ax2 = uiaxes('Parent',uif,'Position',[300 10 200 200],'visible','off');

b3 = uibutton(uif,'push',...
               'Text', 'Plot', 'visible','off','Position',[300, 250, 100, 22], ...
               'ButtonPushedFcn', @(b3,event) plotButtonPushed(b3,ax2));

bg1 = uibuttongroup(uif,'Position',[10 270 60 60],'visible', 'off','SelectionChangedFcn',@bg1fn);
bg2 = uibuttongroup(uif,'Position',[70 270 60 60],'visible', 'off','SelectionChangedFcn',@bg2fn);
bg3 = uibuttongroup(uif,'Position',[130 270 60 60],'visible', 'off','SelectionChangedFcn',@bg3fn);

tb1 = uitogglebutton(bg1,'Position',[0 40 60 20],'Text','All');
tb2 = uitogglebutton(bg1,'Position',[0 20 60 20],'Text','Male');
tb3 = uitogglebutton(bg1,'Position',[0 0 60 20],'Text','Female');


tb4 = uitogglebutton(bg2,'Position',[0 40 60 20],'Text','All');
tb5 = uitogglebutton(bg2,'Position',[0 20 60 20],'Text','Healthy');
tb6 = uitogglebutton(bg2,'Position',[0 0 60 20],'Text','Unhealthy');


tb7 = uitogglebutton(bg3,'Position',[0 40 60 20],'Text','All');
tb8 = uitogglebutton(bg3,'Position',[0 20 60 20],'Text','<69');
tb9 = uitogglebutton(bg3,'Position',[0 0 60 20],'Text','>=69');


% Creating a dropdown menu
ddmenu = uidropdown(uif,...
    'Position',[10 250 140 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu),'visible', 'off');

% Creating a dropdown menu
ddmenu2 = uidropdown(uif,...
    'Position',[300 310 140 22],...
    'Items',{'Select X Variable:','Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI'},...
    'Value','Select X Variable:',...
    'ValueChangedFcn',@(ddmenu2,event) selection2(ddmenu2),'visible', 'off');

% Creating a dropdown menu
ddmenu3 = uidropdown(uif,...
    'Position',[300 280 140 22],...
    'Items',{'Select Y Variable:','Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI'},...
    'Value','Select Y Variable:',...
    'ValueChangedFcn',@(ddmenu3,event) selection3(ddmenu3),'visible', 'off');


set([ uif, ddmenu2, ddmenu3, b3, ddmenu, bg1, bg2, bg3], 'visible','on');

% function hist(hObject,eventdata)
%     set([f1,b1,b2,txt],'visible','off');
%     set([uif,ddmenu],'visible','on');
% end
% 
% function scat(hObject,eventdata)
%     set([f1,b1,b2,txt],'visible','off');
%     set([uif,ddmenu2,ddmenu3,b3 ],'visible','on');
% end

% Create ValueChangedFcn callback:
function selection(ddmenu, eventdata, handles)
    choice = get(ddmenu,'Value');
    switch histmf
        case {'Male'}
            histind = (strcmp(Thist.sex, 'Male'));
            Thist = Thist(histind,:);
        case {'Female'}
            histind = (strcmp(Thist.sex, 'Female'));
            Thist = Thist(histind,:);
        case {'All'}
    end
    
    switch histhealth
        case {'Healthy'}
            histind = (Thist.healthy_icd_and_self_reported_fi == 1);
            Thist = Thist(histind,:);
        case {'Unhealthy'}
            histind = (Thist.healthy_icd_and_self_reported_fi == 0);
            Thist = Thist(histind,:);
        case {'All'}
    end
    
    switch histage
        case {'<69'}
            histind = (Thist.age3 < 69);
            Thist = Thist(histind,:);
        case {'>=69'}
            histind = (Thist.age3 >= 69);
            Thist = Thist(histind,:);
        case {'All'}
    end
    
    
    
    switch choice
        case {'Waist Circumference'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            waist_cir = Thist.waist_cir3;
            histy = histogram(ax,waist_cir);
            waist_cir(isnan(waist_cir)) = [];
            meanwaistcir = mean(waist_cir);
            medianwaistcir = median(waist_cir);
            fivepwaistcir = prctile(waist_cir,5);
            ninefivepwaistcir = prctile(waist_cir,95);
            circstr1 = sprintf("Mean: %.2f",meanwaistcir); 
            circstr2 = sprintf("Median: %.2f",medianwaistcir);
            circstr3 = sprintf("5th Percentile: %.2f",fivepwaistcir);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepwaistcir);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,110,250,circstr);
            xlabel(ax,'Waist Circumference (cm)');
            ylabel(ax,'Frequency');
        case {'Mean Liver Fat p'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            mean_liver_fat_p = Thist.mean_liver_fat_p;
            histy = histogram(ax,mean_liver_fat_p);
            mean_liver_fat_p(isnan(mean_liver_fat_p)) = [];
            meanlivfatp = mean(mean_liver_fat_p);
            medianlivfatp = median(mean_liver_fat_p);
            fiveplivfatp = prctile(mean_liver_fat_p,5);
            ninefiveplivfatp = prctile(mean_liver_fat_p,95);
            circstr1 = sprintf("Mean: %.2f",meanlivfatp); 
            circstr2 = sprintf("Median: %.2f",medianlivfatp);
            circstr3 = sprintf("5th Percentile: %.2f",fiveplivfatp);
            circstr4 = sprintf("95th Percentile: %.2f",ninefiveplivfatp);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,20,800,circstr);
            xlabel(ax,'Mean Liver Fat p (%)');
            ylabel(ax,'Frequency');
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            total_fat = Thist.total_fat_index;
            histy = histogram(ax,total_fat);
            total_fat(isnan(total_fat)) = [];
            meantotfat = mean(total_fat);
            mediantotfat = median(total_fat);
            fiveptotfat = prctile(total_fat,5);
            ninefiveptotfat = prctile(total_fat,95);
            circstr1 = sprintf("Mean: %.2f",meantotfat); 
            circstr2 = sprintf("Median: %.2f",mediantotfat);
            circstr3 = sprintf("5th Percentile: %.2f",fiveptotfat);
            circstr4 = sprintf("95th Percentile: %.2f",ninefiveptotfat);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,5,140,circstr);
            xlabel(ax,'Total Fat Index');
            ylabel(ax,'Frequency');
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');age = Thist.age3;
            histy = histogram(ax,age);
            age(isnan(age)) = [];
            meanage = mean(age);
            medianage = median(age);
            fivepage = prctile(age,5);
            ninefivepage = prctile(age,95);
            circstr1 = sprintf("Mean: %.2f",meanage); 
            circstr2 = sprintf("Median: %.2f",medianage);
            circstr3 = sprintf("5th Percentile: %.2f",fivepage);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepage);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,42,300,circstr); 
            xlabel(ax,'Age (year)');
            ylabel(ax,'Frequency');
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            weight = Thist.weight3;
            histy = histogram(ax,weight);
            weight(isnan(weight)) = [];
            meanweight = mean(weight);
            medianweight = median(weight);
            fivepweight = prctile(weight,5);
            ninefivepweight = prctile(weight,95);
            circstr1 = sprintf("Mean: %.2f",meanweight); 
            circstr2 = sprintf("Median: %.2f",medianweight);
            circstr3 = sprintf("5th Percentile: %.2f",fivepweight);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepweight);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,100,200,circstr); 
            xlabel(ax,'Weight (kg)');
            ylabel(ax,'Frequency');
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            height = Thist.height3;
            histy = histogram(ax,height);
            height(isnan(height)) = [];
            meanheight = mean(height);
            medianheight = median(height);
            fivepheight = prctile(height,5);
            ninefivepheight = prctile(height,95);
            circstr1 = sprintf("Mean: %.2f",meanheight); 
            circstr2 = sprintf("Median: %.2f",medianheight);
            circstr3 = sprintf("5th Percentile: %.2f",fivepheight);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepheight);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,175,230,circstr);
            xlabel(ax,'Height (cm)');
            ylabel(ax,'Frequency');
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            bmi = Thist.bmi3;
            histy = histogram(ax,bmi);
            bmi(isnan(bmi)) = [];
            meanbmi = mean(bmi);
            medianbmi = median(bmi);
            fivepbmi = prctile(bmi,5);
            ninefivepbmi = prctile(bmi,95);
            circstr1 = sprintf("Mean: %.2f",meanbmi); 
            circstr2 = sprintf("Median: %.2f",medianbmi);
            circstr3 = sprintf("5th Percentile: %.2f",fivepbmi);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepbmi);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,33,250,circstr);
            xlabel(ax,'BMI (kg/m^2)');
            ylabel(ax,'Frequency');
        case {'Sex'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            sex = Thist.sex;
            c1 = categorical(sex);
            histy = histogram(ax,c1);
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            race = Thist.race3;
            c2 = categorical(race);
            histy = histogram(ax,c2);
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            diabetes = Thist.diabetes3;
            c3 = categorical(diabetes);
            histy = histogram(ax,c3);
            xlabel(ax,'Diabetes');
            ylabel(ax,'Frequency');
    end
    Thist = T;
end

% Create ValueChangedFcn callback:
function selection2(ddmenu2, eventdata, handles)
    choice2 = get(ddmenu2,'Value');
    switch choice2
        case {'Select X Variable:'}
        case {'Waist Circumference'}
            m_scatter_x = T.waist_cir3(male_ind);
            f_scatter_x = T.waist_cir3(female_ind);
            xaxis_label = 'Waist Circumference (cm)';
        case {'Mean Liver Fat p'}
            m_scatter_x = T.mean_liver_fat_p(male_ind);
            f_scatter_x = T.mean_liver_fat_p(female_ind);
            xaxis_label = 'Mean Liver Fat p (%)';
        case {'Total Fat Index'}
            m_scatter_x = T.total_fat_index(male_ind);
            f_scatter_x = T.total_fat_index(female_ind);
            xaxis_label = 'Total Fat Index';
        case {'Age'}
            m_scatter_x = T.age3(male_ind);
            f_scatter_x = T.age3(female_ind);
            xaxis_label = 'Age (year)';
        case {'Weight'}
            m_scatter_x = T.weight3(male_ind);
            f_scatter_x = T.weight3(female_ind); 
            xaxis_label = 'Weight (kg)';
        case {'Height'}
            m_scatter_x = T.height3(male_ind);
            f_scatter_x = T.height3(female_ind);
            xaxis_label = 'Height (cm)';
        case {'BMI'}
            m_scatter_x = T.bmi3(male_ind);
            f_scatter_x = T.bmi3(female_ind);
            xaxis_label = 'BMI (kg/m^2)';
    end       
end


% Create ValueChangedFcn callback:
function selection3(ddmenu3, eventdata, handles)
    choice3 = get(ddmenu3,'Value');
    switch choice3
        case {'Select Y Variable:'}
        case {'Waist Circumference'}
            m_scatter_y = T.waist_cir3(male_ind);
            f_scatter_y = T.waist_cir3(female_ind);
            yaxis_label = 'Waist Circumference (cm)';
        case {'Mean Liver Fat p'}
            m_scatter_y = T.mean_liver_fat_p(male_ind);
            f_scatter_y = T.mean_liver_fat_p(female_ind);
            yaxis_label = 'Mean Liver Fat p (%)';
        case {'Total Fat Index'}
            m_scatter_y = T.total_fat_index(male_ind);
            f_scatter_y = T.total_fat_index(female_ind);
            yaxis_label = 'Total Fat Index';
        case {'Age'}
            m_scatter_y = T.age3(male_ind);
            f_scatter_y = T.age3(female_ind);
            yaxis_label = 'Age (year)';
        case {'Weight'}
            m_scatter_y = T.weight3(male_ind);
            f_scatter_y = T.weight3(female_ind);
            yaxis_label = 'Weight (kg)';
        case {'Height'}
            m_scatter_y = T.height3(male_ind);
            f_scatter_y = T.height3(female_ind);
            yaxis_label = 'Height (cm)';
        case {'BMI'}
            m_scatter_y = T.bmi3(male_ind);
            f_scatter_y = T.bmi3(female_ind);
            yaxis_label = 'BMI (kg/m^2)';
    end      
end

% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(b3,ax2)
    %set(ax, 'visible', 'off');
    if(~strcmp(choice2, 'Select X Variable:') && ~strcmp(choice3, 'Select Y Variable:'))
        ax2.NextPlot = 'replace';
        cla(ax2);    
        set(ax2,'visible','on');
        if (ishandle(label1))
        set(label1, 'visible','off');
        end
        if (ishandle(label2))
        set(label2, 'visible','off');
        end
        m_xy = [m_scatter_x'; m_scatter_y'];
        m_xy1 = m_xy(:, ~any(isnan(m_xy)));
        m_x = m_xy1(1,:);
        m_y = m_xy1(2,:);
        
        f_xy = [f_scatter_x'; f_scatter_y'];
        f_xy1 = f_xy(:, ~any(isnan(f_xy)));
        f_x = f_xy1(1,:);
        f_y = f_xy1(2,:);

        
        m_r = corr2(m_x, m_y);
        f_r = corr2(f_x, f_y);
        m_r_str = sprintf('Male Correlation Value: %.2f', m_r);
        f_r_str = sprintf('Female Correlation Value: %.2f', f_r);
        
        % Put UI Label stuff here
        label1 = uilabel('Text',m_r_str,'Parent',uif,...
            'Position',[390 280 180 80]);
        label2 = uilabel('Text',f_r_str,'Parent',uif,...
            'Position',[390 260 180 80]);
        
        scatter(ax2,m_scatter_x, m_scatter_y,'r');
        hold(ax2,'on')
        scatter(ax2,f_scatter_x, f_scatter_y,'b'); %'MarkerEdgeColor',[1 0 0]
        xlabel(ax2,xaxis_label);
        ylabel(ax2,yaxis_label);
        legend(ax2,'Male','Female');
    end
end

function bg1fn(source,event)
    histmf = event.NewValue.Text;
end

function bg2fn(source,event)
    histhealth = event.NewValue.Text;
end

function bg3fn(source,event)
    histage = event.NewValue.Text;
end


end
