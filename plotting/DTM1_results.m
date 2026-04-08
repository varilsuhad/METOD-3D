% ========================================================================
% Author: Deniz Varılsüha
% Affiliation: Istanbul Technical University (ITU)
% Contact: deniz.varilsuha@itu.edu.tr
% Journal: Computers & Geosciences
% Manuscript metadata: Included for journal submission compliance
% Last updated: 2026-04-08
% ========================================================================
%% Initialization
clear all;
clc;
close all;

%% Load data
load('DTM1hiersonuc.mat');
load('DTM1_IE_veri.mat');

%% Configuration
P = 2;
ara = [21,14];

a=e{11,P};
xx1=real(a(1:21:end,7));
T=a(1:21,5);
ff=1./T;

mu=4*pi*10^-7;


roa0(:,:,1)=reshape(abs(a(:,1)).^2./(mu*2*pi./a(:,5)),21,14);
roa0(:,:,2)=reshape(abs(a(:,2)).^2./(mu*2*pi./a(:,5)),21,14);
roa0(:,:,3)=reshape(abs(a(:,3)).^2./(mu*2*pi./a(:,5)),21,14);
roa0(:,:,4)=reshape(abs(a(:,4)).^2./(mu*2*pi./a(:,5)),21,14);

E=[
11              0              0              1.0000E-01     1.7067E-11     2.6964E-11     6.2752E-02     6.2730E-02     -6.2764E-02    -6.2731E-02    1.1471E-12     3.3409E-11    
11              0              0              1.8000E-01     -3.1604E-10    -6.4817E-10    4.7191E-02     4.6573E-02     -4.7184E-02    -4.6628E-02    -8.5571E-11    -1.8419E-10   
11              0              0              3.2000E-01     -2.5256E-10    2.3111E-09     3.5996E-02     3.5650E-02     -3.5820E-02    -3.5678E-02    5.4800E-10     1.8551E-10    
11              0              0              5.6000E-01     5.9433E-09     5.1673E-09     2.6839E-02     2.8273E-02     -2.6585E-02    -2.7975E-02    -2.6350E-09    3.6746E-10    
11              0              0              1.0000E+00     -4.1870E-08    -6.9281E-08    1.8650E-02     2.1977E-02     -1.8751E-02    -2.1343E-02    1.5033E-08     -1.3760E-08   
11              0              0              1.8000E+00     6.8678E-07     -5.1498E-08    1.2353E-02     1.6198E-02     -1.2957E-02    -1.5650E-02    1.0055E-07     6.4969E-08    
11              0              0              3.2000E+00     1.1240E-06     3.5666E-06     8.2901E-03     1.1463E-02     -9.1459E-03    -1.1265E-02    -3.8096E-07    6.6386E-07    
11              0              0              5.6000E+00     -1.1845E-05    7.7742E-06     5.8314E-03     7.9982E-03     -6.6587E-03    -8.1706E-03    -2.3081E-06    -1.4497E-06   
11              0              0              1.0000E+01     -3.2235E-05    -2.0299E-05    4.2149E-03     5.4955E-03     -4.7854E-03    -5.9162E-03    2.1841E-06     -4.2596E-06   
11              0              0              1.8000E+01     -2.3644E-06    -6.8133E-05    3.1345E-03     3.7854E-03     -3.3833E-03    -4.2236E-03    6.0959E-06     1.7014E-06    
11              0              0              3.2000E+01     5.5786E-05     -6.8545E-05    2.4003E-03     2.6820E-03     -2.4462E-03    -2.9940E-03    8.7776E-07     6.1614E-06    
11              0              0              5.6000E+01     8.7414E-05     -3.5168E-05    1.8594E-03     1.9664E-03     -1.8245E-03    -2.1478E-03    -3.5252E-06    4.6203E-06    
11              0              0              1.0000E+02     8.8979E-05     -1.6670E-06    1.4162E-03     1.4533E-03     -1.3627E-03    -1.5415E-03    -4.9515E-06    1.8024E-06    
11              0              0              1.8000E+02     7.6108E-05     1.7900E-05     1.0647E-03     1.0790E-03     -1.0160E-03    -1.1147E-03    -4.6497E-06    -1.3484E-07   
11              0              0              3.2000E+02     6.0383E-05     2.5156E-05     8.0094E-04     8.0798E-04     -7.6190E-04    -8.1770E-04    -3.8185E-06    -1.0430E-06   
11              0              0              5.6000E+02     4.6818E-05     2.5834E-05     6.0578E-04     6.0998E-04     -5.7567E-04    -6.0796E-04    -3.0013E-06    -1.3319E-06   
11              0              0              1.0000E+03     3.5398E-05     2.3349E-05     4.5328E-04     4.5586E-04     -4.3057E-04    -4.4892E-04    -2.2844E-06    -1.3169E-06   
11              0              0              1.8000E+03     2.6499E-05     1.9702E-05     3.3778E-04     3.3934E-04     -3.2081E-04    -3.3114E-04    -1.7077E-06    -1.1562E-06   
11              0              0              3.2000E+03     1.9922E-05     1.6061E-05     2.5327E-04     2.5422E-04     -2.4054E-04    -2.4642E-04    -1.2873E-06    -9.7093E-07   
11              0              0              5.6000E+03     1.5075E-05     1.2855E-05     1.9142E-04     1.9200E-04     -1.8180E-04    -1.8519E-04    -9.7565E-07    -7.9214E-07   
11              0              0              1.0000E+04     1.1286E-05     1.0037E-05     1.4323E-04     1.4357E-04     -1.3603E-04    -1.3794E-04    -7.3123E-07    -6.2720E-07   
];

