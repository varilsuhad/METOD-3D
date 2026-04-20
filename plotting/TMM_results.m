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

%% Load reference data
ww = load('usuimodelFEFF.mat');

%% Configuration
ii = 16;
ara = 9:16;

zxx1=ww.veri(ii).Z0(ara,1);
zxy1=ww.veri(ii).Z0(ara,2);
zyx1=ww.veri(ii).Z0(ara,3);
zyy1=ww.veri(ii).Z0(ara,4);

tzx1=ww.veri(ii).T0(ara,1);
tzy1=ww.veri(ii).T0(ara,2);


load('TMM_hp_case_a_result.mat');


zxx2=Zler(ii,ara,1).';
zxy2=Zler(ii,ara,2).';
zyx2=Zler(ii,ara,3).';
zyy2=Zler(ii,ara,4).';

tzx2=Tler(ii,ara,1).';
tzy2=Tler(ii,ara,2).';

load('TMM_hp_case_b_result.mat');
zxx3=Zler(ii,ara,1).';
zxy3=Zler(ii,ara,2).';
zyx3=Zler(ii,ara,3).';
zyy3=Zler(ii,ara,4).';

tzx3=Tler(ii,ara,1).';
tzy3=Tler(ii,ara,2).';


load('TMM_hp_case_c_result.mat');
zxx4=Zler(ii,ara,1).';
zxy4=Zler(ii,ara,2).';
zyx4=Zler(ii,ara,3).';
zyy4=Zler(ii,ara,4).';

tzx4=Tler(ii,ara,1).';
tzy4=Tler(ii,ara,2).';


xi=ww.recv(17:24,1)/1000;

rg=0.05;

mk1='o';
mk2='x';
mk3='v';

nrmssize=8;
form='%0.3e';

figure('position',[196.2 301 1312 672]);

subplot(3,4,1);plot(xi,real(zxx1),'-k','linewidth',2);hold on;
plot(xi,real(zxx2),mk1,'linewidth',2);hold on;
plot(xi,real(zxx3),mk2,'linewidth',2);
plot(xi,real(zxx4),mk3,'linewidth',2);



