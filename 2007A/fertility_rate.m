
function ff=fertility_rate(t)
switch t
    case 1
    ff=xlsread('2007年A题附件','Sheet1','O394:Q428');
    case 2
        ff=xlsread('2007年A题附件','Sheet1','O300:Q334');
    case 3
        ff=xlsread('2007年A题附件','Sheet1','O206:Q240')*10;
    case 4
        ff=xlsread('2007年A题附件','Sheet1','O112:Q146');
    case 5
        ff=xlsread('2007年A题附件','Sheet1','O18:Q52');
    otherwise
        aa=xlsread('2007年A题附件','Sheet1','O18:Q52');%2005年市镇乡中各年龄妇女生育率
        bb=xlsread('2007年A题附件','Sheet1','O112:Q146');
        dd=xlsread('2007年A题附件','Sheet1','O300:Q334');
        ee=xlsread('2007年A题附件','Sheet1','O394:Q428');
        ff=(aa+bb+dd+ee)/4;
end
end

