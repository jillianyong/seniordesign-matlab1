% Create title page

function HW2allMax
global T;
global male_ind;
global female_ind;
global choice2;
global choice3;

% RITA: Change the file name, anywhere where it says total_fat_index
x = detectImportOptions('BCP_Activity6021.xlsx');
T = readtable('BCP_Activity6021.xlsx',x);
male_ind = (strcmp(T.sex, 'Male'));
female_ind = (strcmp(T.sex, 'Female'));

%Create GUI background
f1 = figure;
 global uif;
 global ddmenu;
 global ddmenu2;
 global ddmenu3;
 global b1;
 global b2;
 global b3;
 global txt;
 global ax;
 global histy;
 global texty;
 global m_scatter_x;
 global m_scatter_y;
 global f_scatter_x;
 global f_scatter_y;
 global xaxis_label;
 global yaxis_label;


% Buttons
b1 = uicontrol( 'Parent',f1,'visible', ...
    'off', 'Style','Pushbutton','Units','normalized',...
    'Position',[.2 .5 .2 .1], 'BackgroundColor',[.8 .6 .9],...
    'String','Scatter Plot','FontSize', 18,'Callback',@scat);
b2 = uicontrol('Parent',f1,'visible', ...
    'off','Style','Pushbutton','Units','normalized',...
    'Position',[.6 .5 .2 .1], 'BackgroundColor',[.6 .4 .7],...
    'String','Histogram','FontSize', 18, 'Callback',@hist);

% Add a text uicontrol for user instructions
txt = uicontrol('Parent',f1,'visible', ...
    'off','Style','text',...
      'Units','normalized',...
      'Position',[.08 .7 .9 .08],...
      'FontSize', 18,...
      'String','Please select a button to display different figures.');
 



% Creating a dropdown menu
 set([ b1, b2 txt], 'visible','on');
 
 
uif = uifigure('visible','off');
ax = uiaxes('Parent',uif,'Position',[10 10 400 400],'visible','off');

b3 = uibutton(uif,'push',...
               'Text', 'plot', 'visible','off','Position',[430, 200, 100, 22], ...
               'ButtonPushedFcn', @(b3,event) plotButtonPushed(b3,ax));

% Creating a dropdown menu
ddmenu = uidropdown(uif,...
    'Position',[430 210 100 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu),'visible', 'off');

% Creating a dropdown menu
ddmenu2 = uidropdown(uif,...
    'Position',[430 300 100 22],...
    'Items',{'Select X Variable:','Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI'},...
    'Value','Select X Variable:',...
    'ValueChangedFcn',@(ddmenu2,event) selection2(ddmenu2),'visible', 'off');

% Creating a dropdown menu
ddmenu3 = uidropdown(uif,...
    'Position',[430 100 100 22],...
    'Items',{'Select Y Variable:','Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI'},...
    'Value','Select Y Variable:',...
    'ValueChangedFcn',@(ddmenu3,event) selection3(ddmenu3),'visible', 'off');


function hist(hObject,eventdata)
    set([f1,b1,b2,txt],'visible','off');
    set([uif,ddmenu],'visible','on');
end

function scat(hObject,eventdata)
    set([f1,b1,b2,txt],'visible','off');
    set([uif,ddmenu2,ddmenu3,b3 ],'visible','on');
end

