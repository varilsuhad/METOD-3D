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

%% Physical constants and configuration
mu = 4*pi*10^-7;
ii = 1;
ara = 9:16;

zxx1=ww.veri(ii).Z0(ara,1);
zxy1=ww.veri(ii).Z0(ara,2);
zyx1=ww.veri(ii).Z0(ara,3);
zyy1=ww.veri(ii).Z0(ara,4);

tzx1=ww.veri(ii).T0(ara,1);
tzy1=ww.veri(ii).T0(ara,2);


load('lineersonuc.mat');

zxy1a=abs(zxy1).^2/(mu*2*pi*flist(ii));
zyx1a=abs(zyx1).^2/(mu*2*pi*flist(ii));


zxx2=Zler(ii,ara,1).';
zxy2=Zler(ii,ara,2).';
zyx2=Zler(ii,ara,3).';
zyy2=Zler(ii,ara,4).';

tzx2=Tler(ii,ara,1).';
tzy2=Tler(ii,ara,2).';
zxy2a=abs(zxy2).^2/(mu*2*pi*flist(ii));
zyx2a=abs(zyx2).^2/(mu*2*pi*flist(ii));

load('kuadsonuc.mat');

zxx3=Zler(ii,ara,1).';
zxy3=Zler(ii,ara,2).';
zyx3=Zler(ii,ara,3).';
zyy3=Zler(ii,ara,4).';

tzx3=Tler(ii,ara,1).';
tzy3=Tler(ii,ara,2).';
zxy3a=abs(zxy3).^2/(mu*2*pi*flist(ii));
zyx3a=abs(zyx3).^2/(mu*2*pi*flist(ii));

load('kubiksonuc.mat');


zxx4=Zler(ii,ara,1).';
zxy4=Zler(ii,ara,2).';
zyx4=Zler(ii,ara,3).';
zyy4=Zler(ii,ara,4).';

tzx4=Tler(ii,ara,1).';
tzy4=Tler(ii,ara,2).';

zxy4a=abs(zxy4).^2/(mu*2*pi*flist(ii));
zyx4a=abs(zyx4).^2/(mu*2*pi*flist(ii));

load('p4sonuc.mat');
% load('hpsonucTM1.mat');


zxx5=Zler(ii,ara,1).';
zxy5=Zler(ii,ara,2).';
zyx5=Zler(ii,ara,3).';
zyy5=Zler(ii,ara,4).';

tzx5=Tler(ii,ara,1).';
tzy5=Tler(ii,ara,2).';


zxy5a=abs(zxy5).^2/(mu*2*pi*flist(ii));
% zxy5b=angle(zxy5)/pi*180;
zyx5a=abs(zyx5).^2/(mu*2*pi*flist(ii));
% zyx5b=angle(zyx5)/pi*180;

xi=ww.recv(17:24,1)/1000;



ii=16;

ara=9:16;

zxx1=ww.veri(ii).Z0(ara,1);
zxy1=ww.veri(ii).Z0(ara,2);
zyx1=ww.veri(ii).Z0(ara,3);
zyy1=ww.veri(ii).Z0(ara,4);

tzx1=ww.veri(ii).T0(ara,1);
tzy1=ww.veri(ii).T0(ara,2);



load('lineersonuc.mat');

zxy1b=abs(zxy1).^2/(mu*2*pi*flist(ii));
zyx1b=abs(zyx1).^2/(mu*2*pi*flist(ii));


zxx2=Zler(ii,ara,1).';
zxy2=Zler(ii,ara,2).';
zyx2=Zler(ii,ara,3).';
zyy2=Zler(ii,ara,4).';

tzx2=Tler(ii,ara,1).';
tzy2=Tler(ii,ara,2).';
zxy2b=abs(zxy2).^2/(mu*2*pi*flist(ii));
zyx2b=abs(zyx2).^2/(mu*2*pi*flist(ii));

load('kuadsonuc.mat');

