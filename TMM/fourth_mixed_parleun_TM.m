% ========================================================================
% Author: Deniz Varılsüha
% Affiliation: Istanbul Technical University (ITU)
% Contact: deniz.varilsuha@itu.edu.tr
% Journal: Computers & Geosciences
% Manuscript metadata: Included for journal submission compliance
% Last updated: 2026-04-08
% ========================================================================
% Forward modeling routine for the TM2/TMM model using mixed fourth-order
% basis functions.
% This script assembles and solves the mixed-order system, then computes
% MT impedance, apparent resistivity, and phase responses.
clear all;clc;close all;
format longG

reset(gpuDevice);
load('TM2_p4.mat');

xa1= [ 0.2500000000000000, 0.5000000000000000, 0.1666666666666667, 0.1666666666666667, 0.1666666666666667];
ya1= [ 0.2500000000000000, 0.1666666666666667, 0.1666666666666667, 0.1666666666666667, 0.5000000000000000];
za1= [ 0.2500000000000000, 0.1666666666666667, 0.1666666666666667, 0.5000000000000000, 0.1666666666666667];
wt1= [-0.8000000000000000, 0.4500000000000000, 0.4500000000000000, 0.4500000000000000, 0.4500000000000000]/6;

xa2= [0.2500000000000000, 0.7857142857142857, 0.0714285714285714, 0.0714285714285714, 0.0714285714285714, ...
     0.1005964238332008, 0.3994035761667992, 0.3994035761667992, 0.3994035761667992, 0.1005964238332008, 0.1005964238332008];
ya2= [0.2500000000000000, 0.0714285714285714, 0.0714285714285714, 0.0714285714285714, 0.7857142857142857, ...
     0.3994035761667992, 0.1005964238332008, 0.3994035761667992, 0.1005964238332008, 0.3994035761667992, 0.1005964238332008];
za2= [0.2500000000000000, 0.0714285714285714, 0.0714285714285714, 0.7857142857142857, 0.0714285714285714, ...
     0.3994035761667992, 0.3994035761667992, 0.1005964238332008, 0.1005964238332008, 0.1005964238332008, 0.3994035761667992];
wt2=[-0.0789333333333333, 0.0457333333333333, 0.0457333333333333, 0.0457333333333333, 0.0457333333333333, ...
     0.1493333333333333, 0.1493333333333333, 0.1493333333333333, 0.1493333333333333, 0.1493333333333333, 0.1493333333333333]/6;

 xa3=[0.2500000000000000, 0.0000000000000000, 0.3333333333333333, 0.3333333333333333, 0.3333333333333333, ...
     0.7272727272727273, 0.0909090909090909, 0.0909090909090909, 0.0909090909090909, 0.4334498464263357, ...
     0.0665501535736643, 0.0665501535736643, 0.0665501535736643, 0.4334498464263357, 0.4334498464263357];
 ya3=[0.2500000000000000, 0.3333333333333333, 0.3333333333333333, 0.3333333333333333, 0.0000000000000000, ...
     0.0909090909090909, 0.0909090909090909, 0.0909090909090909, 0.7272727272727273, 0.0665501535736643, ...
     0.4334498464263357, 0.0665501535736643, 0.4334498464263357, 0.0665501535736643, 0.4334498464263357];
 za3=[0.2500000000000000, 0.3333333333333333, 0.3333333333333333, 0.0000000000000000, 0.3333333333333333, ...
     0.0909090909090909, 0.0909090909090909, 0.7272727272727273, 0.0909090909090909, 0.0665501535736643, ...
     0.0665501535736643, 0.4334498464263357, 0.4334498464263357, 0.4334498464263357, 0.0665501535736643];
 wt3=[0.1817020685825351, 0.0361607142857143, 0.0361607142857143, 0.0361607142857143, 0.0361607142857143, ...
     0.0698714945161738, 0.0698714945161738, 0.0698714945161738, 0.0698714945161738, 0.0656948493683187, ...
     0.0656948493683187, 0.0656948493683187, 0.0656948493683187, 0.0656948493683187, 0.0656948493683187]/6;

  wt4(1:24,1) = [ ...
    0.039922750257869636194, ...
    0.039922750257869636194, ...
    0.039922750257869636194, ...
    0.039922750257869636194, ...
    0.010077211055345822612, ...
    0.010077211055345822612, ...
    0.010077211055345822612, ...
    0.010077211055345822612, ...
    0.055357181543927398338, ...
    0.055357181543927398338, ...
    0.055357181543927398338, ...
    0.055357181543927398338, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286, ...
    0.048214285714285714286 ]/6;

  xyz(1:3,1:24) = [ ...
    0.35619138622025439121,  0.21460287125991520293,  0.21460287125991520293; ...
    0.21460287125991520293,  0.35619138622025439121,  0.21460287125991520293; ...
    0.21460287125991520293,  0.21460287125991520293,  0.35619138622025439121; ...
    0.21460287125991520293,  0.21460287125991520293,  0.21460287125991520293; ...
    0.87797812439616594065,  0.040673958534611353116,  0.040673958534611353116; ...
    0.040673958534611353116,  0.87797812439616594065,  0.040673958534611353116; ...
    0.040673958534611353116,  0.040673958534611353116,  0.87797812439616594065; ...
    0.040673958534611353116,  0.040673958534611353116,  0.040673958534611353116; ...
    0.032986329573173468968,  0.32233789014227551034,  0.32233789014227551034; ...
    0.32233789014227551034,  0.032986329573173468968,  0.32233789014227551034; ...
    0.32233789014227551034,  0.32233789014227551034,  0.032986329573173468968; ...
    0.32233789014227551034,  0.32233789014227551034,  0.32233789014227551034; ...
    0.60300566479164914137,  0.26967233145831580803,  0.063661001875017525299; ...
    0.60300566479164914137,  0.063661001875017525299,  0.26967233145831580803; ...
    0.60300566479164914137,  0.063661001875017525299,  0.063661001875017525299; ...
    0.063661001875017525299,  0.60300566479164914137,  0.26967233145831580803; ...
    0.063661001875017525299,  0.60300566479164914137,  0.063661001875017525299; ...
    0.063661001875017525299,  0.063661001875017525299,  0.60300566479164914137; ...
    0.26967233145831580803,  0.60300566479164914137,  0.063661001875017525299; ...
    0.26967233145831580803,  0.063661001875017525299,  0.60300566479164914137; ...
    0.26967233145831580803,  0.063661001875017525299,  0.063661001875017525299; ...
    0.063661001875017525299,  0.26967233145831580803,  0.60300566479164914137; ...
    0.063661001875017525299,  0.26967233145831580803,  0.063661001875017525299; ...
    0.063661001875017525299,  0.063661001875017525299,  0.26967233145831580803 ]';
  xa4=xyz(1,:);
  ya4=xyz(2,:);

  za4=xyz(3,:);

  xyz=[                    0.25                      0.25                      0.25; ...
         0.765360423009044        0.0782131923303186        0.0782131923303186; ...
        0.0782131923303186        0.0782131923303186        0.0782131923303186; ...
        0.0782131923303186        0.0782131923303186         0.765360423009044; ...
        0.0782131923303186         0.765360423009044        0.0782131923303186; ...
         0.634470350008287         0.121843216663904         0.121843216663904; ...
         0.121843216663904         0.121843216663904         0.121843216663904; ...
         0.121843216663904         0.121843216663904         0.634470350008287; ...
         0.121843216663904         0.634470350008287         0.121843216663904; ...
       0.00238250666073835         0.332539164446421         0.332539164446421; ...
         0.332539164446421         0.332539164446421         0.332539164446421; ...
         0.332539164446421         0.332539164446421       0.00238250666073835; ...
         0.332539164446421       0.00238250666073835         0.332539164446421; ...
                         0                       0.5                       0.5; ...
                       0.5                         0                       0.5; ...
                       0.5                       0.5                         0; ...
                       0.5                         0                         0; ...
                         0                       0.5                         0; ...
                         0                         0                       0.5; ...
                       0.2                       0.1                       0.1; ...
                       0.1                       0.2                       0.1; ...
                       0.1                       0.1                       0.2; ...
                       0.6                       0.1                       0.1; ...
                       0.1                       0.6                       0.1; ...
                       0.1                       0.1                       0.6; ...
                       0.1                       0.2                       0.6; ...
                       0.2                       0.6                       0.1; ...
                       0.6                       0.1                       0.2; ...
                       0.1                       0.6                       0.2; ...
                       0.2                       0.1                       0.6; ...
                       0.6                       0.2                       0.1];

  xa5=xyz(:,1);
  ya5=xyz(:,2);

  za5=xyz(:,3);

  wt5=[  0.109585340796653
         0.063599649146485
         0.063599649146485
         0.063599649146485
         0.063599649146485
         -0.37510644068598
         -0.37510644068598
         -0.37510644068598
         -0.37510644068598
        0.0293485515784412
        0.0293485515784412
        0.0293485515784412
        0.0293485515784412
       0.00582010582010578
       0.00582010582010578
       0.00582010582010578
       0.00582010582010578
       0.00582010582010578
       0.00582010582010578
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911
         0.165343915343911]/6;

  xyz=[
                      0.25                      0.25                      0.25; ...
         0.617587190300083         0.127470936566639         0.127470936566639; ...
         0.127470936566639         0.127470936566639         0.127470936566639; ...
         0.127470936566639         0.127470936566639         0.617587190300083; ...
         0.127470936566639         0.617587190300083         0.127470936566639; ...
         0.903763508822103        0.0320788303926323        0.0320788303926323; ...
        0.0320788303926323        0.0320788303926323        0.0320788303926323; ...
        0.0320788303926323        0.0320788303926323         0.903763508822103; ...
        0.0320788303926323         0.903763508822103        0.0320788303926323; ...
         0.450222904356719         0.049777095643281         0.049777095643281; ...
         0.049777095643281         0.450222904356719         0.049777095643281; ...
         0.049777095643281         0.049777095643281         0.450222904356719; ...
         0.049777095643281         0.450222904356719         0.450222904356719; ...
         0.450222904356719         0.049777095643281         0.450222904356719; ...
         0.450222904356719         0.450222904356719         0.049777095643281; ...
          0.31626955260145          0.18373044739855          0.18373044739855; ...
          0.18373044739855          0.31626955260145          0.18373044739855; ...
          0.18373044739855          0.18373044739855          0.31626955260145; ...
          0.18373044739855          0.31626955260145          0.31626955260145; ...
          0.31626955260145          0.18373044739855          0.31626955260145; ...
          0.31626955260145          0.31626955260145          0.18373044739855; ...
        0.0229177878448171         0.231901089397151         0.231901089397151; ...
         0.231901089397151        0.0229177878448171         0.231901089397151; ...
         0.231901089397151         0.231901089397151        0.0229177878448171; ...
         0.513280033360881         0.231901089397151         0.231901089397151; ...
         0.231901089397151         0.513280033360881         0.231901089397151; ...
         0.231901089397151         0.231901089397151         0.513280033360881; ...
         0.231901089397151        0.0229177878448171         0.513280033360881; ...
        0.0229177878448171         0.513280033360881         0.231901089397151; ...
         0.513280033360881         0.231901089397151        0.0229177878448171; ...
         0.231901089397151         0.513280033360881        0.0229177878448171; ...
        0.0229177878448171         0.231901089397151         0.513280033360881; ...
         0.513280033360881        0.0229177878448171         0.231901089397151; ...
         0.730313427807538        0.0379700484718286        0.0379700484718286; ...
        0.0379700484718286         0.730313427807538        0.0379700484718286; ...
        0.0379700484718286        0.0379700484718286         0.730313427807538; ...
         0.193746475248804        0.0379700484718286        0.0379700484718286; ...
        0.0379700484718286         0.193746475248804        0.0379700484718286; ...
        0.0379700484718286        0.0379700484718286         0.193746475248804; ...
        0.0379700484718286         0.730313427807538         0.193746475248804; ...
         0.730313427807538         0.193746475248804        0.0379700484718286; ...
         0.193746475248804        0.0379700484718286         0.730313427807538; ...
        0.0379700484718286         0.193746475248804         0.730313427807538; ...
         0.730313427807538        0.0379700484718286         0.193746475248804; ...
         0.193746475248804         0.730313427807538        0.0379700484718286];

  xa6=xyz(:,1);
  ya6=xyz(:,2);

  za6=xyz(:,3);

  wt6=[ -0.235962039847756
        0.0244878963560562
        0.0244878963560562
        0.0244878963560562
        0.0244878963560562
       0.00394852063982605
       0.00394852063982605
       0.00394852063982605
       0.00394852063982605
        0.0263055529507371
        0.0263055529507371
        0.0263055529507371
        0.0263055529507371
        0.0263055529507371
        0.0263055529507371
        0.0829803830550589
        0.0829803830550589
        0.0829803830550589
        0.0829803830550589
        0.0829803830550589
        0.0829803830550589
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0254426245481023
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852
        0.0134324384376852]/6;

