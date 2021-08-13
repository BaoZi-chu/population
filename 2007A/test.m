clear
clc
%% 65岁以上老人死亡率计算
old_death=zeros(5,3);
aa=xlsread('2007年A题附件','Sheet1','B3:M93');%2005年年初人口分布情况，即2004年年末
old_death(5,:)=OLDDEATH(aa);
aa=xlsread('2007年A题附件','Sheet1','B97:M187');%2005年年初人口分布情况，即2004年年末
old_death(4,:)=OLDDEATH(aa);
aa=xlsread('2007年A题附件','Sheet1','B191:M281');%2004年年初人口分布情况，即2004年年末
old_death(3,:)=OLDDEATH(aa);
aa=xlsread('2007年A题附件','Sheet1','B285:M375');%2003年年初人口分布情况，即2004年年末
old_death(2,:)=OLDDEATH(aa);
aa=xlsread('2007年A题附件','Sheet1','B379:M469');%2002年年初人口分布情况，即2004年年末
old_death(1,:)=OLDDEATH(aa);

plot(old_death)
legend('市65岁以上老人死亡率','镇65岁以上老人死亡率','乡65岁以上老人死亡率')
%% 医疗水平衡量指标
a=[0.1 0.2 0.3 0.4 0.5 ]';
old_death_temp=zeros(1,3);
for i=1:3
    old_death_temp(i)=sum(old_death(:,i).*a)/1.5;
end
for i=1:5
old_death(i,:)=old_death(i,:)./old_death_temp;
end
plot(old_death)
legend('市医疗','镇医疗水平','乡医疗水平')
%% 医疗水平拟合
x=1:5;

city_old_death=old_death(:,1);
% 
%      f(x) = a*exp(b*x)
% Coefficients (with 95% confidence bounds):
%        a =       1.076  (0.9034, 1.249)
%        b =    -0.02016  (-0.06967, 0.02935)
%    f(x) = 1.076*exp(-0.02016*x)

twon_old_death=old_death(:,2);
%      f(x) = a*exp(b*x)
% Coefficients (with 95% confidence bounds):
%        a =       1.036  (0.8438, 1.229)
%        b =   -0.009745  (-0.06639, 0.0469)
village_old_death=old_death(:,3);
% f(x) = a*exp(b*x)
% Coefficients (with 95% confidence bounds):
%        a =       1.088  (0.9227, 1.254)
%        b =    -0.02307  (-0.07014, 0.02401)


