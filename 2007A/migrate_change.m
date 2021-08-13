%迁出村，迁入市速率计算，其中t为xxxx年，aa为该年年初分布情况
function ret=migrate_change(t,aa)
t0=2001;%初始时间
t=t-t0+1;%第t年
load('ratio.mat','CTV_RATIO')
%% 各种城市等级内女性分布情况
woman_ratio_in_city=aa(:,3);%各年龄段女性在市中分布情况
woman_ratio_in_town=aa(:,7);
woman_ratio_in_village=aa(:,11);
woman_ratio_in_CWV=[woman_ratio_in_city woman_ratio_in_town woman_ratio_in_village];
ff=fertility_rate(t);
CTV_ratio=[sum(CTV_RATIO(1:2,t-1)) sum(CTV_RATIO(3:4,t-1)) sum(CTV_RATIO(5:6,t-1))];
%% 性别比拟合
sex_ratio=xlsread('2007年A题附件','Sheet1','B475:D486');
sex_ratio=mean(sex_ratio);

%% 出生率计算
 ff=ff/1000;
child_rate=zeros(1,6);
for i=1:3
woman_amount=woman_ratio_in_CWV(16:50,i)*CTV_ratio(i);
temp(i)=sum(woman_amount.*ff(:,i))*1.23;
child_rate(2*i-1)=temp(i).*sex_ratio(:,i)/(sex_ratio(:,i)+100);
child_rate(2*i)=temp(i).*100/(sex_ratio(:,i)+100);
end
% birth_rate=sum(temp);
%%  根据死亡率求人口分布（迁移前人数分布情况）

amount_in_all=ones(length(aa(:,1)),6);
%此年年末不考虑年龄增长以及迁入迁出情况下人口分布情况
for i=1:3
amount_in_all(:,2*i-1)=aa(:,4*i-3).*(1-aa(:,4*i-2)/10).*CTV_ratio(i);
amount_in_all(:,2*i)=aa(:,4*i-1).*(1-aa(:,4*i)/10).*CTV_ratio(i);
end
for i=length(amount_in_all):-1:1
    if(i==length(amount_in_all))
        amount_in_all(i,:)=amount_in_all(i,:)+amount_in_all(i-1,:);
    elseif i==1
        amount_in_all(i,:)=child_rate;
    else
        amount_in_all(i,:)=amount_in_all(i-1,:);
    end
end   
%% 迁入迁出后人口分布 
for i=1:3
CTV_ratio_temp(i)=sum(amount_in_all(:,2*i-1))+sum(amount_in_all(:,2*i));%迁入迁出前各城市等级所占数量
end
amount_sum=sum(sum(amount_in_all));%增长后数量
CTV_ratio_temp=CTV_ratio_temp/amount_sum;%增长后人口所占比例更新
CTV_ratio=[sum(CTV_RATIO(1:2,t-1)) sum(CTV_RATIO(3:4,t-1)) sum(CTV_RATIO(5:6,t-1))];
village_out_rate=1-CTV_ratio(3)/CTV_ratio_temp(3);%村迁出速率
city_in_rate=(CTV_ratio(1)-CTV_ratio_temp(1))/CTV_ratio(2);%城市迁入速率
ret=[city_in_rate village_out_rate];
end