eleman=sort(eleman,1);
[EL,node_no,edge_no,totkenar,totyuzey,yuzey_no,yuzeybd] = ELkurtet2(node,eleman,rho); %Element matrix

close all;
eleman=eleman';
node=node';

ep=10^-5;

lis=[1 2;1 3; 1 4 ; 2 3; 2 4 ;3 4]; %this is the edge-node list
lis2=[3 2 4 ; 3 1 4; 2 1 4; 2 1 3];
lis3=[1 2 3 4 ; 2 3 4 1; 3 4 1 2; 4 1 2 3];

lisa=[1 2 1 1;1 3 1 1; 1 4 1 1; 2 3 1 1; 2 4 1 1;3 4 1 1;...  %edge1
      1 2 1 1;1 3 1 1; 1 4 1 1; 2 3 1 1; 2 4 1 1;3 4 1 1;...  %edge2
      1 2 1 1;1 3 1 1; 1 4 1 1; 2 3 1 1; 2 4 1 1;3 4 1 1;...  %edge3
      1 2 1 1;1 3 1 1; 1 4 1 1; 2 3 1 1; 2 4 1 1;3 4 1 1;...  %edge4
      3 2 4 1; 3 1 4 1; 2 1 4 1; 2 1 3 1; %face1
      2 4 3 1; 1 4 3 1; 1 4 2 1; 1 3 2 1; %face1
      4 3 2 1; 4 3 1 1; 4 2 1 1; 3 2 1 1; %face2
      3 2 4 1; 3 1 4 1; 2 1 4 1; 2 1 3 1; %face3
      2 4 3 1; 1 4 3 1; 1 4 2 1; 1 3 2 1; %face3
      4 3 2 1; 4 3 1 1; 4 2 1 1; 3 2 1 1; %face3
      3 2 4 1; 3 1 4 1; 2 1 4 1; 2 1 3 1; %face4
      2 4 3 1; 1 4 3 1; 1 4 2 1; 1 3 2 1; %face4
      1 2 3 4; 2 3 4 1; 3 4 1 2; 4 1 2 3; %vol1 +vol2
      3 2 4 1; 3 1 4 1; 2 1 4 1; 2 1 3 1; %face5
      2 4 3 1; 1 4 3 1; 1 4 2 1; 1 3 2 1; %face5
      4 3 2 1; 4 3 1 1; 4 2 1 1; 3 2 1 1; %face5
      3 2 4 1; 3 1 4 1; 2 1 4 1; 2 1 3 1; %face6
      1 2 3 4 ; 2 3 4 1; 3 4 1 2; 4 1 2 3; %vol3
      1 2 3 4 ; 2 3 4 1; 3 4 1 2; 4 1 2 3]; %vol4

d=zeros(4,1);
c=d;b=d;a=d;
le=zeros(6,1);
M=ones(4,4);

Clar=zeros(4,4,3);
Dlar=zeros(4,4);
CDlar=zeros(4,4,4,4);

al=EL(:,12:15);
al=al(al>0);
totnode=max(al)-totkenar;

totel=size(EL,1);

sag=zeros(totkenar*4+totyuzey*12+totel*12,2);

ix1=[];iy1=[];iv1a=[];iv1b=[];sayac1=0; %curl + F
ix3=[];iy3=[];iv3=[];sayac3=0; %D matrix
ix4=[];iy4=[];iv4=[];sayac4=0; %P matrix

rot1=zeros(6,6);  %edge1 edge1
F1=zeros(6,6);    %edge1 edge1
B1=zeros(6,4);

kler=zeros(1,6);

tic
spmd

for ii=1:size(eleman,1)

if(mod(ii,spmdSize)==spmdIndex-1)
else
continue;
end

sigma=1./rho(ii);
nler=eleman(ii,1:4);

XYZ=node(nler,:)';

M(2:end,:)=XYZ;

Ve=det(M)/6;

b(1)=-det(M([1 3 4],[2 3 4]));
b(2)=det(M([1 3 4],[1 3 4]));
b(3)=-det(M([1 3 4],[1 2 4]));
b(4)=det(M([1 3 4],[1 2 3]));

c(1)=det(M([1 2 4],[2 3 4]));
c(2)=-det(M([1 2 4],[1 3 4]));
c(3)=det(M([1 2 4],[1 2 4]));
c(4)=-det(M([1 2 4],[1 2 3]));

d(1)=-det(M([1 2 3],[2 3 4]));
d(2)=det(M([1 2 3],[1 3 4]));
d(3)=-det(M([1 2 3],[1 2 4]));
d(4)=det(M([1 2 3],[1 2 3]));

b=b*sign(Ve);
c=c*sign(Ve);
d=d*sign(Ve);

G=[b c d];

sgn=sign(Ve);
Jabc=[ (-XYZ(1,1)+XYZ(1,2)) (-XYZ(2,1)+XYZ(2,2)) (-XYZ(3,1)+XYZ(3,2));...
       (-XYZ(1,1)+XYZ(1,3)) (-XYZ(2,1)+XYZ(2,3)) (-XYZ(3,1)+XYZ(3,3));...
       (-XYZ(1,1)+XYZ(1,4)) (-XYZ(2,1)+XYZ(2,4)) (-XYZ(3,1)+XYZ(3,4))];

det1=det(Jabc)*sgn;

