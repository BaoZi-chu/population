%% 城镇化过程中各种类型所占比例函数拟合
%% 数据导入
CTV_RATIO=zeros(6,5);
aa=xlsread('2007年A题附件','Sheet1','S2:S7');
CTV_RATIO(:,5)=aa;
aa=xlsread('2007年A题附件','Sheet1','S97:S102');
CTV_RATIO(:,4)=aa;
aa=xlsread('2007年A题附件','Sheet1','S191:S196');
CTV_RATIO(:,3)=aa;
aa=xlsread('2007年A题附件','Sheet1','S285:S291');
CTV_RATIO(:,2)=aa;
aa=xlsread('2007年A题附件','Sheet1','S379:S384');
CTV_RATIO(:,1)=aa;
a_sum=sum(CTV_RATIO);
CTV_RATIO=CTV_RATIO./a_sum;
save('ratio.mat','CTV_RATIO');
tit=["市男性变化曲线","市女性变化曲线","镇男性变化曲线","镇女性变化曲线","乡男性变化曲线","乡女性变化曲线"];
%% 线性拟合
% aeq=zeros(6,5);
% for(i=1:6)
% x=1:5;
% y=CTV_RATIO(i,:);
% a= polyfit(x,y,4);  % a会返回两个值，[斜率，x=0时y的值]
% xi = 1:0.1:5;
% yi = polyval(a,xi);
% aeq(i,:)=a;
% subplot(3,2,i)
% plot(x,y,'o',xi,yi);
% title(tit(i));
% end


%% 统计各城市类型各年龄妇女生育率,生育率通过平均值求解
aa=xlsread('2007年A题附件','Sheet1','O18:Q52');%2005年市镇乡中各年龄妇女生育率
bb=xlsread('2007年A题附件','Sheet1','O112:Q146');
dd=xlsread('2007年A题附件','Sheet1','O300:Q334');
ee=xlsread('2007年A题附件','Sheet1','O394:Q428');
ff=(aa+bb+dd+ee)/4; %通过平均值拟合
tit=["市女性生育率","镇女性生育率","乡女性生育率"];
%% 拟合2005年市生育率正态分布

%% 女性生育率绘图
for i=1:3
    subplot(2,2,i)
    plot(aa(:,i))
    hold on
    plot(bb(:,i))
    plot(dd(:,i))
    plot(ee(:,i))
    plot(ff(:,i))
    legend('2005年','2004年','2002年','2001年','平均')
    hold off
    title(tit(i));
end
save('fertility_rate.mat','ff')
%% 死亡率拟合
aa=xlsread('2007年A题附件','Sheet1','B3:M93');
bb=xlsread('2007年A题附件','Sheet1','B97:M187');
cc=xlsread('2007年A题附件','Sheet1','B191:M281');
dd=xlsread('2007年A题附件','Sheet1','B285:M375');
ee=xlsread('2007年A题附件','Sheet1','B379:M469');
death_temp=(aa*0.1+bb*0.2+cc*0.3+dd*0.4+ee*0.5)/1.5;
death=zeros(length(death_temp),6);
for i=1:6
death(:,i)=smoothdata(death_temp(:,2*i),'gaussian',3);
end
save('death.mat','death')
clf
plot(death(:,1:2))