% Create ValueChangedFcn callback:
function selection(ddmenu, eventdata, handles)
    choice = get(ddmenu,'Value');
    switch choice
        case {'Waist Circumference'}
            ax.NextPlot = 'replace';
            cla(ax);
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
            xlabel(ax,'Waist Circumference');
            ylabel(ax,'Frequency');
        case {'Mean Liver Fat p'}
            ax.NextPlot = 'replace';
            cla(ax);
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
            xlabel(ax,'Mean Liver Fat p');
            ylabel(ax,'Frequency');
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            total_fat = T.total_fat_index;
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
            texty = text(ax,7,300,circstr);
            xlabel(ax,'Total Fat');
            ylabel(ax,'Frequency');
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
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
            xlabel(ax,'Age');
            ylabel(ax,'Frequency');
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
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
            xlabel(ax,'Weight');
            ylabel(ax,'Frequency');
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
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
            xlabel(ax,'Height');
            ylabel(ax,'Frequency');
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
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
            xlabel(ax,'BMI');
            ylabel(ax,'Frequency');
        case {'Sex'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            sex = T.sex;
            c1 = categorical(sex);
            histy = histogram(ax,c1);
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            race = T.race3;
            c2 = categorical(race);
            histy = histogram(ax,c2);
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            diabetes = T.diabetes3;
            c3 = categorical(diabetes);
            histy = histogram(ax,c3);
            xlabel(ax,'Diabetes');
            ylabel(ax,'Frequency');
    end
end

% Create ValueChangedFcn callback:
function selection2(ddmenu2, eventdata, handles)
    choice2 = get(ddmenu2,'Value');
    switch choice2
        case {'Select X Variable:'}

        case {'Waist Circumference'}
            m_scatter_x = T.waist_cir3(male_ind);
            f_scatter_x = T.waist_cir3(female_ind);
            xaxis_label = 'Waist Circumference';
        case {'Mean Liver Fat p'}
            m_scatter_x = T.mean_liver_fat_p(male_ind);
            f_scatter_x = T.mean_liver_fat_p(female_ind);
        case {'Total Fat Index'}
            m_scatter_x = T.total_fat_index(male_ind);
            f_scatter_x = T.total_fat_index(female_ind);
            xaxis_label = 'Total Fat Index';
        case {'Age'}
            m_scatter_x = T.age3(male_ind);
            f_scatter_x = T.age3(female_ind);
            xaxis_label = 'Age';
        case {'Weight'}
            m_scatter_x = T.weight3(male_ind);
            f_scatter_x = T.weight3(female_ind); 
            xaxis_label = 'Weight';
        case {'Height'}
            m_scatter_x = T.height3(male_ind);
            f_scatter_x = T.height3(female_ind);
            xaxis_label = 'Height';
        case {'BMI'}
            m_scatter_x = T.bmi3(male_ind);
            f_scatter_x = T.bmi3(female_ind);
            xaxis_label = 'BMI';
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
            yaxis_label = 'Waist Circumference';
        case {'Mean Liver Fat p'}
            m_scatter_y = T.mean_liver_fat_p(male_ind);
            f_scatter_y = T.mean_liver_fat_p(female_ind);
            yaxis_label = 'Mean Liver Fat p';
        case {'Total Fat Index'}
            m_scatter_y = T.total_fat_index(male_ind);
            f_scatter_y = T.total_fat_index(female_ind);
            yaxis_label = 'Total Fat Index';
        case {'Age'}
            m_scatter_y = T.age3(male_ind);
            f_scatter_y = T.age3(female_ind);
            yaxis_label = 'Age';
        case {'Weight'}
            m_scatter_y = T.weight3(male_ind);
            f_scatter_y = T.weight3(female_ind);
            yaxis_label = 'Weight';
        case {'Height'}
            m_scatter_y = T.height3(male_ind);
            f_scatter_y = T.height3(female_ind);
            yaxis_label = 'Height';
        case {'BMI'}
            m_scatter_y = T.bmi3(male_ind);
            f_scatter_y = T.bmi3(female_ind);
            yaxis_label = 'BMI';
    end      
end

% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(b3,ax)
    if(~strcmp(choice2, 'Select X Variable:') && ~strcmp(choice3, 'Select Y Variable:'))
        ax.NextPlot = 'replace';
        cla(ax);    
        set(ax,'visible','on');
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
        m_r_str = sprintf('Male Correlation Value: %d', m_r);
        f_r_str = sprintf('Female Correlation Value: %d', f_r);
        
        % Put UI Label stuff here
        
        
        scatter(ax,m_scatter_x, m_scatter_y);
        hold(ax,'on')
        scatter(ax,f_scatter_x, f_scatter_y,'MarkerEdgeColor',[1 0 0]);
        xlabel(ax,xaxis_label);
        ylabel(ax,yaxis_label);
    end
end



end
