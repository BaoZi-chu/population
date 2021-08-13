rate=zeros(4,2);
aa=xlsread('2007年A题附件','Sheet1','B97:M187');%2005年年初人口分布情况，即2004年年末
aa=aa/100;
rate(4,:)=migrate_change(2005,aa);
aa=xlsread('2007年A题附件','Sheet1','B191:M281');%2004年年初人口分布情况，即2004年年末
aa=aa/100;
rate(3,:)=migrate_change(2004,aa);
aa=xlsread('2007年A题附件','Sheet1','B285:M375');%2003年年初人口分布情况，即2004年年末
aa=aa/100;
rate(2,:)=migrate_change(2003,aa);
aa=xlsread('2007年A题附件','Sheet1','B379:M469');%2002年年初人口分布情况，即2004年年末
aa=aa/100;
rate(1,:)=migrate_change(2003,aa);
t=1:4;
c_rate=rate(:,1)';%4年城市迁入速率
v_rate=rate(:,2)';%4年农村迁出速率
                    %通过Curve Fitting可拟合得城市迁入速率为 0.006689*exp( -0.2981*t)
                    %农村迁出速率为  0.0009369*exp(-0.2622*t)
 %% 利用模型求解出生率、死亡率
 load('amount.mat')
 birth_rate=zeros(1,30);
 death_rate=zeros(1,30);
 x=1:30;
I=2005;
ratio_change=zeros(30,3);
sex_ratio=zeros(30,2);
 for i=1:30
     if i==1
    [birth_rate(1,i),death_rate(1,i),amount]=caculate(2006,amount_in_all);
     else
      [birth_rate(1,i),death_rate(1,i),amount]=caculate(I,amount);
     end
     I=I+1;
     amount_sum_temp=sum(amount);
     ratio_change(i,:)=[sum(amount_sum_temp(:,1:2)),sum(amount_sum_temp(:,3:4)),sum(amount_sum_temp(:,5:6))];%记录城镇比率变化
     sex_ratio(i,:)=[sum(amount_sum_temp(1:2:5)),sum(amount_sum_temp(2:2:6)) ];
 end
 %% 出生率死亡率拟合及绘图

  x=2006:2035;
 x1=2006:0.01:2035;
 y1=interp1(x,birth_rate,x1,'linear');
 y2=interp1(x,death_rate,x1,'linear');

 subplot(1,2,1)
 plot(x,birth_rate,'*')
 hold on
 plot(x1,y1,'.')
 title('出生率变化曲线')
 hold off
 subplot(1,2,2)
 plot(x,death_rate,'*')
  hold on
 plot(x1,y2,'.')
 title('死亡率变化曲线')
 hold off
 %% 自然增长率拟合及绘图
 clf
  increase_rate=birth_rate-death_rate;
   y3=interp1(x,increase_rate,x1,'linear');
  plot(x,increase_rate,'*')
  hold on
 plot(x1,y3,'.')
 title('自然增长率变化曲线')
 hold off
 %%
 Q0=13.0756;
 increate_vs_2005=zeros(1,15);
 for i=1:30
     if i==1
     increate_vs_2005(i)=(1+increase_rate(i));
     else
          increate_vs_2005(i)=(1+increase_rate(i))*increate_vs_2005(i-1);
     end
     Q=Q0*increate_vs_2005;
 end
  y4=interp1(x,Q,x1,'linear');
  plot(x,Q,'*')
  hold on
 plot(x1,y4,'.')
  hold off
 ylabel('单位:亿人')
 title('人口变化曲线')

 %%
 clf
 x=2006:2035;
  x2=2006:0.01:2035;
 y1=interp1(x,ratio_change(:,1),x2,'linear');
 y2=interp1(x,ratio_change(:,2),x2,'linear');
 y3=interp1(x,ratio_change(:,3),x2,'linear');
 x=2006:2035;
 plot(x2,y1)
 hold on 
 plot(x2,y2)
 plot(x2,y3)
 hold off
 legend('市比率变化','镇比率变化','村比率变化')
 %%
 clf
 x=2006:2035;
  x2=2006:0.01:2035;
  y1=interp1(x,sex_ratio(:,1),x2,'linear');
 y2=interp1(x,sex_ratio(:,2),x2,'linear');
  plot(x,sex_ratio(:,1),'*')
  hold on
 plot(x2,y1,'.')
  plot(x,sex_ratio(:,2),'*')
  plot(x2,y2,'.')
  hold off
  ylim([0.4,0.6])
 title('男女比例变化曲线')
 legend('男性','女性')
 