title('\Re(Zxx)');
v1=sqrt(((real(zxx1)-real(zxx2))'*(real(zxx1)-real(zxx2)))/length(xi));
v1=sqrt((((real(zxx1)-real(zxx2))./real(zxx1))'*((real(zxx1)-real(zxx2))./real(zxx1)))/length(xi));


yl = ylim;
pad =rg* range(yl);
ylim([yl(1)-pad yl(2)+pad])


% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.025, a.Position(2)-0.05, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xticks([]);
xlim([-21 21]);


subplot(3,4,1+4);plot(xi,imag(zxx1),'-k','linewidth',2);hold on;
plot(xi,imag(zxx2),mk1,'linewidth',2);hold on;
plot(xi,imag(zxx3),mk2,'linewidth',2);hold on;
plot(xi,imag(zxx4),mk3,'linewidth',2);hold on;


yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])

title('\Im(Zxx)');

% v1=sqrt(((imag(zxx1)-imag(zxx2))'*(imag(zxx1)-imag(zxx2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1), a.Position(2)-0.05, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xticks([]);
xlim([-21 21]);


subplot(3,4,2);plot(xi,real(zxy1),'-k','linewidth',2);hold on;
plot(xi,real(zxy2),mk1,'linewidth',2);hold on;
plot(xi,real(zxy3),mk2,'linewidth',2);hold on;
plot(xi,real(zxy4),mk3,'linewidth',2);hold on;
legend('hexa','case A','case B','case C','Location','Best');

yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])

title('\Re(Zxy)');
% v1=sqrt(((real(zxy1)-real(zxy2))'*(real(zxy1)-real(zxy2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.05, a.Position(2)+0.1, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xticks([]);
xlim([-21 21]);



subplot(3,4,2+4);plot(xi,imag(zxy1),'-k','linewidth',2);hold on;
plot(xi,imag(zxy2),mk1,'linewidth',2);hold on;
plot(xi,imag(zxy3),mk2,'linewidth',2);hold on;
plot(xi,imag(zxy4),mk3,'linewidth',2);hold on;

yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])

% 
% title('\Im(Zxy)');
% v1=sqrt(((imag(zxy1)-imag(zxy2))'*(imag(zxy1)-imag(zxy2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.07, a.Position(2)+0.1, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xticks([]);
xlim([-21 21]);



subplot(3,4,3);plot(xi,real(zyx1),'-k','linewidth',2);hold on;
plot(xi,real(zyx2),mk1,'linewidth',2);hold on;
plot(xi,real(zyx3),mk2,'linewidth',2);hold on;
plot(xi,real(zyx4),mk3,'linewidth',2);hold on;

title('\Re(Zyx)');
% v1=sqrt(((real(zyx1)-real(zyx2))'*(real(zyx1)-real(zyx2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.07, a.Position(2)-0.03, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xticks([]);
xlim([-21 21]);

yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])


subplot(3,4,3+4);plot(xi,imag(zyx1),'-k','linewidth',2);hold on;
plot(xi,imag(zyx2),mk1,'linewidth',2);hold on;
plot(xi,imag(zyx3),mk2,'linewidth',2);hold on;
plot(xi,imag(zyx4),mk3,'linewidth',2);hold on;

title('\Im(Zyx)');
% v1=sqrt(((imag(zyx1)-imag(zyx2))'*(imag(zyx1)-imag(zyx2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.07, a.Position(2)-0.03, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xticks([]);
xlim([-21 21]);

yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])

subplot(3,4,4);plot(xi,real(zyy1),'-k','linewidth',2);hold on;
plot(xi,real(zyy2),mk1,'linewidth',2);hold on;
plot(xi,real(zyy3),mk2,'linewidth',2);hold on;
plot(xi,real(zyy4),mk3,'linewidth',2);hold on;

title('\Re(Zyy)');
% v1=sqrt(((real(zyy1)-real(zyy2))'*(real(zyy1)-real(zyy2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1), a.Position(2)-0.05, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xticks([]);
xlim([-21 21]);
yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])


subplot(3,4,4+4);plot(xi,imag(zyy1),'-k','linewidth',2);hold on;
plot(xi,imag(zyy2),mk1,'linewidth',2);hold on;
plot(xi,imag(zyy3),mk2,'linewidth',2);hold on;
plot(xi,imag(zyy4),mk3,'linewidth',2);hold on;



title('\Im(Zyy)');
% v1=sqrt(((imag(zyy1)-imag(zyy2))'*(imag(zyy1)-imag(zyy2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.093, a.Position(2)-0.05, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xticks([]);
xlim([-21 21]);
yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])


subplot(3,4,9);plot(xi,real(tzx1),'-k','linewidth',2);hold on;
plot(xi,real(tzx2),mk1,'linewidth',2);hold on;
plot(xi,real(tzx3),mk2,'linewidth',2);hold on;
plot(xi,real(tzx4),mk3,'linewidth',2);hold on;

title('\Re(Wzx)');
% v1=sqrt(((real(tzx1)-real(tzx2))'*(real(tzx1)-real(tzx2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.03, a.Position(2)-0.04, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xlabel('x (km)');
xlim([-21 21]);
yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])


subplot(3,4,10);plot(xi,imag(tzx1),'-k','linewidth',2);hold on;
plot(xi,imag(tzx2),mk1,'linewidth',2);hold on;
plot(xi,imag(tzx3),mk2,'linewidth',2);hold on;
plot(xi,imag(tzx4),mk3,'linewidth',2);hold on;

title('\Im(Wzx)');
% v1=sqrt(((imag(tzx1)-imag(tzx2))'*(imag(tzx1)-imag(tzx2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.03, a.Position(2)-0.05, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xlabel('x (km)');
xlim([-21 21]);
yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])


subplot(3,4,11);plot(xi,real(tzy1),'-k','linewidth',2);hold on;
plot(xi,real(tzy2),mk1,'linewidth',2);hold on;
plot(xi,real(tzy3),mk2,'linewidth',2);hold on;
plot(xi,real(tzy4),mk3,'linewidth',2);hold on;

title('\Re(Wzy)');
% v1=sqrt(((real(tzy1)-real(tzy2))'*(real(tzy1)-real(tzy2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.05, a.Position(2)+0.1, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xlabel('x (km)');
xlim([-21 21]);
yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])


subplot(3,4,12);plot(xi,imag(tzy1),'-k','linewidth',2);hold on;
plot(xi,imag(tzy2),mk1,'linewidth',2);hold on;
plot(xi,imag(tzy3),mk2,'linewidth',2);hold on;
plot(xi,imag(tzy4),mk3,'linewidth',2);hold on;

title('\Im(Wzy)');
% v1=sqrt(((imag(tzy1)-imag(tzy2))'*(imag(tzy1)-imag(tzy2)))/length(xi));
% a = gca; % get the current axis;
% st2=strcat('nRMS=',num2str(v1,form));
% hold on;annotation('textbox', [a.Position(1)+0.05, a.Position(2)+0.1, 0.1, 0.1], 'String', {"nRMS:",st2},'FontSize',nrmssize);
xlabel('x (km)');
xlim([-21 21]);
yl = ylim;
pad = rg * range(yl);
ylim([yl(1)-pad yl(2)+pad])
% grid on;













