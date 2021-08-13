function y=OLDDEATH(aa)
aa=aa/100;
amount_in_all=zeros(length(aa),6);
for i=1:3
amount_in_all(:,2*i-1)=aa(:,4*i-3).*(1-aa(:,4*i-2)/10);
amount_in_all(:,2*i)=aa(:,4*i-1).*(1-aa(:,4*i)/10);
end
y=1-[sum(sum(amount_in_all(66:91,1:2)))/sum(sum(aa(66:91,1:2:3)))  sum(sum(amount_in_all(66:91,3:4)))/sum(sum(aa(66:91,5:2:7))) sum(sum(amount_in_all(66:91,5:6)))/sum(sum(aa(66:91,9:2:11)))];
end