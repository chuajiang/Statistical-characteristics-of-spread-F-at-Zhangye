clear all；
clc

%%%%%%%%%%% Figure1
% %This figure needs 'm_map' toolbox.Installation website: https://www.eoas.ubc.ca/~rich/mapug.html
% 
% figure;
% m_proj('lambert','lon',[80 125],'lat',[30 55]); 
% 
% [CS,CH]=m_etopo2('contourf',[-500:500:0 0:500:6500],'edgecolor','none');
%  m_grid('linestyle','none','tickdir','out','linewidth',3);
% colormap([ m_colmap('blues',10); m_colmap('gland',100)]);
% brighten(.5);
% m_line(100.54,39.21,'marker','.','color','r','markersize',16);
% ax=m_contfbar(1,[.5 .8],CS,CH);
% 
% title(ax,{'Level/m',''}); % Move up by inserting a blank line




%%%%%%%%%%% Figure2
load('time_ofall2022.mat');load('time_ofall2021.mat');load('time_ofall2020.mat');
load('time_ofall2019.mat');load('time_ofall2018.mat');load('time_ofall2017.mat');

load('time_ofexist2022.mat');load('time_ofexist2021.mat');load('time_ofexist2020.mat');
load('time_ofexist2019.mat');load('time_ofexist2018.mat');load('time_ofexist2017.mat');

time_ofexist = {time_ofexist2017,time_ofexist2018,time_ofexist2019,time_ofexist2020,time_ofexist2021,time_ofexist2022};
time_ofall = {time_ofall2017,time_ofall2018,time_ofall2019,time_ofall2020,time_ofall2021,time_ofall2022};


hmsdatenum_exist = cell(1,6);
ymddatenum_exist = cell(1,6);
hmsdatenum_all = cell(1,6);
ymddatenum_all = cell(1,6);
for t=1:6
    ymddatenum_exist{t}=datenum(time_ofexist{t}(:,1),time_ofexist{t}(:,2),time_ofexist{t}(:,3))-datenum(time_ofexist{t}(:,1),0,0);%出现扩展F的月日
    hmsdatenum_exist{t}=datenum(0,0,0,time_ofexist{t}(:,4),time_ofexist{t}(:,5),time_ofexist{t}(:,6));%出现扩展F时分秒的datenum
    for i=1:length(hmsdatenum_exist{t})
        if hmsdatenum_exist{t}(i)>=0.5 
            ymddatenum_exist{t}(i)=ymddatenum_exist{t}(i)+1;
        end
    end
    for i=1:length(hmsdatenum_exist{t})
        if hmsdatenum_exist{t}(i)>=0.5 
            hmsdatenum_exist{t}(i)=hmsdatenum_exist{t}(i)-1;
        end
    end
    ymddatenum_all{t}=datenum(time_ofall{t}(:,1),time_ofall{t}(:,2),time_ofall{t}(:,3))-datenum(time_ofall{t}(:,1),0,0);
    hmsdatenum_all{t}=datenum(0,0,0,time_ofall{t}(:,4),time_ofall{t}(:,5),time_ofall{t}(:,6));
    for i=1:length(hmsdatenum_all{t})
        if hmsdatenum_all{t}(i)>=0.5
            ymddatenum_all{t}(i)=ymddatenum_all{t}(i)+1;
        end
    end
    for i=1:length(hmsdatenum_all{t})
        if hmsdatenum_all{t}(i)>=0.5
            hmsdatenum_all{t}(i)=hmsdatenum_all{t}(i)-1;
        end
    end
end
%------------------------------sunrise and sunset data----------------------------------%
load('sunriseTime.mat');
load('sunsetTime.mat')
f1='HH:MM AM';
f2='HH:MM PM';
sunriseTime_17=[];
sunsetTime_17=[];
t=1;
for i=1:365
    sunriseTime_17(t)=datenum(sunriseTime(i),f1)-datenum('2023-1-1');
    sunsetTime_17(t)=datenum(sunsetTime(i),f2)-datenum('2023-1-1')-1;
    t=t+1;
end

sunriseTime_18=[];
sunsetTime_18=[];
t=1;
for i=367:731
    sunriseTime_18(t)=datenum(sunriseTime(i),f1)-datenum('2023-1-1');
    sunsetTime_18(t)=datenum(sunsetTime(i),f2)-datenum('2023-1-1')-1;
    t=t+1;