le(1)=sqrt((XYZ(1,1)-XYZ(1,2))^2+(XYZ(2,1)-XYZ(2,2))^2+(XYZ(3,1)-XYZ(3,2))^2);
le(2)=sqrt((XYZ(1,1)-XYZ(1,3))^2+(XYZ(2,1)-XYZ(2,3))^2+(XYZ(3,1)-XYZ(3,3))^2);
le(3)=sqrt((XYZ(1,1)-XYZ(1,4))^2+(XYZ(2,1)-XYZ(2,4))^2+(XYZ(3,1)-XYZ(3,4))^2);
le(4)=sqrt((XYZ(1,2)-XYZ(1,3))^2+(XYZ(2,2)-XYZ(2,3))^2+(XYZ(3,2)-XYZ(3,3))^2);
le(5)=sqrt((XYZ(1,2)-XYZ(1,4))^2+(XYZ(2,2)-XYZ(2,4))^2+(XYZ(3,2)-XYZ(3,4))^2);
le(6)=sqrt((XYZ(1,3)-XYZ(1,4))^2+(XYZ(2,3)-XYZ(2,4))^2+(XYZ(3,3)-XYZ(3,4))^2);

le(:)=1;

Jxyz=inv(Jabc);
Ve=abs(Ve);

xa=xa6;
ya=ya6;
za=za6;
wt=wt6;

rot1=zeros(84,84);