zxx=abs(E(:,5)+sqrt(-1)*E(:,6)).^2./(mu*2*pi./E(:,4));
zxy=abs(E(:,7)+sqrt(-1)*E(:,8)).^2./(mu*2*pi./E(:,4));
zyx=abs(E(:,9)+sqrt(-1)*E(:,10)).^2./(mu*2*pi./E(:,4));
zyy=abs(E(:,11)+sqrt(-1)*E(:,12)).^2./(mu*2*pi./E(:,4));

zxxf=angle(E(:,5)+sqrt(-1)*E(:,6))/pi*180;
zxyf=angle(E(:,7)+sqrt(-1)*E(:,8))/pi*180;
zyxf=angle(E(:,9)+sqrt(-1)*E(:,10))/pi*180;
zyyf=angle(E(:,11)+sqrt(-1)*E(:,12))/pi*180;


load('DTMp4.mat');
zxx2=-squeeze(Zler(:,9,4));
zxy2=-squeeze(Zler(:,9,3));
zyx2=-squeeze(Zler(:,9,2));
zyy2=-squeeze(Zler(:,9,1));

roa7(:,1)=abs(zxx2).^2./(mu*2*pi*flist);
roa7(:,2)=abs(zxy2).^2./(mu*2*pi*flist);
roa7(:,3)=abs(zyx2).^2./(mu*2*pi*flist);
roa7(:,4)=abs(zyy2).^2./(mu*2*pi*flist);

faza7(:,1)=angle(zxx2)/pi*180;
faza7(:,2)=angle(zxy2)/pi*180;
faza7(:,3)=angle(zyx2)/pi*180;
faza7(:,4)=angle(zyy2)/pi*180;

st=9;

mk1='.';
mk2='x';
mk3='v';
mk4='<';
mk5='o';
mk6='>';
% mk7='square';
mk7='+';


h=figure;

set(h,'Position',[                     302.6
                       121
                     839.2
                     730.4]);


subplot(4,2,1);loglog(ff,zxx,'-','linewidth',1); axis([min(ff) max(ff) 10^-6 1]);
hold on; semilogx(ff(1:2:end),squeeze(roa1(1:2:end,st,4)),mk1,'linewidth',2);title('\rho_{xx}','FontSize',12);
hold on; semilogx(ff(2:2:end),squeeze(roa2(2:2:end,st,4)),mk2,'linewidth',2);ylabel('\Omega\cdotm');
hold on; semilogx(ff(1:2:end),squeeze(roa3(1:2:end,st,4)),mk3,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(roa4(2:2:end,st,4)),mk4,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(roa5(1:2:end,st,4)),mk5,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(roa6(2:2:end,st,4)),mk6,'linewidth',2);
hold on; semilogx(ff(1:2:end),(roa7(1:2:end,1)),mk7,'linewidth',2);
xlim([10^-4.1 10^1.1]);xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);


subplot(4,2,2);semilogx(ff,zxxf,'-','linewidth',1);title('\phi_{xx}','FontSize',12);
hold on; semilogx(ff(1:2:end),squeeze(faza1(1:2:end,st,4))+180,mk1,'linewidth',2);ylabel('\circ');
hold on; semilogx(ff(2:2:end),squeeze(faza2(2:2:end,st,4))+180,mk2,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(faza3(1:2:end,st,4))+180,mk3,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(faza4(2:2:end,st,4))+180,mk4,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(faza5(1:2:end,st,4))+180,mk5,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(faza6(2:2:end,st,4))+180,mk6,'linewidth',2);
hold on; semilogx(ff(1:2:end),(faza7(1:2:end,1)),mk7,'linewidth',2);
xlim([10^-4.1 10^1.1]);xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);
xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);
yticks([-200 0 200 360]);

subplot(4,2,3);semilogx(ff,zxy,'-','linewidth',1);title('\rho_{xy}','FontSize',12);
hold on; semilogx(ff(1:2:end),squeeze(roa1(1:2:end,st,3)),mk1,'linewidth',2);ylabel('\Omega\cdotm');
hold on; semilogx(ff(2:2:end),squeeze(roa2(2:2:end,st,3)),mk2,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(roa3(1:2:end,st,3)),mk3,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(roa4(2:2:end,st,3)),mk4,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(roa5(1:2:end,st,3)),mk5,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(roa6(2:2:end,st,3)),mk6,'linewidth',2);
hold on; semilogx(ff(1:2:end),(roa7(1:2:end,2)),mk7,'linewidth',2);
xlim([10^-4.1 10^1.1]);
legend('IE','1st mixed','1st full','2nd mixed','2nd full','3rd mixed','3rd full','4th mixed','location','best','Fontsize',9);
xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);
ylim([40 120]);