end

sunriseTime_19=[];
sunsetTime_19=[];
t=1;
for i=733:1097
    sunriseTime_19(t)=datenum(sunriseTime(i),f1)-datenum('2023-1-1');
    sunsetTime_19(t)=datenum(sunsetTime(i),f2)-datenum('2023-1-1')-1;
    t=t+1;
end

sunriseTime_20=[];
sunsetTime_20=[];
t=1;
for i=1099:1464
    sunriseTime_20(t)=datenum(sunriseTime(i),f1)-datenum('2023-1-1');
    sunsetTime_20(t)=datenum(sunsetTime(i),f2)-datenum('2023-1-1')-1;
    t=t+1;
end

sunriseTime_21=[];
sunsetTime_21=[];
t=1;
for i=1466:1830
    sunriseTime_21(t)=datenum(sunriseTime(i),f1)-datenum('2023-1-1');
    sunsetTime_21(t)=datenum(sunsetTime(i),f2)-datenum('2023-1-1')-1;
    t=t+1;
end

sunriseTime_22=[];
sunsetTime_22=[];
t=1;
for i=1832:2196
    sunriseTime_22(t)=datenum(sunriseTime(i),f1)-datenum('2023-1-1');
    sunsetTime_22(t)=datenum(sunsetTime(i),f2)-datenum('2023-1-1')-1;
    t=t+1;
end