zxx3=Zler(ii,ara,1).';
zxy3=Zler(ii,ara,2).';
zyx3=Zler(ii,ara,3).';
zyy3=Zler(ii,ara,4).';

tzx3=Tler(ii,ara,1).';
tzy3=Tler(ii,ara,2).';
zxy3b=abs(zxy3).^2/(mu*2*pi*flist(ii));
zyx3b=abs(zyx3).^2/(mu*2*pi*flist(ii));

load('kubiksonuc.mat');


zxx4=Zler(ii,ara,1).';
zxy4=Zler(ii,ara,2).';
zyx4=Zler(ii,ara,3).';
zyy4=Zler(ii,ara,4).';

tzx4=Tler(ii,ara,1).';
tzy4=Tler(ii,ara,2).';

zxy4b=abs(zxy4).^2/(mu*2*pi*flist(ii));
zyx4b=abs(zyx4).^2/(mu*2*pi*flist(ii));

load('p4sonuc.mat');

zxx5=Zler(ii,ara,1).';
zxy5=Zler(ii,ara,2).';
zyx5=Zler(ii,ara,3).';
zyy5=Zler(ii,ara,4).';

tzx5=Tler(ii,ara,1).';
tzy5=Tler(ii,ara,2).';


zxy5b=abs(zxy5).^2/(mu*2*pi*flist(ii));
% zxy5b=angle(zxy5)/pi*180;
zyx5b=abs(zyx5).^2/(mu*2*pi*flist(ii));
% zyx5b=angle(zyx5)/pi*180;

xi=ww.recv(17:24,1)/1000;





figure('Position',[                      2733
                      50.6
                    1361.6
                      1020]);

subplot(2,2,1);
plot(xi, zxy1a,'.-','MarkerSize',18,'LineWidth',2);hold on;
plot(xi, zxy2a,'o','LineWidth',2);hold on;
plot(xi, zxy3a,'x','MarkerSize',10,'LineWidth',2);hold on;
plot(xi, zxy4a,'v','LineWidth',2);hold on;
plot(xi, zxy5a,'<','LineWidth',2);hold on;
title('\rho_{xy} (10 Hz)');
ylabel('Apparent Resistivity');
xlim([-21 21]);

subplot(2,2,3);
plot(xi, zyx1a,'.-','MarkerSize',18,'LineWidth',2);hold on;
plot(xi, zyx2a,'o','LineWidth',2);hold on;
plot(xi, zyx3a,'x','MarkerSize',10,'LineWidth',2);hold on;
plot(xi, zyx4a,'v','LineWidth',2);hold on;
plot(xi, zyx5a,'<','LineWidth',2);hold on;
title('\rho_{yx} (10 Hz)');
ylabel('Apparent Resistivity');
xlabel('x(km)');
xlim([-21 21]);



subplot(2,2,2);
plot(xi, zxy1b,'.-','MarkerSize',18,'LineWidth',2);hold on;
plot(xi, zxy2b,'o','LineWidth',2);hold on;
plot(xi, zxy3b,'x','MarkerSize',10,'LineWidth',2);hold on;
plot(xi, zxy4b,'v','LineWidth',2);hold on;
plot(xi, zxy5b,'<','LineWidth',2);hold on;
title('\rho_{xy} (0.001 Hz)');
% ylabel('Apparent Resistivity');
xlim([-21 21]);
legend('Hex. Mesh','Linear','Quadratic','Cubic','Quartic','Location','best');


subplot(2,2,4);
plot(xi, zyx1b,'.-','MarkerSize',18,'LineWidth',2);hold on;
plot(xi, zyx2b,'o','LineWidth',2);hold on;
plot(xi, zyx3b,'x','MarkerSize',10,'LineWidth',2);hold on;
plot(xi, zyx4b,'v','LineWidth',2);hold on;
plot(xi, zyx5b,'<','LineWidth',2);hold on;
title('\rho_{yx} (0.001 Hz)');
% ylabel('Apparent Resistivity');
xlabel('x(km)');
xlim([-21 21]);