for i=1:84
    for j=i:84

    i1=lisa(i,1);
    i2=lisa(i,2);
    i3=lisa(i,3);
    i4=lisa(i,4);

    j1=lisa(j,1);
    j2=lisa(j,2);
    j3=lisa(j,3);
    j4=lisa(j,4);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(i4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(i4,xa(jj),ya(jj),za(jj),Jxyz,1);

        if(i>=1 && i<=6) %edge1
        sek1=2*cross(p1,p2);
        elseif(i>=7 && i<=12) %edge2
        sek1=zeros(3,1);
        elseif(i>=13 && i<=18)  %edge3
        sek1=zeros(3,1);
        elseif(i>=19 && i<=24) %edge4
        sek1=zeros(3,1);
        elseif(i>=25 && i<=32) %face1
        sek1=3*cross(L3*p2+L2*p3,p1);
        elseif(i>=33 && i<=36) %face2
        sek1=zeros(3,1);
        elseif(i>=37 && i<=48) %face3
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        elseif(i>=49 && i<=56) %face4
        sek1=zeros(3,1);
        elseif(i>=57 && i<=59) %vol1
        sek1=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        elseif(i>=60 && i<=60) %vol2
        sek1=zeros(3,1);
        elseif(i>=61 && i<=72) %face5
        sek1 = cross((4*L2^3*p3 + 4*L3^3*p2 - 24*L2*L3^2*p2 + 12*L2^2*L3*p2 + 12*L2*L3^2*p3 - 24*L2^2*L3*p3),p1) + cross((6*L1*L3^2*p2 - 3*L1*L2^2*p3 - L3^3*p1 + 6*L2*L3^2*p1 - 3*L2^2*L3*p1 - 3*L1*L3^2*p3 - 6*L1*L2*L3*p2 + 12*L1*L2*L3*p3),p2) + cross((6*L1*L2^2*p3 - 3*L1*L2^2*p2 - L2^3*p1 - 3*L1*L3^2*p2 - 3*L2*L3^2*p1 + 6*L2^2*L3*p1 + 12*L1*L2*L3*p2 - 6*L1*L2*L3*p3),p3);
        elseif(i>=73 && i<=76) %face6
        sek1 = cross((L3^3*p2 - L2^3*p3 + 6*L1*L2^2*p3 - 6*L1*L3^2*p2 - 6*L2*L3^2*p1 + 6*L2^2*L3*p1 - 3*L2^2*L3*p2 + 3*L2*L3^2*p3 + 12*L1*L2*L3*p2 - 12*L1*L2*L3*p3),p1) + cross((L1^3*p3 - L3^3*p1 + 3*L1^2*L3*p1 + 6*L1*L3^2*p2 + 6*L2*L3^2*p1 - 6*L1^2*L2*p3 - 6*L1^2*L3*p2 - 3*L1*L3^2*p3 - 12*L1*L2*L3*p1 + 12*L1*L2*L3*p3),p2) + cross((L2^3*p1 - L1^3*p2 - 3*L1^2*L2*p1 + 3*L1*L2^2*p2 - 6*L1*L2^2*p3 + 6*L1^2*L2*p3 + 6*L1^2*L3*p2 - 6*L2^2*L3*p1 + 12*L1*L2*L3*p1 - 12*L1*L2*L3*p2),p3);
        elseif(i>=77 && i<=80) %vol3
        sek1 = cross((4*L2^2*L3*p4 - 4*L2*L3^2*p4 + 4*L2^2*L4*p3 - 4*L3^2*L4*p2 + 8*L2*L3*L4*p2 - 8*L2*L3*L4*p3),p1) + cross((L1*L3^2*p4 + L3^2*L4*p1 - 2*L1*L2*L3*p4 - 2*L1*L2*L4*p3 - 2*L1*L3*L4*p2 - 2*L2*L3*L4*p1 + 2*L1*L3*L4*p3),p2) + cross((2*L1*L2*L3*p4 - L2^2*L4*p1 - 2*L1*L2*L4*p2 - L1*L2^2*p4 + 2*L1*L2*L4*p3 + 2*L1*L3*L4*p2 + 2*L2*L3*L4*p1),p3) + cross((L1*L3^2*p2 - L1*L2^2*p3 + L2*L3^2*p1 - L2^2*L3*p1 - 2*L1*L2*L3*p2 + 2*L1*L2*L3*p3),p4);
        elseif(i>=81 && i<=84) %vol4
        sek1 = cross((2*L1*L2*L3*p4 - L3*L4^2*p2 - L2*L4^2*p3 + 2*L1*L2*L4*p3 + 2*L1*L3*L4*p2 + 2*L2*L3*L4*p1 - 2*L2*L3*L4*p4),p1) + cross((L1^2*L3*p4 - L3*L4^2*p1 - L1*L4^2*p3 + L1^2*L4*p3 + 2*L1*L3*L4*p1 - 2*L1*L3*L4*p4),p2) + cross((4*L1*L4^2*p2 + 4*L2*L4^2*p1 - 4*L1^2*L2*p4 - 4*L1^2*L4*p2 - 8*L1*L2*L4*p1 + 8*L1*L2*L4*p4),p3) + cross((L1^2*L2*p3 + L1^2*L3*p2 + 2*L1*L2*L3*p1 - 2*L1*L2*L3*p4 - 2*L1*L2*L4*p3 - 2*L1*L3*L4*p2 - 2*L2*L3*L4*p1),p4);
        end

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        if(j>=1 && j<=6) %edge1
        sek2=2*cross(p1,p2);
        elseif(j>=7 && j<=12) %edge2
        sek2=zeros(3,1);
        elseif(j>=13 && j<=18)  %edge3
        sek2=zeros(3,1);
        elseif(j>=19 && j<=24) %edge4
        sek2=zeros(3,1);
        elseif(j>=25 && j<=32) %face1
        sek2=3*cross(L3*p2+L2*p3,p1);
        elseif(j>=33 && j<=36) %face2
        sek2=zeros(3,1);
        elseif(j>=37 && j<=48) %face3
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        elseif(j>=49 && j<=56) %face4
        sek2=zeros(3,1);
        elseif(j>=57 && j<=59) %vol1
        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        elseif(j>=60 && j<=60) %vol2
        sek2=zeros(3,1);
        elseif(j>=61 && j<=72) %face5
        sek2 = cross((4*L2^3*p3 + 4*L3^3*p2 - 24*L2*L3^2*p2 + 12*L2^2*L3*p2 + 12*L2*L3^2*p3 - 24*L2^2*L3*p3),p1) + cross((6*L1*L3^2*p2 - 3*L1*L2^2*p3 - L3^3*p1 + 6*L2*L3^2*p1 - 3*L2^2*L3*p1 - 3*L1*L3^2*p3 - 6*L1*L2*L3*p2 + 12*L1*L2*L3*p3),p2) + cross((6*L1*L2^2*p3 - 3*L1*L2^2*p2 - L2^3*p1 - 3*L1*L3^2*p2 - 3*L2*L3^2*p1 + 6*L2^2*L3*p1 + 12*L1*L2*L3*p2 - 6*L1*L2*L3*p3),p3);
        elseif(j>=73 && j<=76) %face6
        sek2 = cross((L3^3*p2 - L2^3*p3 + 6*L1*L2^2*p3 - 6*L1*L3^2*p2 - 6*L2*L3^2*p1 + 6*L2^2*L3*p1 - 3*L2^2*L3*p2 + 3*L2*L3^2*p3 + 12*L1*L2*L3*p2 - 12*L1*L2*L3*p3),p1) + cross((L1^3*p3 - L3^3*p1 + 3*L1^2*L3*p1 + 6*L1*L3^2*p2 + 6*L2*L3^2*p1 - 6*L1^2*L2*p3 - 6*L1^2*L3*p2 - 3*L1*L3^2*p3 - 12*L1*L2*L3*p1 + 12*L1*L2*L3*p3),p2) + cross((L2^3*p1 - L1^3*p2 - 3*L1^2*L2*p1 + 3*L1*L2^2*p2 - 6*L1*L2^2*p3 + 6*L1^2*L2*p3 + 6*L1^2*L3*p2 - 6*L2^2*L3*p1 + 12*L1*L2*L3*p1 - 12*L1*L2*L3*p2),p3);
        elseif(j>=77 && j<=80) %vol3
        sek2 = cross((4*L2^2*L3*p4 - 4*L2*L3^2*p4 + 4*L2^2*L4*p3 - 4*L3^2*L4*p2 + 8*L2*L3*L4*p2 - 8*L2*L3*L4*p3),p1) + cross((L1*L3^2*p4 + L3^2*L4*p1 - 2*L1*L2*L3*p4 - 2*L1*L2*L4*p3 - 2*L1*L3*L4*p2 - 2*L2*L3*L4*p1 + 2*L1*L3*L4*p3),p2) + cross((2*L1*L2*L3*p4 - L2^2*L4*p1 - 2*L1*L2*L4*p2 - L1*L2^2*p4 + 2*L1*L2*L4*p3 + 2*L1*L3*L4*p2 + 2*L2*L3*L4*p1),p3) + cross((L1*L3^2*p2 - L1*L2^2*p3 + L2*L3^2*p1 - L2^2*L3*p1 - 2*L1*L2*L3*p2 + 2*L1*L2*L3*p3),p4);
        elseif(j>=81 && j<=84) %vol4
        sek2 = cross((2*L1*L2*L3*p4 - L3*L4^2*p2 - L2*L4^2*p3 + 2*L1*L2*L4*p3 + 2*L1*L3*L4*p2 + 2*L2*L3*L4*p1 - 2*L2*L3*L4*p4),p1) + cross((L1^2*L3*p4 - L3*L4^2*p1 - L1*L4^2*p3 + L1^2*L4*p3 + 2*L1*L3*L4*p1 - 2*L1*L3*L4*p4),p2) + cross((4*L1*L4^2*p2 + 4*L2*L4^2*p1 - 4*L1^2*L2*p4 - 4*L1^2*L4*p2 - 8*L1*L2*L4*p1 + 8*L1*L2*L4*p4),p3) + cross((L1^2*L2*p3 + L1^2*L3*p2 + 2*L1*L2*L3*p1 - 2*L1*L2*L3*p4 - 2*L1*L2*L4*p3 - 2*L1*L3*L4*p2 - 2*L2*L3*L4*p1),p4);
        end

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        rot1(i,j)=sum1;
        rot1(j,i)=sum1;

    end
end

M1=zeros(84,84);

xa=xa6;
ya=ya6;
za=za6;
wt=wt6;

for i=1:84
    for j=i:84

    i1=lisa(i,1);
    i2=lisa(i,2);
    i3=lisa(i,3);
    i4=lisa(i,4);

    j1=lisa(j,1);
    j2=lisa(j,2);
    j3=lisa(j,3);
    j4=lisa(j,4);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(i4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(i4,xa(jj),ya(jj),za(jj),Jxyz,1);

        if(i>=1 && i<=6) %edge1
        sek1=L1*p2-L2*p1;
        elseif(i>=7 && i<=12) %edge2
        sek1=L1*p2+L2*p1;
        elseif(i>=13 && i<=18)  %edge3
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        elseif(i>=19 && i<=24) %edge4
        sek1=(3*L1^2*L2-6*L1*L2^2+L2^3)*p1+(L1^3-6*L2*L1^2+3*L1*L2^2)*p2;
        elseif(i>=25 && i<=32) %face1
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        elseif(i>=33 && i<=36) %face2
        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        elseif(i>=37 && i<=48) %face3
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        elseif(i>=49 && i<=56) %face4
        sek1=(L2^2*L3-L2*L3^2)*p1+(2*L1*L2*L3-L1*L3^2)*p2+(L1*L2^2-2*L1*L2*L3)*p3;
        elseif(i>=57 && i<=59) %vol1
        sek1=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        elseif(i>=60 && i<=60) %vol2
        sek1=(L2*L3*L4)*p1+(L1*L3*L4)*p2+(L1*L2*L4)*p3+(L1*L2*L3)*p4;
        elseif(i>=61 && i<=72) %face5
        sek1 = 4*p1*L2*L3*(L2^2 - 3*L2*L3 + L3^2) - p3*L1*L2*(L2^2 - 6*L2*L3 + 3*L3^2) - p2*L1*L3*(3*L2^2 - 6*L2*L3 + L3^2);
        elseif(i>=73 && i<=76) %face6
        sek1 = p2*L1*L3*(L1 - L3)*(L1 - 6*L2 + L3) - p3*L1*L2*(L1 - L2)*(L1 + L2 - 6*L3) - p1*L2*L3*(L2 - L3)*(L2 - 6*L1 + L3);
        elseif(i>=77 && i<=80) %vol3
        sek1 = p4*(L1*L2*L3^2 - L1*L2^2*L3) - p1*(4*L2*L3^2*L4 - 4*L2^2*L3*L4) + p2*(L1*L3^2*L4 - 2*L1*L2*L3*L4) - p3*(L1*L2^2*L4 - 2*L1*L2*L3*L4);
        elseif(i>=81 && i<=84) %vol4
        sek1 = p3*(4*L1*L2*L4^2 - 4*L1^2*L2*L4) - p2*(L1*L3*L4^2 - L1^2*L3*L4) - p1*(L2*L3*L4^2 - 2*L1*L2*L3*L4) + p4*(L1^2*L2*L3 - 2*L1*L2*L3*L4);
        end

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        if(j>=1 && j<=6) %edge1
        sek2=L1*p2-L2*p1;
        elseif(j>=7 && j<=12) %edge2
        sek2=L1*p2+L2*p1;
        elseif(j>=13 && j<=18)  %edge3
        sek2=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        elseif(j>=19 && j<=24) %edge4
        sek2=(3*L1^2*L2-6*L1*L2^2+L2^3)*p1+(L1^3-6*L2*L1^2+3*L1*L2^2)*p2;
        elseif(j>=25 && j<=32) %face1
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        elseif(j>=33 && j<=36) %face2
        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        elseif(j>=37 && j<=48) %face3
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        elseif(j>=49 && j<=56) %face4
        sek2=(L2^2*L3-L2*L3^2)*p1+(2*L1*L2*L3-L1*L3^2)*p2+(L1*L2^2-2*L1*L2*L3)*p3;
        elseif(j>=57 && j<=59) %vol1
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        elseif(j>=60 && j<=60) %vol2
        sek2=(L2*L3*L4)*p1+(L1*L3*L4)*p2+(L1*L2*L4)*p3+(L1*L2*L3)*p4;
        elseif(j>=61 && j<=72) %face5
        sek2 = 4*p1*L2*L3*(L2^2 - 3*L2*L3 + L3^2) - p3*L1*L2*(L2^2 - 6*L2*L3 + 3*L3^2) - p2*L1*L3*(3*L2^2 - 6*L2*L3 + L3^2);
        elseif(j>=73 && j<=76) %face6
        sek2 = p2*L1*L3*(L1 - L3)*(L1 - 6*L2 + L3) - p3*L1*L2*(L1 - L2)*(L1 + L2 - 6*L3) - p1*L2*L3*(L2 - L3)*(L2 - 6*L1 + L3);
        elseif(j>=77 && j<=80) %vol3
        sek2 = p4*(L1*L2*L3^2 - L1*L2^2*L3) - p1*(4*L2*L3^2*L4 - 4*L2^2*L3*L4) + p2*(L1*L3^2*L4 - 2*L1*L2*L3*L4) - p3*(L1*L2^2*L4 - 2*L1*L2*L3*L4);
        elseif(j>=81 && j<=84) %vol4
        sek2 = p3*(4*L1*L2*L4^2 - 4*L1^2*L2*L4) - p2*(L1*L3*L4^2 - L1^2*L3*L4) - p1*(L2*L3*L4^2 - 2*L1*L2*L3*L4) + p4*(L1^2*L2*L3 - 2*L1*L2*L3*L4);
        end

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        M1(i,j)=sum1;
        M1(j,i)=sum1;

    end
end

FF=sigma*M1;
RR=rot1;

rot1=RR(1:6,1:6);
rot4=RR(1:6,25:32);
rot6=RR(25:32,25:32);
rot22=RR(25:32,37:48);
rot23=RR(25:32,57:59);
rot27=RR(37:48,57:59);
rot28=RR(57:59,57:59);
rot26=RR(37:48,37:48);

cc=0;
for i=1:3
    for j=i+1:4
        cc=cc+1;
        kler(cc)=full(edge_no(nler(i),nler(j)));
    end
end

kler2=zeros(1,8);
for i=1:4
    if(i==1)
        al=kler([4 5 6]);
        sw=1;
    elseif(i==2)
        al=kler([2 3 6]);
        sw=2;
    elseif(i==3)
        al=kler([1 3 5]);
        sw=3;
    elseif(i==4)
        al=kler([1 2 4]);
        sw=4;
    end

    al(al<0)=0;

    if(nnz(al)>1)
        al=sort(al(al>0));
        kler2(i)=full(yuzey_no(al(1),al(2)));
        kler2(i+4)=kler2(i)+totyuzey;
        kler2(i+8)=kler2(i)+totyuzey*2;
    elseif(nnz(al)==1)
        kler2(i)=yuzeybd(ii,sw);
        kler2(i+4)=kler2(i)+totyuzey;
        kler2(i+8)=kler2(i)+totyuzey*2;
        if(kler2(i)==0)
        error('0 index');
        end
    else
        kler2(i)=yuzeybd(ii,sw);
        kler2(i+4)=kler2(i);
        kler2(i+8)=kler2(i);
        if(kler2(i)==0)
        error('0 index');
        end
    end
end

kler3=EL(ii,12:15)-totkenar;

klerv2=zeros(1,84);  %all non-phi terms
for i=1:6
    if(kler(i)>0)
    klerv2(i)=kler(i);
    klerv2(i+6)=kler(i)+totkenar;
    klerv2(i+12)=kler(i)+totkenar*2;
    klerv2(i+18)=kler(i)+totkenar*3;
    else
    klerv2(i)=kler(i);
    klerv2(i+6)=kler(i);
    klerv2(i+12)=kler(i);
    klerv2(i+18)=kler(i);
    end
end

for i=25:36
    if(kler2(i-24)>0)
        klerv2(i)=kler2(i-24)+totkenar*4;
        klerv2(i+12)=kler2(i-24)+totkenar*4+totyuzey*3;
    else
        klerv2(i)=kler2(i-24);
        klerv2(i+12)=kler2(i-24);
    end
end

for i=49:56
    if(kler2(i-48)>0)
        klerv2(i)=kler2(i-48)+totkenar*4+totyuzey*6;
    else
        klerv2(i)=kler2(i-48);
    end
end

klerv=[ii ii+totel ii+totel*2 ii+totel*3];
klerv2(57:60)=klerv+totkenar*4+totyuzey*8;

ko=kler2;
ko(ko>0)=ko(ko>0)+totkenar*4+totyuzey*8+totel*4;
klerv2(61:72)=ko;

ko=kler2(1:4);
ko(ko>0)=ko(ko>0)+totkenar*4+totyuzey*11+totel*4;
klerv2(73:76)=ko;

ko=[ii ii+totel ii+totel*2 ii+totel*3 ii+totel*4 ii+totel*5 ii+totel*6 ii+totel*7];
ko(ko>0)=ko(ko>0)+totkenar*4+totyuzey*12+totel*4;
klerv2(77:84)=ko;

iszerov2=length(find(klerv2<0));  %all non-phi terms

    if(iszerov2==0)

        rr=repmat(klerv2',[1 84]); %row indices
        cc=rr'; %column indices;

        ix1(sayac1+1:sayac1+7056)=rr(:);
        iy1(sayac1+1:sayac1+7056)=cc(:);
        iv1a(sayac1+1:sayac1+7056)=RR(:);
        iv1b(sayac1+1:sayac1+7056)=FF(:);
        sayac1=sayac1+3600;
    else
        nke=find(klerv2>0); % these will remain
        rr=repmat(klerv2(nke)',[1 length(nke)]); %row indices
        cc=rr'; %column indices;
        nonz=length(nke)^2;

        RRm=RR(nke,nke);
        FFm=FF(nke,nke);

        ix1(sayac1+1:sayac1+nonz)=rr(:);
        iy1(sayac1+1:sayac1+nonz)=cc(:);
        iv1a(sayac1+1:sayac1+nonz)=RRm(:);
        iv1b(sayac1+1:sayac1+nonz)=FFm(:);
        sayac1=sayac1+nonz;
    end

    iszero=length(find(kler<0));

    if(iszero~=0) %If it does not lie on a boundary, use this block

        %If there is a boundary edge, use this block

        ke=find(kler<0); % these will be removed from the system
        nke=find(kler>0); % these will remain
        nke2=find(kler2(1:8)>0); % these will remain
        nke3=find(kler2>0); % these will remain

        sag_local1=zeros(6,2);
        sag_local4=zeros(8,2);
        sag_local6=zeros(12,2);
        sag_local7=zeros(3,2);

        for i=1:length(ke)

            %Point ordering is important here; vectors are oriented from n1 to n2
            if(ke(i)==1)
                n1=nler(1);
                n2=nler(2);
            elseif(ke(i)==2)
                n1=nler(1);
                n2=nler(3);
            elseif(ke(i)==3)
                n1=nler(1);
                n2=nler(4);
            elseif(ke(i)==4)
                n1=nler(2);
                n2=nler(3);
            elseif(ke(i)==5)
                n1=nler(2);
                n2=nler(4);
            elseif(ke(i)==6)
                n1=nler(3);
                n2=nler(4);
            end

            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if(kler(ke(i))==-5 || kler(ke(i))==-6)
                if( abs(xyz1(3)-xyz2(3))>ep)
                    if(abs(xyz1(2)-xyz2(2))<ep)
                    kler(ke(i))=-3;
                    end

                    if(abs(xyz1(1)-xyz2(1))<ep)
                    kler(ke(i))=-1;
                    end
                end
            end

            %Here I check which surface it lies on
            if(kler(ke(i))==-1 || kler(ke(i))==-2) %left/right: angle in the y-z plane
            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(1)-xyz2(1))>ep)
            error('x should be the same');
            end

            if( abs(xyz1(2)-xyz2(2))<ep)
                continue;
            end

            nor(1)=xyz2(2)-xyz1(2);
            nor(2)=(xyz2(3)-xyz1(3));
            aci=atan2(nor(2),nor(1))/pi*180;

            aci=360-aci;

            vec=[1;0];
            R1=[cosd(aci) -sind(aci) ; sind(aci) cosd(aci)];
            al=R1*vec;
            val=al(1); % value of the left or right edge

            % val=1;

            sag_local1(nke,1)=sag_local1(nke,1)-rot1(nke,ke(i))*val;
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot4(ke(i),nke2)'*val;

            %
            elseif(kler(ke(i))==-3 || kler(ke(i))==-4) %front/back: angle in the x-z plane

            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(2)-xyz2(2))>ep)
            error('y should be the same');
            end

            if( abs(xyz1(1)-xyz2(1))<ep)
                continue;
            end

            nor(1)=xyz2(1)-xyz1(1);
            nor(2)=(xyz2(3)-xyz1(3));
            aci=atan2(nor(2),nor(1))/pi*180;

            aci=360-aci;

            vec=[1;0];
            R1=[cosd(aci) -sind(aci) ; sind(aci) cosd(aci)];
            al=R1*vec;
            val=al(1); % this is the value of the front or back edge

            % val=1;

            sag_local1(nke,2)=sag_local1(nke,2)-rot1(nke,ke(i))*val;
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot4(ke(i),nke2)'*val;

            elseif(kler(ke(i))==-5 || kler(ke(i))==-6) %top/bottom: angle in the x-y plane

            if( abs(xyz1(3)-xyz2(3))>ep)
            error('z should be the same');
            end

            xyz1=node(n1,:);
            xyz2=node(n2,:);
            nor(1)=xyz2(1)-xyz1(1);
            nor(2)=xyz2(2)-xyz1(2);
            aci=atan2(nor(2),nor(1))/pi*180;

            % aci=360-aci;

            %I apply Ex
            vec=[1;0];
            R1=[cosd(aci) -sind(aci) ; sind(aci) cosd(aci)];
            al=R1*vec;
            val=al(1); % top or bottom
            % val=al(2);

            sag_local1(nke,2)=sag_local1(nke,2)-rot1(nke,ke(i))*val;
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot4(ke(i),nke2)'*val;

            val=al(2);

            sag_local1(nke,1)=sag_local1(nke,1)-rot1(nke,ke(i))*val;
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot4(ke(i),nke2)'*val;

            else
            error('must be between 1 and 6');

            end
        end

            sag(kler(nke),:)=sag(kler(nke),:)+sag_local1(nke,:);
            sag(kler2(nke2)+totkenar*4,:)=sag(kler2(nke2)+totkenar*4,:)+sag_local4(nke2,:);
         end

    iszero2=length(find(kler2<0));

    if(iszero2~=0)
        nke=find(kler>0); % these will remain
        nke2=find(kler2(1:8)>0); % these will remain
        nke3=find(kler2>0); % these will remain
        ke=find(kler2<0); % these will be removed from the system

        sag_local1=zeros(6,2);
        sag_local4=zeros(8,2);
        sag_local6=zeros(12,2);
        sag_local7=zeros(3,2);

        % lis2=[3 2 4 ; 3 1 4; 2 1 4; 2 1 3];

        for i=1:length(ke)

            %Point ordering is important here; vectors are oriented from n1 to n2
            if(ke(i)==1)
                n1=nler(2);
                n2=nler(4);
            elseif(ke(i)==2)
                n1=nler(1);
                n2=nler(4);
            elseif(ke(i)==3)
                n1=nler(1);
                n2=nler(4);
            elseif(ke(i)==4)
                n1=nler(1);
                n2=nler(3);
            elseif(ke(i)==5)
                n1=nler(2);
                n2=nler(3);
            elseif(ke(i)==6)
                n1=nler(1);
                n2=nler(3);
            elseif(ke(i)==7)
                n1=nler(1);
                n2=nler(2);
            elseif(ke(i)==8)
                n1=nler(1);
                n2=nler(2);
            elseif(ke(i)==9)
                n1=nler(3);
                n2=nler(4);
            elseif(ke(i)==10)
                n1=nler(3);
                n2=nler(4);
            elseif(ke(i)==11)
                n1=nler(2);
                n2=nler(4);
            elseif(ke(i)==12)
                n1=nler(2);
                n2=nler(3);
            end

            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(1)-xyz2(1))<ep)
            kler2(ke(i))=-1;
            % error('x should be the same');
            elseif(abs(xyz1(2)-xyz2(2))<ep)
            kler2(ke(i))=-3;
            else
            kler2(ke(i))=-5;
            end

            if(kler2(ke(i))==-1 || kler2(ke(i))==-2) %left/right: angle in the y-z plane
            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(1)-xyz2(1))>ep)
            error('x should be the same');
            end

            if( abs(xyz1(2)-xyz2(2))<ep)
                continue;
            end

            nor(1)=xyz2(2)-xyz1(2);
            nor(2)=(xyz2(3)-xyz1(3));
            aci=atan2(nor(2),nor(1))/pi*180;

            aci=360-aci;

            vec=[1;0];
            R1=[cosd(aci) -sind(aci) ; sind(aci) cosd(aci)];
            al=R1*vec;
            val=al(1); % value of the left or right edge

            % val=1;
            if(ke(i)<=8)
            sag_local1(nke,1)=sag_local1(nke,1)-rot4(nke,ke(i))*val;
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot6(nke2,ke(i))*val;
            sag_local6(nke3,1)=sag_local6(nke3,1)-rot22(ke(i),nke3)'*val;
            sag_local7(:,1)=sag_local7(:,1)-rot23(ke(i),:)'*val;
            end
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot22(nke2,ke(i))*val;
            sag_local6(nke3,1)=sag_local6(nke3,1)-rot26(nke3,ke(i))*val;
            sag_local7(:,1)=sag_local7(:,1)-rot27(ke(i),:)'*val;

            elseif(kler2(ke(i))==-3 || kler2(ke(i))==-4) %front/back: angle in the x-z plane

            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(2)-xyz2(2))>ep)
            error('y should be the same');
            end

            if( abs(xyz1(1)-xyz2(1))<ep)
                continue;
            end

            nor(1)=xyz2(1)-xyz1(1);
            nor(2)=(xyz2(3)-xyz1(3));
            aci=atan2(nor(2),nor(1))/pi*180;

            aci=360-aci;

            vec=[1;0];
            R1=[cosd(aci) -sind(aci) ; sind(aci) cosd(aci)];
            al=R1*vec;
            val=al(1); % this is the value of the front or back edge

            if(ke(i)<=8)
            sag_local1(nke,2)=sag_local1(nke,2)-rot4(nke,ke(i))*val;
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot6(nke2,ke(i))*val;
            sag_local6(nke3,2)=sag_local6(nke3,2)-rot22(ke(i),nke3)'*val;
            sag_local7(:,2)=sag_local7(:,2)-rot23(ke(i),:)'*val;
            end
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot22(nke2,ke(i))*val;
            sag_local6(nke3,2)=sag_local6(nke3,2)-rot26(nke3,ke(i))*val;
            sag_local7(:,2)=sag_local7(:,2)-rot27(ke(i),:)'*val;

            elseif(kler2(ke(i))==-5 || kler2(ke(i))==-6) %top/bottom: angle in the x-y plane

            if( abs(xyz1(3)-xyz2(3))>ep)
            error('z should be the same');
            end

            % %Disabling this section does not change anything
            %
            xyz1=node(n1,:);
            xyz2=node(n2,:);
            nor(1)=xyz2(1)-xyz1(1);
            nor(2)=xyz2(2)-xyz1(2);
            aci=atan2(nor(2),nor(1))/pi*180;

            % aci=360-aci;

            %I apply Ex
            vec=[1;0];
            R1=[cosd(aci) -sind(aci) ; sind(aci) cosd(aci)];
            al=R1*vec;
            val=al(1); % top or bottom
            % val=al(2); % top or bottom

            if(ke(i)<=8)
            sag_local1(nke,2)=sag_local1(nke,2)-rot4(nke,ke(i))*val;
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot6(nke2,ke(i))*val;
            sag_local6(nke3,2)=sag_local6(nke3,2)-rot22(ke(i),nke3)'*val;
            sag_local7(:,2)=sag_local7(:,2)-rot23(ke(i),:)'*val;
            end
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot22(nke2,ke(i))*val;
            sag_local6(nke3,2)=sag_local6(nke3,2)-rot26(nke3,ke(i))*val;
            sag_local7(:,2)=sag_local7(:,2)-rot27(ke(i),:)'*val;

            val=al(2); % top or bottom

            if(ke(i)<=8)
            sag_local1(nke,1)=sag_local1(nke,1)-rot4(nke,ke(i))*val;
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot6(nke2,ke(i))*val;
            sag_local6(nke3,1)=sag_local6(nke3,1)-rot22(ke(i),nke3)'*val;
            sag_local7(:,1)=sag_local7(:,1)-rot23(ke(i),:)'*val;
            end
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot22(nke2,ke(i))*val;
            sag_local6(nke3,1)=sag_local6(nke3,1)-rot26(nke3,ke(i))*val;
            sag_local7(:,1)=sag_local7(:,1)-rot27(ke(i),:)'*val;

            else
            error('must be between 1 and 6');

            end
        end

        sag(kler(nke),:)=sag(kler(nke),:)+sag_local1(nke,:);
        sag(kler2(nke2)+totkenar*4,:)=sag(kler2(nke2)+totkenar*4,:)+sag_local4(nke2,:);
        sag(kler2(nke3)+totkenar*4+totyuzey*3,:)=sag(kler2(nke3)+totkenar*4+totyuzey*3,:)+sag_local6(nke3,:);
        sag(klerv(1:3)+totkenar*4+totyuzey*8,:)=sag(klerv(1:3)+totkenar*4+totyuzey*8,:)+sag_local7;

    end