%----------进行图像绘制-----------%
figure();
set(gcf,'Position',[100 100 600 600])
t = tiledlayout(2,3,'TileSpacing','Compact');
nexttile
datetime_17=1:365;
scatter(ymddatenum_exist{1},hmsdatenum_exist{1},2,'o','k','filled');
hold on 
scatter(datetime_17,sunriseTime_17-1/24,3,'o','g','filled');
hold on 
scatter(datetime_17,sunsetTime_17-1/24,3,'o','b','filled');
set(gca,'xtick',1:30:365);
set(gca,'ytick',-0.5:0.08333333333333333:0.5);
set(gca,'xlim',[1 365]);
v1 = [156 -0.5; 185 -0.5; 156 0.5; 185 0.5];
f1 = [1 2 4 3];
patch('Faces',f1,'Vertices',v1,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none')
datetick(gca,'y','HH:MM','keepticks')
dateaxis('y',15);
title('(1) SF observed over ZhangYe in 2017');

nexttile
scatter(ymddatenum_exist{2},hmsdatenum_exist{2},2,'o','k','filled');
hold on 
scatter(datetime_17,sunriseTime_18-1/24,3,'o','g','filled');
hold on 
scatter(datetime_17,sunsetTime_18-1/24,3,'o','b','filled');
set(gca,'xtick',1:30:365);
set(gca,'ytick',-0.5:0.08333333333333333:0.5);
set(gca,'xlim',[1 365]);
datetick(gca,'y','HH:MM','keepticks')
v21 = [30 -0.5; 38 -0.5; 31 0.5; 38 0.5];
v22 = [40 -0.5; 40 -0.5; 40 0.5; 40 0.5];
v23 = [43 -0.5; 45 -0.5; 43 0.5; 45 0.5];
v24 = [77 -0.5; 79 -0.5; 77 0.5; 79 0.5];
v25 = [104 -0.5; 108 -0.5; 104 0.5; 108 0.5];
v26 = [118 -0.5; 120 -0.5; 118 0.5; 120 0.5];
f1 = [1 2 4 3];
patch('Faces',f1,'Vertices',v21,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none');
patch('Faces',f1,'Vertices',v22,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none');
patch('Faces',f1,'Vertices',v23,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none');
patch('Faces',f1,'Vertices',v24,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none');
patch('Faces',f1,'Vertices',v25,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none');
patch('Faces',f1,'Vertices',v26,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none');
dateaxis('y',15);
title('(2) SF observed over ZhangYe in 2018');

nexttile
scatter(ymddatenum_exist{3},hmsdatenum_exist{3},2,'o','k','filled');
hold on 
scatter(datetime_17,sunriseTime_19-1/24,3,'o','g','filled');
hold on 
scatter(datetime_17,sunsetTime_19-1/24,3,'o','b','filled');
set(gca,'xtick',1:30:365);
set(gca,'ytick',-0.5:0.08333333333333333:0.5);
set(gca,'xlim',[1 365]);
datetick(gca,'y','HH:MM','keepticks')
dateaxis('y',15);
title('(3) SF observed over ZhangYe in 2019');

nexttile
datetime_20=1:366;
scatter(ymddatenum_exist{4},hmsdatenum_exist{4},2,'o','k','filled');
hold on 
scatter(datetime_20,sunriseTime_20-1/24,3,'o','g','filled');
hold on 
scatter(datetime_20,sunsetTime_20-1/24,3,'o','b','filled');
set(gca,'xtick',1:30:366);
set(gca,'ytick',-0.5:0.08333333333333333:0.5);
set(gca,'xlim',[1 366]);
ylabel('Local time','FontSize',14);
datetick(gca,'y','HH:MM','keepticks')
v4 = [327 -0.5; 349 -0.5; 327 0.5; 349 0.5];
f1 = [1 2 4 3];
patch('Faces',f1,'Vertices',v4,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none')
dateaxis('y',15);
title('(4) SF observed over ZhangYe in 2020');

nexttile
scatter(ymddatenum_exist{5},hmsdatenum_exist{5},2,'o','k','filled');
hold on 
scatter(datetime_17,sunriseTime_21-1/24,3,'o','g','filled');
hold on 
scatter(datetime_17,sunsetTime_21-1/24,3,'o','b','filled');
set(gca,'xtick',1:30:365);
set(gca,'ytick',-0.5:0.08333333333333333:0.5);
set(gca,'xlim',[1 365]);
datetick(gca,'y','HH:MM','keepticks')
v5 = [87 -0.5; 90 -0.5; 87 0.5; 90 0.5];
f1 = [1 2 4 3];
patch('Faces',f1,'Vertices',v5,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none')
dateaxis('y',15);
title('(5) SF observed over ZhangYe in 2021');
xlabel('Day Of Year','FontSize',14);

nexttile
scatter(ymddatenum_exist{6},hmsdatenum_exist{6},2,'o','k','filled');
hold on 
scatter(datetime_17,sunriseTime_22-1/24,3,'o','g','filled');
hold on 
scatter(datetime_17,sunsetTime_22-1/24,3,'o','b','filled');
set(gca,'xtick',1:30:365);
set(gca,'ytick',-0.5:0.08333333333333333:0.5);
set(gca,'xlim',[1 365]);
datetick(gca,'y','HH:MM','keepticks')
v6 = [162 -0.5; 165 -0.5; 162 0.5; 165 0.5];
f1 = [1 2 4 3];
patch('Faces',f1,'Vertices',v6,'FaceColor','#808A87','FaceAlpha',.3,'EdgeColor','none')
dateaxis('y',15);
title('(6) SF observed over ZhangYe in 2022');




%%%%%%%%%%% Figure3 and Figure4
probability_d = cell(1,6);
for m = 1:6
    num_ofexist_day=zeros(1,24);
    hour_exist=time_ofexist{m}(:,4);
    for time=0:23
    for i=1:length(hour_exist)
        if hour_exist(i)==time
            num_ofexist_day(time+1)=num_ofexist_day(time+1)+1;%用num_day进行计数，记录在此时间段出现扩展f的次数，下同。
        else
            continue
        end
    end
    end
 
    hour_all=time_ofall{m}(:,4);
    num_ofall_day=zeros(1,24);
    for i=1:length(hour_all)
        for time=0:23
        if hour_all(i)==time
            num_ofall_day(time+1)=num_ofall_day(time+1)+1;
        else
            continue
        end
        end
    end
 
    probability_d{m}=zeros(1,24);
    for i=1:24
        probability_d{m}(i)=(num_ofexist_day(i)/num_ofall_day(i))*100;
    end
    clear num_ofexist_day num_ofall_day;
end


probability_m = cell(1,6);
for m =1:6
    mon_exist=time_ofexist{m}(:,2);
    num_ofexist_mon=zeros(1,12);
    for mon=1:12
    for i=1:length(mon_exist)
        if mon_exist(i)==mon
            num_ofexist_mon(mon)=num_ofexist_mon(mon)+1;
        else
            continue
        end
    end
    end
  
    mon_all=time_ofall{m}(:,2);
    num_ofall_mon=zeros(1,12);
    for mon=1:12
        for i=1:length(mon_all)
            if mon_all(i)==mon
                num_ofall_mon(mon)=num_ofall_mon(mon)+1;
            else
                continue
            end
        end
    end
    probability_m{m}=zeros(1,12);
    for i=1:12
        probability_m{m}(i)=(num_ofexist_mon(i)/num_ofall_mon(i))*100;
    end
    clear mon_all mon_exist num_ofexist_mon num_ofall_mon;
end

figure;
m=1:24;
plot(m,probability_d{1},'-^m')
hold on
plot(m,probability_d{2},'-^k')
hold on
plot(m,probability_d{3},'-^g')
hold on
plot(m,probability_d{4},'-^r')
hold on
plot(m,probability_d{5},'-^b')
hold on
plot(m,probability_d{6},'-^c')
set(gca,'Xtick',1:1:24)
set(gca,'xlim',[1 24]);
grid on
title('The Occurrence Probability of SF at Zhangye');
xlabel('Local Time')
ylabel('Percentage of Occurrence(%)')
legend('2017','2018','2019','2020','2021','2022')

figure;
m=1:12;
plot(m,probability_m{1},'-^m')
hold on
plot(m,probability_m{2},'-^k')
hold on
plot(m,probability_m{3},'-^g')
hold on
plot(m,probability_m{4},'-^r')
hold on
plot(m,probability_m{5},'-^b')
hold on
plot(m,probability_m{6},'-^c')
set(gca,'Xtick',1:1:12)
set(gca,'xlim',[1 12]);
grid on
title('The Occurrence Probability of SF at Zhangye');
xlabel('Month')
ylabel('Percentage of Occurrence(%)')
legend('2017','2018','2019','2020','2021','2022')



%%%%%%%%%%% Figure5
mt_prob = cell(1,6);
for m = 1:6
    time_mon=time_ofall{m}(:,2);
    mpt=zeros(12,24);
    s=zeros(1,12);
    time_hour=time_ofall{m}(:,4);
    for k=1:24
       for i=1:length(time_ofall{m})
           switch time_hour(i)
                case (k-1)
                    for t=1:12
                        if time_mon(i)==t
                            s(t)=s(t)+1;
                            mpt(13-t,k)=s(t);
                        else
                            continue
                        end
                    end
                otherwise
                    continue
           end
       end
       s=zeros(1,12);
    end
    mt_probability=zeros(12,24);
    time_hour_exist=time_ofexist{m}(:,4);
    time_mon_exist=time_ofexist{m}(:,2);
    s=zeros(1,12);
    for k=1:24
       for i=1:length(time_ofexist{m})
        switch time_hour_exist(i)
            case (k-1)
                for t=1:12
                if time_mon_exist(i)==t
                    s(t)=s(t)+1;
                    mt_probability(13-t,k)=(s(t)/mpt(13-t,k))*100;
                else
                    continue
                end
                end
                otherwise
                    continue
        end
       end
       s=zeros(1,12);
    end
    mt_prob2=mt_probability(:,1:12);
    mt_prob1=mt_probability(:,13:24);
    mt_prob{m}=[mt_prob1,mt_prob2];
end

figure();
t = tiledlayout(2,3,'TileSpacing','Compact');
clim = [0 90];
nexttile
imagesc(mt_prob{1},clim)
title('(1) SF observed over ZhangYe in 2017');
hcb=colorbar('eastoutside');
colormap(turbo)
set(hcb,'YTick',0:15:90);
set(get(hcb,'Xlabel'),'String','Percentage of Occurrence(%)','FontSize',10)
xticks(1:2:24);
xticklabels({'12','14','16','18','20','22','0','2','4','6','8','10'});
yticks(1:2:12);
yticklabels({'12','10','8','6','4','2'});



nexttile
imagesc(mt_prob{2}, clim)
title('(2) SF observed over ZhangYe in 2018');
hcb=colorbar('eastoutside');
colormap(turbo)
set(hcb,'YTick',0:15:90);
set(get(hcb,'Xlabel'),'String','Percentage of Occurrence(%)','FontSize',10)
xticks(1:2:24);
xticklabels({'12','14','16','18','20','22','0','2','4','6','8','10'});
yticks(1:2:12);
yticklabels({'12','10','8','6','4','2'});

nexttile
imagesc(mt_prob{3}, clim)
title('(3) SF observed over ZhangYe in 2019');
hcb=colorbar('eastoutside');
colormap(turbo)
set(hcb,'YTick',0:15:90);
set(get(hcb,'Xlabel'),'String','Percentage of Occurrence(%)','FontSize',10)
xticks(1:2:24);
xticklabels({'12','14','16','18','20','22','0','2','4','6','8','10'});
yticks(1:2:12);
yticklabels({'12','10','8','6','4','2'});

nexttile
imagesc(mt_prob{4},clim)
title('(4) SF observed over ZhangYe in 2020');
hcb=colorbar('eastoutside');
set(hcb,'YTick',0:15:90);
colormap(turbo)%
set(get(hcb,'Xlabel'),'String','Percentage of Occurrence(%)','FontSize',10)
xticks(1:2:24);
xticklabels({'12','14','16','18','20','22','0','2','4','6','8','10'});
yticks(1:2:12);
yticklabels({'12','10','8','6','4','2'});
ylabel('Month','FontSize',14);

nexttile
imagesc(mt_prob{5},clim)
title('(5) SF observed over ZhangYe in 2021');
xlabel('Local Time','FontSize',14)
hcb=colorbar('eastoutside');
colormap(turbo)
set(hcb,'YTick',0:15:90);
set(get(hcb,'Ylabel'),'String','Percentage of Occurrence(%)','FontSize',10)
xticks(1:2:24);
xticklabels({'12','14','16','18','20','22','0','2','4','6','8','10'});
yticks(1:2:12);
yticklabels({'12','10','8','6','4','2'});

nexttile
imagesc(mt_prob{6},clim)
title('(6) SF observed over ZhangYe in 2022');
hcb=colorbar('eastoutside');
colormap(turbo)
set(hcb,'YTick',0:15:90);
set(get(hcb,'Ylabel'),'String','Percentage of Occurrence(%)','FontSize',10)
xticks(1:2:24);
xticklabels({'12','14','16','18','20','22','0','2','4','6','8','10'});
yticks(1:2:12);
yticklabels({'12','10','8','6','4','2'});


%%%%%%%%%%% Figure6
load('F107.mat');
load('Ap.mat');

%%统计每天探测的次数
day_all = cell(1,6);
for i = 1:6
    time_ofall_ = time_ofall{i};
    day = datenum(time_ofall_(:,1),time_ofall_(:,2),time_ofall_(:,3))-datenum(time_ofall_(:,1),0,0);
    year = time_ofall_(:,1);
    if i == 4
        len = 366;
    else
        len = 365;
    end
    day_all_ = zeros(1,len);
    for j = 1:length(time_ofall_)
        for k =1:len
           if day(j)==k&&year(j)==(i+2016)
               day_all_(k)=day_all_(k)+1;
           end
        end
    end
    day_all{i} = day_all_;
end

%统计每天出现SF的次数
day_exist = cell(1,6);
for i = 1:6
    time_ofexist_ = time_ofexist{i};
    day = datenum(time_ofexist_(:,1),time_ofexist_(:,2),time_ofexist_(:,3))-datenum(time_ofexist_(:,1),0,0);
    year = time_ofexist_(:,1);
    if i == 4
        len = 366;
    else
        len = 365;
    end
    day_exist_ = zeros(1,len);
    for j = 1:length(time_ofexist_)
        for k =1:len
           if day(j)==k && year(j)==(i+2016)
               day_exist_(k)=day_exist_(k)+1;
           end
        end
    end
    day_exist{i} = day_exist_;
end
clear day i j k year time_ofexist_ time_ofall_ day_all_ day_exist_

%统计每一天的发生率
dp = cell(1,6);
for i = 1:6
    day_exist_ = day_exist{i};
    day_all_ = day_all{i};
    p = zeros(length(day_all_),1);
    for j = 1:length(day_all_)
        if(day_all_(j)~=0)
            p(j) = day_exist_(j)/day_all_(j) *100;
        else
            p(j) = NaN;
        end
    end
    dp{i} = p;    
end

dp_ = [dp{1};dp{2};dp{3};dp{4};dp{5};dp{6}];
F107_ = [F107{1};F107{2};F107{3};F107{4};F107{5};F107{6}];
Ap_ = [Ap{1};Ap{2};Ap{3};Ap{4};Ap{5};Ap{6}];
P = [length(time_ofexist{1})/length(time_ofall{1});length(time_ofexist{2})/length(time_ofall{2});length(time_ofexist{3})/length(time_ofall{3})...
    ;length(time_ofexist{4})/length(time_ofall{4});length(time_ofexist{5})/length(time_ofall{5});length(time_ofexist{6})/length(time_ofall{6})];
d = 1:2191;
figure;
subplot(311),
plot(d,Ap_,'k');
set(gca,'xlim',[1 2191]); 
set(gca,'ylim',[0 100]);
set(gca,'xticklabel',[]);
xticks([1,366,731,1096,1462,1827]);
ylabel('Ap')
yticks(40:40:80);
yticklabels({'40','80'})
set(gca,'box','on');
set(gca,'position',[0.15 0.65 0.75 0.27]);
line([1572,1572],[0 100],'linestyle','--','color','k');

subplot(312),
plot(d,F107_,'k');
set(gca,'xlim',[1 2191]); 
set(gca,'ylim',[55 200]);
set(gca,'xticklabel',[]);
xticks([1,366,731,1096,1462,1827]);
ylabel('F10.7')
yticks(100:50:150);
yticklabels({'100','150'})
set(gca,'box','on');
set(gca,'position',[0.15 0.38 0.75 0.27]);
line([1572,1572],[55 200],'linestyle','--','color','k');


subplot(313),
dp_ = smooth(dp_,115,'moving');
plot(d,dp_,'k');

set(gca,'xlim',[1 2191]); 
set(gca,'ylim',[0 30]);
set(gca,'xticklabel',[]);
xticks([1,366,731,1096,1462,1827]);

ylabel('Occurrence Probability(%)')
yticks(10:10:20);
yticklabels({'10','20'});
set(gca,'box','on');
set(gca,'position',[0.15 0.11 0.75 0.27]);
hold on;
y = 180:365:2005;
plot(y,P*100,'--*r','linewidth',1.2);
xticklabels({'2017','2018','2019','2020','2021','2022'})
line([1572,1572],[0 30],'linestyle','--','color','k');
xlabel('Year','FontSize',14);




%%%%%%%%%%% Figure7
time_ofall1922 = {time_ofall2018,time_ofall2022};
time_ofexist1922 = {time_ofexist2018,time_ofexist2022};


p_season= cell(1,2);
for m=1:2
    num_ofexist_day_w=zeros(1,24);%winter
    num_ofexist_day_es=zeros(1,24);%spring
    num_ofexist_day_ea=zeros(1,24);%autumn
    num_ofexist_day_s=zeros(1,24);%summer
    hour_exist=time_ofexist1922{m}(:,4);
    mon_exist = time_ofexist1922{m}(:,2);
    for time=0:23
        for i=1:length(hour_exist)
            if ((hour_exist(i)==time) && (mon_exist(i)==11 || mon_exist(i)==12 || mon_exist(i)==1 || mon_exist(i)==2))
                num_ofexist_day_w(time+1)=num_ofexist_day_w(time+1)+1;
            elseif ((hour_exist(i)==time) && (mon_exist(i)==3 || mon_exist(i)==4))
                num_ofexist_day_es(time+1)=num_ofexist_day_es(time+1)+1;
            elseif ((hour_exist(i)==time) && (mon_exist(i)==5 || mon_exist(i)==6 || mon_exist(i)==7 || mon_exist(i)==8))
                num_ofexist_day_s(time+1)=num_ofexist_day_s(time+1)+1;
            elseif((hour_exist(i)==time) && (mon_exist(i)==9 || mon_exist(i)==10))
                 num_ofexist_day_ea(time+1)=num_ofexist_day_ea(time+1)+1;
            else
                continue
            end
        end
    end
   
    hour_all=time_ofall1922{m}(:,4);
    mon_all=time_ofall1922{m}(:,2);
    num_ofall_day_w=zeros(1,24);
    num_ofall_day_es=zeros(1,24);
    num_ofall_day_ea=zeros(1,24);
    num_ofall_day_s=zeros(1,24);
    for i=1:length(hour_all)
        for time=0:23
        if ((hour_all(i)==time)&& (mon_all(i)==11 || mon_all(i)==12 || mon_all(i)==1 || mon_all(i)==2))
            num_ofall_day_w(time+1)=num_ofall_day_w(time+1)+1;
        elseif ((hour_all(i)==time)&& (mon_all(i)==3 || mon_all(i)==4 ))
             num_ofall_day_es(time+1)=num_ofall_day_es(time+1)+1;
        elseif ((hour_all(i)==time)&& (mon_all(i)==5 || mon_all(i)==6 || mon_all(i)==7 || mon_all(i)==8))
            num_ofall_day_s(time+1)=num_ofall_day_s(time+1)+1;
        elseif ((hour_all(i)==time)&& ( mon_all(i)==9 || mon_all(i)==10))
            num_ofall_day_ea(time+1)=num_ofall_day_ea(time+1)+1;
        else
            continue
        end
        end
    end
  
    probability_d_w=zeros(1,24);
    probability_d_es=zeros(1,24);
    probability_d_ea=zeros(1,24);
    probability_d_s=zeros(1,24);
    for i=1:24
        probability_d_w(i)=(num_ofexist_day_w(i)/num_ofall_day_w(i))*100;
        probability_d_es(i)=(num_ofexist_day_es(i)/num_ofall_day_es(i))*100;
        probability_d_ea(i)=(num_ofexist_day_ea(i)/num_ofall_day_ea(i))*100;
        probability_d_s(i)=(num_ofexist_day_s(i)/num_ofall_day_s(i))*100;
    end
    p_season{m} = {probability_d_es,probability_d_s,probability_d_ea,probability_d_w};
end
clear num_ofall_day_ea num_ofall_day_w num_ofall_day_s num_ofexsist_day_ea num_ofexsist_day_w num_ofexsist_day_s  num_ofall_day_es  num_ofexsist_day_es


figure();
m=1:24;
t = tiledlayout(4,1,'TileSpacing','Compact');
nexttile
plot(m,p_season{1}{1},'-^k')
hold on
plot(m,p_season{2}{1},'--^k')
grid on
set(gca,'Xtick',1:1:24)
set(gca,'xlim',[1 24]);
legend('2019','2022')
title('Spring')

nexttile
plot(m,p_season{1}{2},'-^k')
hold on
plot(m,p_season{2}{2},'--^k')
grid on
set(gca,'Xtick',1:1:24)
set(gca,'xlim',[1 24]);
title('Summer')
ylabel('Percentage of Occurrence(%)','FontSize',14')

nexttile
plot(m,p_season{1}{3},'-^k')
hold on
plot(m,p_season{2}{3},'--^k')
grid on
set(gca,'Xtick',1:1:24)
set(gca,'xlim',[1 24]);
title('Autumn')

nexttile
plot(m,p_season{1}{4},'-^k')
hold on
plot(m,p_season{2}{4},'--^k')
set(gca,'Xtick',1:1:24)
set(gca,'xlim',[1 24]);
grid on
title('Winter')
xlabel('Local Time','FontSize',14)


%%%%%%%%%%% Figure8
figure;
mon1 = 1;
mon2 = 3;
mon3 = 10;
mon4 = 12;
t = tiledlayout(6,4,'TileSpacing','Compact');

for year = 2017:1:2022
    AHTstr1 = sprintf('AHT%04d%02d.mat',year,mon1);
    AHTstr3 = sprintf('AHT%04d%02d.mat',year,mon2);
    AHTstr10 = sprintf('AHT%04d%02d.mat',year,mon3);
    AHTstr12 = sprintf('AHT%04d%02d.mat',year,mon4);
    load(AHTstr1);
    iono_AHT_temp1 = iono_AHT_ZHY;
    clear iono_AHT_ZHY
    load(AHTstr3);
    iono_AHT_temp3 = iono_AHT_ZHY;
    clear iono_AHT_ZHY
    load(AHTstr10);
    iono_AHT_temp10 = iono_AHT_ZHY;
    clear iono_AHT_ZHY
    load(AHTstr12);
    iono_AHT_temp12 = iono_AHT_ZHY;
    clear iono_AHT_ZHY

    x=1:length(iono_AHT_temp1(:,1));
    AmpHead.m_fRangeOfResolution=3.84;
    yHeight=AmpHead.m_fRangeOfResolution:AmpHead.m_fRangeOfResolution:length(iono_AHT_temp1(1,:))*AmpHead.m_fRangeOfResolution;
    y=yHeight;
    ymax = zeros(1,54);
    for i = 1:length(iono_AHT_temp1(:,1))
        [m,ymax(i)] = max(iono_AHT_temp1(i,52:105));
    end
    clim = [1.6 4];
   
    nexttile;
    
    imagesc(x,y,log10((iono_AHT_temp1')),clim);
    hold on
    plot(x,(ymax+51)*3.84,'k','LineWidth',1)
    colormap(jet)
    set(gca,'YDir','normal');
    axis([1 289 100 500]);
    xticks(13:24:289);
    xticklabels({'0','2','4','6','8','10','12','14','16','18','20','22'});
    ylabel(sprintf('%04d',year));

    clear x y;
    x=1:length(iono_AHT_temp3(:,1));
    AmpHead.m_fRangeOfResolution=3.84;
    yHeight=AmpHead.m_fRangeOfResolution:AmpHead.m_fRangeOfResolution:length(iono_AHT_temp3(1,:))*AmpHead.m_fRangeOfResolution;
    y=yHeight;
    ymax = zeros(1,54);
    for i = 1:length(iono_AHT_temp3(:,1))
        [m,ymax(i)] = max(iono_AHT_temp3(i,52:105));
    end
    clim = [1.6 4];
    nexttile;
    
    imagesc(x,y,log10((iono_AHT_temp3')),clim);
    hold on
    plot(x,(ymax+51)*3.84,'k','LineWidth',1)
    colormap(jet)

    set(gca,'YDir','normal');
    axis([1 289 100 500]);
    xticks(13:24:289);
    xticklabels({'0','2','4','6','8','10','12','14','16','18','20','22'});
    set(gca,'YTick',[]);
    clear x y;
    x=1:length(iono_AHT_temp10(:,1));
    AmpHead.m_fRangeOfResolution=3.84;
    yHeight=AmpHead.m_fRangeOfResolution:AmpHead.m_fRangeOfResolution:length(iono_AHT_temp10(1,:))*AmpHead.m_fRangeOfResolution;
    y=yHeight;
    ymax = zeros(1,54);
    for i = 1:length(iono_AHT_temp10(:,1))
        [m,ymax(i)] = max(iono_AHT_temp10(i,52:105));
    end
    clim = [1.6 4];
    nexttile;
    
    imagesc(x,y,log10((iono_AHT_temp10')),clim);
    hold on
    plot(x,(ymax+51)*3.84,'k','LineWidth',1)
    colormap(jet)
    set(gca,'YDir','normal');
    axis([1 289 100 500]);
    xticks(13:24:289);
    xticklabels({'0','2','4','6','8','10','12','14','16','18','20','22'});
    set(gca,'YTick',[]);
    
    clear x y;

    x=1:length(iono_AHT_temp12(:,1));
    AmpHead.m_fRangeOfResolution=3.84;
    yHeight=AmpHead.m_fRangeOfResolution:AmpHead.m_fRangeOfResolution:length(iono_AHT_temp12(1,:))*AmpHead.m_fRangeOfResolution;
    y=yHeight;
    ymax = zeros(1,54);
    for i = 1:length(iono_AHT_temp12(:,1))
        [m,ymax(i)] = max(iono_AHT_temp12(i,52:105));
    end
    clim = [1.6 4];
    nexttile;
    
    imagesc(x,y,log10((iono_AHT_temp12')),clim);
    hold on
    plot(x,(ymax+51)*3.84,'k','LineWidth',1)
    colormap(jet)
    hcb=colorbar('eastoutside');
    set(hcb,'YTick',1.6:0.4:4);
    set(get(hcb,'title'),'String','log10(ΣdB)')
    set(gca,'YDir','normal');
    axis([1 289 100 500]);
    xticks(13:24:289);
    xticklabels({'0','2','4','6','8','10','12','14','16','18','20','22'});
    set(gca,'YTick',[]);

    clear x y;
end
set(gca,'LooseInset',get(gca,'TightInset'))
xlabel(t,'Local Time')
ylabel(t,'Virtual height (km)')

