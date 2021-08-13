%2005年以后的预测模型计算
function [birth_rate,death_rate,amount]=caculate(t,aa)
t0=2001;%初始时间
t=t-t0+1;%第t年
load('death.mat','death')
%% 各种城市等级内女性分布情况
woman_amount=[aa(16:50,2) aa(16:50,4) aa(16:50,6)];
ff=fertility_rate(t);
%% 性别比拟合
sex_ratio=xlsread('2007年A题附件','Sheet1','B475:D486');
sex_ratio=mean(sex_ratio);

%% 出生率计算
 ff=ff/1000;
child_rate=zeros(1,6);
for i=1:3
temp(i)=sum(woman_amount(:,i).*ff(:,i))*1.23;
child_rate(2*i-1)=temp(i).*sex_ratio(:,i)/(sex_ratio(:,i)+100);
child_rate(2*i)=temp(i).*100/(sex_ratio(:,i)+100);
end
 birth_rate=sum(temp);
%%  根据死亡率求人口分布


%此年年末不考虑年龄增长以及迁入迁出情况下人口分布情况
death(:,1:2)=death(:,1:2)*(1.076*exp(-0.02016*t));      
death(:,3:4)=death(:,3:4)*(1.036*exp( -0.009745*t)); 
death(:,5:6)=death(:,5:6)*(1.088*exp(-0.02307*t));      
amount=aa.*(1-death/1e3);
death_rate=1-sum(sum(amount));
%% （迁移前人数分布情况）
for i=length(amount):-1:1
    if(i==length(amount))
        amount(i,:)=amount(i,:)+amount(i-1,:);
    elseif i==1
        amount(i,:)=child_rate;
    else
        amount(i,:)=amount(i-1,:);
    end
end   
%% 迁入迁出后人口分布 
% 
% village_out_rate= 0.008303*exp( -0.2658 *t);%村迁出速率
% 
% city_in_rate=0.001248  *exp(-0.1998   *t);%城市迁入速率
village_out_rate=0.004464135835634;
city_in_rate=7.738278068170901e-04;
 age=0:90;%年龄
p=gaussmf(age,[15 25]);%迁入迁出概率生成
for i=1:3
    CTV_ratio_temp(i)=sum(sum(amount(2*i-1:2*i)));
end
for i=1:6
    amount_temp(:,i)=amount(:,i).*p';
end
k1=city_in_rate*CTV_ratio_temp(2)/sum(sum(amount_temp(:,3:4)));
k2=village_out_rate*CTV_ratio_temp(3)/sum(sum(amount_temp(:,5:6)));%乡村迁出参数

village_out=[amount_temp(:,5:6)*k2];
city_in=[amount_temp(:,3:4)*k1];

amount(:,1:2)=amount(:,1:2)+city_in;
amount(:,5:6)=amount(:,5:6)-village_out;
amount(:,3:4)=amount(:,3:4)-city_in+village_out;
amount_sum=sum(sum(amount));
amount=amount/amount_sum;

end