end

% return

R1=sparse(ix1,iy1,iv1a,totkenar*4+totyuzey*12+totel*12,totkenar*4+totyuzey*12+totel*12); % double curl
M1=sparse(ix1,iy1,iv1b,totkenar*4+totyuzey*12+totel*12,totkenar*4+totyuzey*12+totel*12); %

R1=spmdReduce(@plus,R1,1);
M1=spmdReduce(@plus,M1,1);

sag=spmdReduce(@plus,sag,1);

end

R1=R1{1};
M1=M1{1};

sag=sag{1};

toc

ww=load('usuimodelFEFF.mat');
ff=ww.f;

for kk=1:length(ff)

f=ff(kk); % frequencies
mu=4*pi*10^-7;
w=2*pi*f;

kat=sqrt(-1)*w*mu;

kat2=mu;
kat3=mu*sqrt(-1)/w;

B1=[R1+kat*M1];
Amatris1=[B1];
bsag=sag(:,:);

[v0,r0,c0]=sparse2csr(Amatris1);
rowg=gpuArray(r0);
colg=gpuArray(c0);
valg=gpuArray(v0);
bg=gpuArray(sag);

tic
[xx]=LUcuDSS(rowg,colg,valg,complex(bg),int32(2)); %sweeping
toc

tic
[xx]=LUcuDSSMG(rowg,colg,valg,complex(bg),int32(2),int32(8)); %sweeping
toc