subplot(4,2,4);semilogx(ff,zxyf,'-','linewidth',1);title('\phi_{xy}','FontSize',12);
hold on; semilogx(ff(1:2:end),squeeze(faza1(1:2:end,st,3))+180,mk1,'linewidth',2);ylabel('\circ');
hold on; semilogx(ff(2:2:end),squeeze(faza2(2:2:end,st,3))+180,mk2,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(faza3(1:2:end,st,3))+180,mk3,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(faza4(2:2:end,st,3))+180,mk4,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(faza5(1:2:end,st,3))+180,mk5,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(faza6(2:2:end,st,3))+180,mk6,'linewidth',2);
hold on; semilogx(ff(1:2:end),(faza7(1:2:end,2)),mk7,'linewidth',2);
xlim([10^-4.1 10^1.1]);xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);
ylim([43 56]);


subplot(4,2,5);semilogx(ff,zyx,'-','linewidth',1);title('\rho_{yx}','FontSize',12);
hold on; semilogx(ff(1:2:end),squeeze(roa1(1:2:end,st,2)),mk1,'linewidth',2);ylabel('\Omega\cdotm');
hold on; semilogx(ff(2:2:end),squeeze(roa2(2:2:end,st,2)),mk2,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(roa3(1:2:end,st,2)),mk3,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(roa4(2:2:end,st,2)),mk4,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(roa5(1:2:end,st,2)),mk5,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(roa6(2:2:end,st,2)),mk6,'linewidth',2);
hold on; semilogx(ff(1:2:end),(roa7(1:2:end,3)),mk7,'linewidth',2);
xlim([10^-4.1 10^1.1]);xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);
ylim([30 120]);


subplot(4,2,6);semilogx(ff,zyxf,'-','linewidth',1);title('\phi_{yx}','FontSize',12);
hold on; semilogx(ff(1:2:end),squeeze(faza1(1:2:end,st,2))-180,mk1,'linewidth',2);ylabel('\circ');
hold on; semilogx(ff(2:2:end),squeeze(faza2(2:2:end,st,2))-180,mk2,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(faza3(1:2:end,st,2))-180,mk3,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(faza4(2:2:end,st,2))-180,mk4,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(faza5(1:2:end,st,2))-180,mk5,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(faza6(2:2:end,st,2))-180,mk6,'linewidth',2);
hold on; semilogx(ff(1:2:end),(faza7(1:2:end,3)),mk7,'linewidth',2);
xlim([10^-4.1 10^1.1]);xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);
ylim([-137 -127]);

subplot(4,2,7);loglog(ff,zyy,'-','linewidth',1);axis([min(ff) max(ff) 10^-6 10^-2]);xlabel('frequency (Hz)');
hold on; semilogx(ff(1:2:end),squeeze(roa1(1:2:end,st,1)),mk1,'linewidth',2);title('\rho_{yy}','FontSize',12);
hold on; semilogx(ff(2:2:end),squeeze(roa2(2:2:end,st,1)),mk2,'linewidth',2);ylabel('\Omega\cdotm');
hold on; semilogx(ff(1:2:end),squeeze(roa3(1:2:end,st,1)),mk3,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(roa4(2:2:end,st,1)),mk4,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(roa5(1:2:end,st,1)),mk5,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(roa6(2:2:end,st,1)),mk6,'linewidth',2);
hold on; semilogx(ff(1:2:end),(roa7(1:2:end,4)),mk7,'linewidth',2);
xlim([10^-4.1 10^1.1]);xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);


subplot(4,2,8);semilogx(ff,zyyf,'-','linewidth',1);xlabel('frequency (Hz)');title('\phi_{yy}','FontSize',12);
hold on; semilogx(ff(1:2:end),squeeze(faza1(1:2:end,st,1))-180,mk1,'linewidth',2);ylabel('\circ');
hold on; semilogx(ff(2:2:end),squeeze(faza2(2:2:end,st,1))-180,mk2,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(faza3(1:2:end,st,1))-180,mk3,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(faza4(2:2:end,st,1))-180,mk4,'linewidth',2);
hold on; semilogx(ff(1:2:end),squeeze(faza5(1:2:end,st,1))-180,mk5,'linewidth',2);
hold on; semilogx(ff(2:2:end),squeeze(faza6(2:2:end,st,1))-180,mk6,'linewidth',2);
hold on; semilogx(ff(1:2:end),(faza7(1:2:end,4)),mk7,'linewidth',2);
% ylim([-360 360]);
xlim([10^-4.1 10^1.1]);xticks([10^-4 10^-3 10^-2 10^-1 10^0 10^1]);
yticks([-360 -200 0 200]);