relres=norm(Amatris1*xx-sag)/norm(sag);
fprintf("Direct solution relative residual=%e\n",relres);

xx=gather(xx);

x1=xx(:,1);
x2=xx(:,2);

M=ones(4,4);
mu=4*pi*10^-7;
clear G le kler a b c d
for jj=1:size(recv,1)

    ii=recv(jj,4);

    nler=eleman(ii,1:4);

    XYZ=node(nler,:)';

    % x0=recv(jj,1);
    % y0=recv(jj,2);
    x0=mean(XYZ(1,:));
    y0=mean(XYZ(2,:));
    z0=mean(XYZ(3,:));

    M(2:end,:)=XYZ;

    Ve=det(M)/6;

    a(1)=det(M([2 3 4],[2 3 4]));
    a(2)=-det(M([2 3 4],[1 3 4]));
    a(3)=det(M([2 3 4],[1 2 4]));
    a(4)=-det(M([2 3 4],[1 2 3]));

    b(1)=-det(M([1 3 4],[2 3 4]));
    b(2)=det(M([1 3 4],[1 3 4]));
    b(3)=-det(M([1 3 4],[1 2 4]));
    b(4)=det(M([1 3 4],[1 2 3]));

    c(1)=det(M([1 2 4],[2 3 4]));
    c(2)=-det(M([1 2 4],[1 3 4]));
    c(3)=det(M([1 2 4],[1 2 4]));
    c(4)=-det(M([1 2 4],[1 2 3]));

    d(1)=-det(M([1 2 3],[2 3 4]));
    d(2)=det(M([1 2 3],[1 3 4]));
    d(3)=-det(M([1 2 3],[1 2 4]));
    d(4)=det(M([1 2 3],[1 2 3]));

    a=a*sign(Ve);
    b=b*sign(Ve);
    c=c*sign(Ve);
    d=d*sign(Ve);

    G=[b(:) c(:) d(:)];

    % sign(Ve)
    Ve=abs(Ve);

    cc=0;
    clear kler
    for i=1:3
        for j=i+1:4
            cc=cc+1;
            kler(cc)=full(edge_no(nler(i),nler(j)));
            kler(cc+6)=full(edge_no(nler(i),nler(j)))+totkenar;
            kler(cc+12)=full(edge_no(nler(i),nler(j)))+totkenar*2;
            kler(cc+18)=full(edge_no(nler(i),nler(j)))+totkenar*3;
        end
    end

    kler2=zeros(1,8);
    for i=1:4
        if(i==1)
            al=kler([4 5 6]);
            sw=1;
        elseif(i==2)
            al=kler([2 3 6]);
            sw=2;
        elseif(i==3)
            al=kler([1 3 5]);
            sw=3;
        elseif(i==4)
            al=kler([1 2 4]);
            sw=4;
        end

        al(al<0)=0;

        if(nnz(al)>1)
            al=sort(al(al>0));
            kler2(i)=full(yuzey_no(al(1),al(2)));
            kler2(i+4)=kler2(i)+totyuzey;
            kler2(i+8)=kler2(i)+totyuzey*2;
            kler2(i+12)=kler2(i)+totyuzey*3;
            kler2(i+16)=kler2(i)+totyuzey*4;
            kler2(i+20)=kler2(i)+totyuzey*5;
            kler2(i+24)=kler2(i)+totyuzey*6;
            kler2(i+28)=kler2(i)+totyuzey*7;

        elseif(nnz(al)==1)
            kler2(i)=yuzeybd(ii,sw);
            kler2(i+4)=kler2(i)+totyuzey;
            kler2(i+8)=kler2(i)+totyuzey*2;
            kler2(i+12)=kler2(i)+totyuzey*3;
            kler2(i+16)=kler2(i)+totyuzey*4;
            kler2(i+20)=kler2(i)+totyuzey*5;
            kler2(i+24)=kler2(i)+totyuzey*6;
            kler2(i+28)=kler2(i)+totyuzey*7;
            if(kler2(i)==0)
            error('0 index');
            end
        else
            kler2(i)=yuzeybd(ii,sw);
            kler2(i+4)=kler2(i);
            kler2(i+8)=kler2(i);
            kler2(i+12)=kler2(i);
            kler2(i+16)=kler2(i);
            kler2(i+20)=kler2(i);
            kler2(i+24)=kler2(i);
            kler2(i+28)=kler2(i);

            if(kler2(i)==0)
            error('0 index');
            end
        end
    end

    klern=EL(ii,12:15)-totkenar;
    klern=[klern kler(1:18)+totnode kler2(1:12)+totnode+totkenar*3 ii+totnode+totkenar*3+totyuzey*3]+totkenar*4+totyuzey*8+totel*4;

    kler2=kler2+totkenar*4;

    kler3=[ii ii+totel ii+totel*2 ii+totel*3]+totkenar*4+totyuzey*8;

        kler4=[kler2(1:16)]+totkenar*4+totyuzey*8+totel;
        kler5=[ii ii+totel ii+totel*2 ii+totel*3 ii+totel*4 ii+totel*5 ii+totel*6 ii+totel*7]+totkenar*4+totyuzey*12+totel*4;

    le(1)=sqrt((XYZ(1,1)-XYZ(1,2))^2+(XYZ(2,1)-XYZ(2,2))^2+(XYZ(3,1)-XYZ(3,2))^2);
    le(2)=sqrt((XYZ(1,1)-XYZ(1,3))^2+(XYZ(2,1)-XYZ(2,3))^2+(XYZ(3,1)-XYZ(3,3))^2);
    le(3)=sqrt((XYZ(1,1)-XYZ(1,4))^2+(XYZ(2,1)-XYZ(2,4))^2+(XYZ(3,1)-XYZ(3,4))^2);
    le(4)=sqrt((XYZ(1,2)-XYZ(1,3))^2+(XYZ(2,2)-XYZ(2,3))^2+(XYZ(3,2)-XYZ(3,3))^2);
    le(5)=sqrt((XYZ(1,2)-XYZ(1,4))^2+(XYZ(2,2)-XYZ(2,4))^2+(XYZ(3,2)-XYZ(3,4))^2);
    le(6)=sqrt((XYZ(1,3)-XYZ(1,4))^2+(XYZ(2,3)-XYZ(2,4))^2+(XYZ(3,3)-XYZ(3,4))^2);
    le(:)=1;

    for i=1:4
    duzkose(i,1)=1/(6*Ve)*(a(i)+b(i)*x0+c(i)*y0+d(i)*z0);
    end

    for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);

    L1=duzkose(i1);
    L2=duzkose(i2);
    p1=G(i1,:);
    p2=G(i2,:);

    rotkenar(i,:)=2*cross(p1,p2)/(6*Ve)^2*le(i);
    rotkenar(i+6,:)=0;
    rotkenar(i+12,:)=0;
    rotkenar(i+18,:)=0;

    duzkenar(i,:)=(L1*p2-L2*p1)/(6*Ve)*le(i);
    duzkenar(i+6,:)=(L1*p2+L2*p1)/(6*Ve)*le(i);
    duzkenar(i+12,:)=((2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2)/(6*Ve)*le(i);
    duzkenar(i+18,:)=((3*L1^2*L2-6*L1*L2^2+L2^3)*p1+(L1^3-6*L2*L1^2+3*L1*L2^2)*p2)/(6*Ve)*le(i);
    end

    for i=1:4

    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar2(i,:)=(2*L2*L3*p1-L1*L2*p3-L1*L3*p2)/(6*Ve);
    rotkenar2(i,:)=3*cross(L3*p2+L2*p3,p1)/(6*Ve)^2;

    i1=lis2(i,2);
    i2=lis2(i,3);
    i3=lis2(i,1);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar2(i+4,:)=(2*L2*L3*p1-L1*L2*p3-L1*L3*p2)/(6*Ve);
    rotkenar2(i+4,:)=3*cross(L3*p2+L2*p3,p1)/(6*Ve)^2;

    i1=lis2(i,3);
    i2=lis2(i,1);
    i3=lis2(i,2);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar2(i+8,:)=(L2*L3*p1+L1*L2*p3+L1*L3*p2)/(6*Ve);
    rotkenar2(i+8,:)=0;

    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar2(i+12,:)=((3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3)/(6*Ve);
    rotkenar2(i+12,:)=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1)/(6*Ve)^2;

    i1=lis2(i,2);
    i2=lis2(i,3);
    i3=lis2(i,1);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar2(i+16,:)=((3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3)/(6*Ve);
    rotkenar2(i+16,:)=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1)/(6*Ve)^2;

    i1=lis2(i,3);
    i2=lis2(i,1);
    i3=lis2(i,2);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar2(i+20,:)=((3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3)/(6*Ve);
    rotkenar2(i+20,:)=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1)/(6*Ve)^2;

    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar2(i+24,:)=((L2^2*L3-L2*L3^2)*p1+(2*L1*L2*L3-L1*L3^2)*p2+(L1*L2^2-2*L1*L2*L3)*p3)/(6*Ve);
    rotkenar2(i+24,:)=0;

    i1=lis2(i,2);
    i2=lis2(i,3);
    i3=lis2(i,1);
    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar2(i+28,:)=((L2^2*L3-L2*L3^2)*p1+(2*L1*L2*L3-L1*L3^2)*p2+(L1*L2^2-2*L1*L2*L3)*p3)/(6*Ve);
    rotkenar2(i+28,:)=0;

    end

    for i=1:3

    i1=lis3(i,1);
    i2=lis3(i,2);
    i3=lis3(i,3);
    i4=lis3(i,4);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    L4=duzkose(i4);

    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);
    p4=G(i4,:);

    duzkenar3(i,:)=(3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4)/(6*Ve);
    rotkenar3(i,:)=(4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1))/(6*Ve)^2;
    end

    for i=1:1
    i1=lis3(i,1);
    i2=lis3(i,2);
    i3=lis3(i,3);
    i4=lis3(i,4);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    L4=duzkose(i4);

    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);
    p4=G(i4,:);

    duzkenar3(i+3,:)=((L2*L3*L4)*p1+(L1*L3*L4)*p2+(L1*L2*L4)*p3+(L1*L2*L3)*p4)/(6*Ve);
    rotkenar3(i+3,:)=0;
    end

   for i=1:4

    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar4(i,:)=(4*p1*L2*L3*(L2^2 - 3*L2*L3 + L3^2) - p3*L1*L2*(L2^2 - 6*L2*L3 + 3*L3^2) - p2*L1*L3*(3*L2^2 - 6*L2*L3 + L3^2))/(6*Ve);
    rotkenar4(i,:)=(cross((4*L2^3*p3 + 4*L3^3*p2 - 24*L2*L3^2*p2 + 12*L2^2*L3*p2 + 12*L2*L3^2*p3 - 24*L2^2*L3*p3),p1) + cross((6*L1*L3^2*p2 - 3*L1*L2^2*p3 - L3^3*p1 + 6*L2*L3^2*p1 - 3*L2^2*L3*p1 - 3*L1*L3^2*p3 - 6*L1*L2*L3*p2 + 12*L1*L2*L3*p3),p2) + cross((6*L1*L2^2*p3 - 3*L1*L2^2*p2 - L2^3*p1 - 3*L1*L3^2*p2 - 3*L2*L3^2*p1 + 6*L2^2*L3*p1 + 12*L1*L2*L3*p2 - 6*L1*L2*L3*p3),p3))/(6*Ve)^2;

    i1=lis2(i,2);
    i2=lis2(i,3);
    i3=lis2(i,1);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar4(i+4,:)=(4*p1*L2*L3*(L2^2 - 3*L2*L3 + L3^2) - p3*L1*L2*(L2^2 - 6*L2*L3 + 3*L3^2) - p2*L1*L3*(3*L2^2 - 6*L2*L3 + L3^2))/(6*Ve);
    rotkenar4(i+4,:)=(cross((4*L2^3*p3 + 4*L3^3*p2 - 24*L2*L3^2*p2 + 12*L2^2*L3*p2 + 12*L2*L3^2*p3 - 24*L2^2*L3*p3),p1) + cross((6*L1*L3^2*p2 - 3*L1*L2^2*p3 - L3^3*p1 + 6*L2*L3^2*p1 - 3*L2^2*L3*p1 - 3*L1*L3^2*p3 - 6*L1*L2*L3*p2 + 12*L1*L2*L3*p3),p2) + cross((6*L1*L2^2*p3 - 3*L1*L2^2*p2 - L2^3*p1 - 3*L1*L3^2*p2 - 3*L2*L3^2*p1 + 6*L2^2*L3*p1 + 12*L1*L2*L3*p2 - 6*L1*L2*L3*p3),p3))/(6*Ve)^2;

    i1=lis2(i,3);
    i2=lis2(i,1);
    i3=lis2(i,2);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar4(i+8,:)=(4*p1*L2*L3*(L2^2 - 3*L2*L3 + L3^2) - p3*L1*L2*(L2^2 - 6*L2*L3 + 3*L3^2) - p2*L1*L3*(3*L2^2 - 6*L2*L3 + L3^2))/(6*Ve);
    rotkenar4(i+8,:)=(cross((4*L2^3*p3 + 4*L3^3*p2 - 24*L2*L3^2*p2 + 12*L2^2*L3*p2 + 12*L2*L3^2*p3 - 24*L2^2*L3*p3),p1) + cross((6*L1*L3^2*p2 - 3*L1*L2^2*p3 - L3^3*p1 + 6*L2*L3^2*p1 - 3*L2^2*L3*p1 - 3*L1*L3^2*p3 - 6*L1*L2*L3*p2 + 12*L1*L2*L3*p3),p2) + cross((6*L1*L2^2*p3 - 3*L1*L2^2*p2 - L2^3*p1 - 3*L1*L3^2*p2 - 3*L2*L3^2*p1 + 6*L2^2*L3*p1 + 12*L1*L2*L3*p2 - 6*L1*L2*L3*p3),p3))/(6*Ve)^2;

    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);

    duzkenar4(i+12,:)= (p2*L1*L3*(L1 - L3)*(L1 - 6*L2 + L3) - p3*L1*L2*(L1 - L2)*(L1 + L2 - 6*L3) - p1*L2*L3*(L2 - L3)*(L2 - 6*L1 + L3))/(6*Ve);
    rotkenar4(i+12,:)=(cross((L3^3*p2 - L2^3*p3 + 6*L1*L2^2*p3 - 6*L1*L3^2*p2 - 6*L2*L3^2*p1 + 6*L2^2*L3*p1 - 3*L2^2*L3*p2 + 3*L2*L3^2*p3 + 12*L1*L2*L3*p2 - 12*L1*L2*L3*p3),p1) + cross((L1^3*p3 - L3^3*p1 + 3*L1^2*L3*p1 + 6*L1*L3^2*p2 + 6*L2*L3^2*p1 - 6*L1^2*L2*p3 - 6*L1^2*L3*p2 - 3*L1*L3^2*p3 - 12*L1*L2*L3*p1 + 12*L1*L2*L3*p3),p2) + cross((L2^3*p1 - L1^3*p2 - 3*L1^2*L2*p1 + 3*L1*L2^2*p2 - 6*L1*L2^2*p3 + 6*L1^2*L2*p3 + 6*L1^2*L3*p2 - 6*L2^2*L3*p1 + 12*L1*L2*L3*p1 - 12*L1*L2*L3*p2),p3))/(6*Ve)^2;

    end

    for i=1:4
    i1=lis3(i,1);
    i2=lis3(i,2);
    i3=lis3(i,3);
    i4=lis3(i,4);

    L1=duzkose(i1);
    L2=duzkose(i2);
    L3=duzkose(i3);
    L4=duzkose(i4);

    p1=G(i1,:);
    p2=G(i2,:);
    p3=G(i3,:);
    p4=G(i4,:);

    duzkenar5(i,:)=(p4*(L1*L2*L3^2 - L1*L2^2*L3) - p1*(4*L2*L3^2*L4 - 4*L2^2*L3*L4) + p2*(L1*L3^2*L4 - 2*L1*L2*L3*L4) - p3*(L1*L2^2*L4 - 2*L1*L2*L3*L4))/(6*Ve);
    rotkenar5(i,:)=(cross((4*L2^2*L3*p4 - 4*L2*L3^2*p4 + 4*L2^2*L4*p3 - 4*L3^2*L4*p2 + 8*L2*L3*L4*p2 - 8*L2*L3*L4*p3),p1) + cross((L1*L3^2*p4 + L3^2*L4*p1 - 2*L1*L2*L3*p4 - 2*L1*L2*L4*p3 - 2*L1*L3*L4*p2 - 2*L2*L3*L4*p1 + 2*L1*L3*L4*p3),p2) + cross((2*L1*L2*L3*p4 - L2^2*L4*p1 - 2*L1*L2*L4*p2 - L1*L2^2*p4 + 2*L1*L2*L4*p3 + 2*L1*L3*L4*p2 + 2*L2*L3*L4*p1),p3) + cross((L1*L3^2*p2 - L1*L2^2*p3 + L2*L3^2*p1 - L2^2*L3*p1 - 2*L1*L2*L3*p2 + 2*L1*L2*L3*p3),p4))/(6*Ve)^2;

    duzkenar5(i+4,:)=(p3*(4*L1*L2*L4^2 - 4*L1^2*L2*L4) - p2*(L1*L3*L4^2 - L1^2*L3*L4) - p1*(L2*L3*L4^2 - 2*L1*L2*L3*L4) + p4*(L1^2*L2*L3 - 2*L1*L2*L3*L4))/(6*Ve);
    rotkenar5(i+4,:)=(cross((2*L1*L2*L3*p4 - L3*L4^2*p2 - L2*L4^2*p3 + 2*L1*L2*L4*p3 + 2*L1*L3*L4*p2 + 2*L2*L3*L4*p1 - 2*L2*L3*L4*p4),p1) + cross((L1^2*L3*p4 - L3*L4^2*p1 - L1*L4^2*p3 + L1^2*L4*p3 + 2*L1*L3*L4*p1 - 2*L1*L3*L4*p4),p2) + cross((4*L1*L4^2*p2 + 4*L2*L4^2*p1 - 4*L1^2*L2*p4 - 4*L1^2*L4*p2 - 8*L1*L2*L4*p1 + 8*L1*L2*L4*p4),p3) + cross((L1^2*L2*p3 + L1^2*L3*p2 + 2*L1*L2*L3*p1 - 2*L1*L2*L3*p4 - 2*L1*L2*L4*p3 - 2*L1*L3*L4*p2 - 2*L2*L3*L4*p1),p4))/(6*Ve)^2;

    end

    duzkenarA=[duzkenar;duzkenar2;duzkenar3;duzkenar4;duzkenar5];
    rotkenarA=[rotkenar;rotkenar2;rotkenar3;rotkenar4;rotkenar5];

    duzkenarf=[duzkenarA];
    rotkenarf=[rotkenarA/(-sqrt(-1)*w*mu)];  %%%
    klerf=[kler kler2 kler3 kler4 kler5];

    e1=x1(klerf);
    e2=x2(klerf);

    E1=(duzkenarf')*e1;
    H1=(rotkenarf'*e1);

    E2=(duzkenarf')*e2;
    H2=(rotkenarf'*e2);

    ex1=E1(1);
    ey1=E1(2);
    hx1=H1(1);
    hy1=H1(2);
    hz1=H1(3);

    ex2=E2(1);
    ey2=E2(2);
    hx2=H2(1);
    hy2=H2(2);
    hz2=H2(3);

    Z=inv([hx1 hy1;hx2 hy2])*[ex1 ey1 hz1;ex2 ey2 hz2];
    T0=-[Z(1,3);Z(2,3)];
    Z0=Z(1:2,1:2).';

    Z=Z0;
    T=T0;

    Zler(jj,1)=Z(1,1);
    Zler(jj,2)=Z(1,2);
    Zler(jj,3)=Z(2,1);
    Zler(jj,4)=Z(2,2);
    Tler(jj,1)=T(1,1);
    Tler(jj,2)=T(2,1);

    Zler0(jj,1)=Z0(1,1);
    Zler0(jj,2)=Z0(1,2);
    Zler0(jj,3)=Z0(2,1);
    Zler0(jj,4)=Z0(2,2);
    Tler0(jj,1)=T0(1,1);
    Tler0(jj,2)=T0(2,1);

    E1ler(jj,1:2)=[ex1 ey1];
    E2ler(jj,1:2)=[ex2 ey2];
    H1ler(jj,1:3)=[hx1 hy1 hz1];
    H2ler(jj,1:3)=[hx2 hy2 hz2];

    detler(jj,1)=1./det([hx1 hy1;hx2 hy2]);

    roa(kk,jj,1)=abs(Z(1,1))^2/(mu*w);
    roa(kk,jj,2)=abs(Z(1,2))^2/(mu*w);
    roa(kk,jj,3)=abs(Z(2,1))^2/(mu*w);
    roa(kk,jj,4)=abs(Z(2,2))^2/(mu*w);

    faza(kk,jj,1)=angle(Z(1,1))/pi*180;
    faza(kk,jj,2)=angle(Z(1,2))/pi*180;
    faza(kk,jj,3)=angle(Z(2,1))/pi*180;
    faza(kk,jj,4)=angle(Z(2,2))/pi*180;

end

end
