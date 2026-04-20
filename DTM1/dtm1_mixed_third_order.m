% ========================================================================
% Author: Deniz Varılsüha
% Affiliation: Istanbul Technical University (ITU)
% Contact: deniz.varilsuha@itu.edu.tr
% Journal: Computers & Geosciences
% Manuscript metadata: Included for journal submission compliance
% Last updated: 2026-04-08
% ========================================================================

% The forward modeling routine for the DTM1 model using the mixed third
% order bases
% It loads the DTM1_final1.mat for mesh and calculates impedances/rho and
% phases
clear all;clc;close all; format longG
reset(gpuDevice);
load('DTM1_final1.mat');
% ------------------------------------------------------------------------
% Quadrature notation used throughout this file:
%   xaK, yaK, zaK : barycentric coordinates of tetrahedral quadrature points
%   wtK           : weights for the corresponding quadrature rule

% The index K increases with the polynomial order that must be integrated.
% Higher-order edge/face/interior basis products are evaluated with higher K.
% ------------------------------------------------------------------------
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
eleman=sort(eleman,1);
[EL,node_no,edge_no,totkenar,totyuzey,yuzey_no,yuzeybd] = build_tet_topology_maps(node,eleman,rho); %Element matrix
close all;
eleman=eleman';
node=node';
ep=10^-5;
lis=[1 2;1 3; 1 4 ; 2 3; 2 4 ;3 4]; %this is the edge-node list
lis2=[3 2 4 ; 3 1 4; 2 1 4; 2 1 3];
lis3=[1 2 3 4 ; 2 3 4 1; 3 4 1 2; 4 1 2 3];
d=zeros(4,1);
c=d;b=d;a=d;
% Local element geometry/Jacobian workspace:
%   M    : [1 x y z] Vandermonde-like matrix used to compute volume and
%          barycentric-gradient coefficients (a,b,c,d)
%   rot* : local double-curl (curl-curl) integral blocks
%   F*   : local mass-matrix integral blocks (N_i · N_j)
M=ones(4,4);
Clar=zeros(4,4,3);
Dlar=zeros(4,4);
CDlar=zeros(4,4,4,4);
al=EL(:,12:15);
al=al(al>0);
totnode=max(al)-totkenar;
totel=size(EL,1);
sag=zeros(totkenar*4+totnode+totyuzey*6+totel*3,2);
ix1=[];iy1=[];iv1a=[];iv1b=[];sayac1=0; %curl + F
rot1=zeros(6,6);  %edge1 edge1
F1=zeros(6,6);    %edge1 edge1
kler=zeros(1,6);
tot=totkenar*3+totyuzey*6+totel*3

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
Jxyz=inv(Jabc);
Ve=abs(Ve);
quad=0;

if(ellst(ii)>0)
% quad=1;
% eknode=nodelst(ellst(ii),6:11);
% ekval=vallst(eknode,:);
end

quad=0;
xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% Rot edge1*edge1

for i=1:6

    for j=1:6
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis(j,1);
    j2=lis(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=2*cross(p1,p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=2*cross(p1,p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot1(i,j)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% Rot edge1*face1

for i=1:6

    for j=1:4
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=2*cross(p1,p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*cross(L3*p2+L2*p3,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot4(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=2*cross(p1,p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*cross(L3*p2+L2*p3,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot4(i,j+4)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% Rot face1*face1

for i=1:4

    for j=1:4
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*cross(L3*p2+L2*p3,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot6(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

        for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*cross(L3*p2+L2*p3,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot6(i,j+4)=sum1;
        rot6(j+4,i)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*cross(L3*p2+L2*p3,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot6(i+4,j+4)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% Rot face1*face3

for i=1:4

    for j=1:4
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot22(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot22(i,j+4)=sum1;
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot22(i,j+8)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        j1=lis2(j,1);
        j2=lis2(j,2);
        j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot22(i+4,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot22(i+4,j+4)=sum1;
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot22(i+4,j+8)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% Rot face1*vol1

for i=1:4

    for j=1:3
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis3(j,1);
    j2=lis3(j,2);
    j3=lis3(j,3);
    j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot23(i,j)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*cross(L3*p2+L2*p3,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot23(i+4,j)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% Rot face3*face3

for i=1:4

    for j=1:4
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot26(i,j)=sum1;
    i1=lis2(i,2);
    i2=lis2(i,3);
    i3=lis2(i,1);
    j1=lis2(j,2);
    j2=lis2(j,3);
    j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot26(i+4,j+4)=sum1;
        i1=lis2(i,3);
        i2=lis2(i,1);
        i3=lis2(i,2);
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot26(i+8,j+8)=sum1;
        i1=lis2(i,1);
        i2=lis2(i,2);
        i3=lis2(i,3);
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot26(i,j+4)=sum1;
        rot26(j+4,i)=sum1;
        i1=lis2(i,1);
        i2=lis2(i,2);
        i3=lis2(i,3);
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot26(i,j+8)=sum1;
        rot26(j+8,i)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot26(i+4,j+8)=sum1;
        rot26(j+8,i+4)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% Rot face3*vol1

for i=1:4

    for j=1:3
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis3(j,1);
    j2=lis3(j,2);
    j3=lis3(j,3);
    j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot27(i,j)=sum1;
    i1=lis2(i,2);
    i2=lis2(i,3);
    i3=lis2(i,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot27(i+4,j)=sum1;
        i1=lis2(i,3);
        i2=lis2(i,1);
        i3=lis2(i,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot27(i+8,j)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% Rot vol1*vol1

for i=1:3

    for j=1:3
    i1=lis3(i,1);
    i2=lis3(i,2);
    i3=lis3(i,3);
    i4=lis3(i,4);
    j1=lis3(j,1);
    j2=lis3(j,2);
    j3=lis3(j,3);
    j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(i4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(i4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        rot28(i,j)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge1*edge1

for i=1:6

    for j=1:6
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis(j,1);
    j2=lis(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2-L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*p2-L2*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F1(i,j)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge1*edge2

for i=1:6

    for j=1:6
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis(j,1);
    j2=lis(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2-L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*p2+L2*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F2(i,j)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge2*edge2

for i=1:6

    for j=1:6
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis(j,1);
    j2=lis(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2+L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*p2+L2*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F3(i,j)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge1*face1

for i=1:6

    for j=1:4
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(L1*p2-L2*p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        % sek2=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F4(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(L1*p2-L2*p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        % sek2=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F4(i,j+4)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge2*face1

for i=1:6

    for j=1:4
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(L1*p2+L2*p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        % sek2=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F5(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(L1*p2+L2*p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        % sek2=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F5(i,j+4)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;
%M face1-face1

for i=1:4

    for j=1:4
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        % sek1=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        % sek2=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F6(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F6(i,j+4)=sum1;
        F6(j+4,i)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F6(i+4,j+4)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge1*edge3

for i=1:6

    for j=1:6
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis(j,1);
    j2=lis(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2-L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F7(i,j)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge1*face2

for i=1:6

    for j=1:4
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis2(j,3);
    j2=lis2(j,1);
    j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(L1*p2-L2*p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F8(i,j)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge2*edge3

for i=1:6

    for j=1:6
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis(j,1);
    j2=lis(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2+L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F9(i,j)=sum1;
    end
end

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;

%%% M edge2*face2

for i=1:6

    for j=1:4
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis2(j,3);
    j2=lis2(j,1);
    j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(L1*p2+L2*p1);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F10(i,j)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% M edge3*edge3

for i=1:6

    for j=1:6
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis(j,1);
    j2=lis(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F11(i,j)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% M edge3*face1

for i=1:6

    for j=1:4
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F12(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F12(i,j+4)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% M edge3*face2

for i=1:6

    for j=1:4
    i1=lis(i,1);
    i2=lis(i,2);
    j1=lis2(j,3);
    j2=lis2(j,1);
    j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F13(i,j)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;
%M face1-face2

for i=1:4

    for j=1:4
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis2(j,3);
    j2=lis2(j,1);
    j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        % sek1=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F14(i,j)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F14(i+4,j)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;
%M face2-face2

for i=1:4

    for j=1:4
    i1=lis2(i,3);
    i2=lis2(i,1);
    i3=lis2(i,2);
    j1=lis2(j,3);
    j2=lis2(j,1);
    j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F15(i,j)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% M edge1*face3

for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);

    for j=1:4
        j1=lis2(j,1);
        j2=lis2(j,2);
        j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2-L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F16(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2-L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F16(i,j+4)=sum1;
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2-L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F16(i,j+8)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% M edge1*vol1

for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);

    for j=1:3
        j1=lis3(j,1);
        j2=lis3(j,2);
        j3=lis3(j,3);
        j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2-L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F17(i,j)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% M edge2*face3

for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);

    for j=1:4
        j1=lis2(j,1);
        j2=lis2(j,2);
        j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2+L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F18(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2+L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F18(i,j+4)=sum1;
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2+L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F18(i,j+8)=sum1;
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;

%%% M edge2*vol1

for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);

    for j=1:3
        j1=lis3(j,1);
        j2=lis3(j,2);
        j3=lis3(j,3);
        j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*p2+L2*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F19(i,j)=sum1;
    end
end

xa=xa3;
ya=ya3;
za=za3;
wt=wt3;

%%% M edge3*face3

for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);

    for j=1:4
        j1=lis2(j,1);
        j2=lis2(j,2);
        j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F20(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F20(i,j+4)=sum1;
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F20(i,j+8)=sum1;
    end
end

xa=xa3;
ya=ya3;
za=za3;
wt=wt3;

%%% M edge3*vol1

for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);

    for j=1:3
        j1=lis3(j,1);
        j2=lis3(j,2);
        j3=lis3(j,3);
        j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F21(i,j)=sum1;
    end
end

xa=xa3;
ya=ya3;
za=za3;
wt=wt3;
%M face1-face3

for i=1:4

    for j=1:4
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F22(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F22(i,j+4)=sum1;
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F22(i,j+8)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        j1=lis2(j,1);
        j2=lis2(j,2);
        j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F22(i+4,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F22(i+4,j+4)=sum1;
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F22(i+4,j+8)=sum1;
    end
end

xa=xa3;
ya=ya3;
za=za3;
wt=wt3;
%M face1-vol1

for i=1:4

    for j=1:3
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
        j1=lis3(j,1);
        j2=lis3(j,2);
        j3=lis3(j,3);
        j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F23(i,j)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F23(i+4,j)=sum1;
    end
end

xa=xa3;
ya=ya3;
za=za3;
wt=wt3;
%M face2-face3

for i=1:4

    for j=1:4
    i1=lis2(i,3);
    i2=lis2(i,1);
    i3=lis2(i,2);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F24(i,j)=sum1;
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F24(i,j+4)=sum1;
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F24(i,j+8)=sum1;
    end
end

xa=xa3;
ya=ya3;
za=za3;
wt=wt3;
%M face2-vol1

for i=1:4

    for j=1:3
    i1=lis2(i,3);
    i2=lis2(i,1);
    i3=lis2(i,2);
        j1=lis3(j,1);
        j2=lis3(j,2);
        j3=lis3(j,3);
        j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F25(i,j)=sum1;
    end
end

xa=xa4;
ya=ya4;
za=za4;
wt=wt4;
%M face3-face3

for i=1:4

    for j=1:4
    i1=lis2(i,1);
    i2=lis2(i,2);
    i3=lis2(i,3);
    j1=lis2(j,1);
    j2=lis2(j,2);
    j3=lis2(j,3);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F26(i,j)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F26(i+4,j+4)=sum1;
        i1=lis2(i,3);
        i2=lis2(i,1);
        i3=lis2(i,2);
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F26(i+8,j+8)=sum1;
        i1=lis2(i,1);
        i2=lis2(i,2);
        i3=lis2(i,3);
        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F26(i,j+4)=sum1;
        F26(j+4,i)=sum1;
        i1=lis2(i,1);
        i2=lis2(i,2);
        i3=lis2(i,3);
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F26(i,j+8)=sum1;
        F26(j+8,i)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F26(i+4,j+8)=sum1;
        F26(j+8,i+4)=sum1;
    end
end

xa=xa4;
ya=ya4;
za=za4;
wt=wt4;
%M face3-vol1

for i=1:4

    for j=1:3
        i1=lis2(i,1);
        i2=lis2(i,2);
        i3=lis2(i,3);
        j1=lis3(j,1);
        j2=lis3(j,2);
        j3=lis3(j,3);
        j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F27(i,j)=sum1;
        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F27(i+4,j)=sum1;
        i1=lis2(i,3);
        i2=lis2(i,1);
        i3=lis2(i,2);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F27(i+8,j)=sum1;
    end
end

xa=xa4;
ya=ya4;
za=za4;
wt=wt4;
%M vol1-vol1

for i=1:3

    for j=1:3
        i1=lis3(i,1);
        i2=lis3(i,2);
        i3=lis3(i,3);
        i4=lis3(i,4);
        j1=lis3(j,1);
        j2=lis3(j,2);
        j3=lis3(j,3);
        j4=lis3(j,4);
        sum1=0;

       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(i4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(i4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek1=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=evaluate_shape_function(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=evaluate_shape_function(j4,xa(jj),ya(jj),za(jj),Jxyz,1);
        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;
        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end

        F28(i,j)=sum1;
    end
end

F1=sigma*F1; %we will add i*w and mu later; keep it real for now
F2=sigma*F2;
F3=sigma*F3;
F4=sigma*F4;
F5=sigma*F5;
F6=sigma*F6;
F7=sigma*F7;
F8=sigma*F8;
F9=sigma*F9;
F10=sigma*F10;
F11=sigma*F11;
F12=sigma*F12;
F13=sigma*F13;
F14=sigma*F14;
F15=sigma*F15;
F16=sigma*F16;
F17=sigma*F17;
F18=sigma*F18;
F19=sigma*F19;
F20=sigma*F20;
F21=sigma*F21;
F22=sigma*F22;
F23=sigma*F23;
F24=sigma*F24;
F25=sigma*F25;
F26=sigma*F26;
F27=sigma*F27;
F28=sigma*F28;
FF=[F1 F2 F7 F4 F8 F16 F17;
    F2' F3 F9 F5 F10 F18 F19;
    F7' F9' F11 F12 F13 F20 F21;
    F4' F5' F12' F6 F14 F22 F23;
    F8' F10' F13' F14' F15 F24 F25;
    F16' F18' F20' F22' F24' F26 F27;
    F17' F19' F21' F23' F25' F27' F28];
RR=zeros(45,45);
RR(1:6,1:6)=rot1;
RR(1:6,19:26)=rot4;
RR(19:26,1:6)=rot4';
RR(19:26,19:26)=rot6;
RR(19:26,31:42)=rot22;
RR(31:42,19:26)=rot22';
RR(19:26,43:45)=rot23;
RR(43:45,19:26)=rot23';
RR(31:42,31:42)=rot26;
RR(31:42,43:45)=rot27;
RR(43:45,31:42)=rot27';
RR(43:45,43:45)=rot28';
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
klerv2=zeros(1,45);  %all non-phi terms

for i=1:6

    if(kler(i)>0)
    klerv2(i)=kler(i);
    klerv2(i+6)=kler(i)+totkenar;
    klerv2(i+12)=kler(i)+totkenar*2;
    else
    klerv2(i)=kler(i);
    klerv2(i+6)=kler(i);
    klerv2(i+12)=kler(i);
    end
end

for i=19:30

    if(kler2(i-18)>0)
        klerv2(i)=kler2(i-18)+totkenar*3;
        klerv2(i+12)=kler2(i-18)+totkenar*3+totyuzey*3;
    else
        klerv2(i)=kler2(i-18);
        klerv2(i+12)=kler2(i-18);
    end
end

klerv=[ii ii+totel ii+totel*2];
klerv2(43:45)=klerv+totkenar*3+totyuzey*6;
iszerov2=length(find(klerv2<0));  %all non-phi terms

    if(iszerov2==0)
        rr=repmat(klerv2',[1 45]); %row indices
        cc=rr'; %column indices;
        ix1(sayac1+1:sayac1+2025)=rr(:);
        iy1(sayac1+1:sayac1+2025)=cc(:);
        iv1a(sayac1+1:sayac1+2025)=RR(:);
        iv1b(sayac1+1:sayac1+2025)=FF(:);
        sayac1=sayac1+2025;
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
            sag(kler2(nke2)+totkenar*3,:)=sag(kler2(nke2)+totkenar*3,:)+sag_local4(nke2,:);
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
        sag(kler2(nke2)+totkenar*3,:)=sag(kler2(nke2)+totkenar*3,:)+sag_local4(nke2,:);
        sag(kler2(nke3)+totkenar*3+totyuzey*3,:)=sag(kler2(nke3)+totkenar*3+totyuzey*3,:)+sag_local6(nke3,:);
        sag(klerv+totkenar*3+totyuzey*6,:)=sag(klerv+totkenar*3+totyuzey*6,:)+sag_local7;
    end
end

R1=sparse(ix1,iy1,iv1a,totkenar*3+totyuzey*6+totel*3,totkenar*3+totyuzey*6+totel*3); % double curl
M1=sparse(ix1,iy1,iv1b,totkenar*3+totyuzey*6+totel*3,totkenar*3+totyuzey*6+totel*3); %
R1=spmdReduce(@plus,R1,1);
M1=spmdReduce(@plus,M1,1);
sag=spmdReduce(@plus,sag,1);
end

R1=R1{1};
M1=M1{1};
sag=sag{1};
load('DTM1_IE_veri.mat');
P=2;
ara=[21,14];
a=e{11,P};
T=a(1:21,5);
ff=1./T;

for kk=1:length(ff)
f=ff(kk); % frequencies
mu=4*pi*10^-7;
w=2*pi*f;
kat=sqrt(-1)*w*mu;
B1=R1+kat*M1;
tot=totkenar*3+totyuzey*6+totel*3;
ekle=totkenar*2+totyuzey*1;
AA=B1;
bsag=sag(1:tot,:);
[v0,r0,c0]=sparse2csr(AA);
rowg=gpuArray(r0);
colg=gpuArray(c0);
valg=gpuArray(v0);
bg=gpuArray(bsag);
% tic
% [xx]=LUcuDSS(rowg,colg,valg,complex(bg),int32(2)); %sweeping
% toc
tic
[xx]=LUcuDSSMG(rowg,colg,valg,complex(bg),int32(2),int32(4)); %sweeping
toc
relres=norm(AA*xx-bsag)/norm(bsag);
fprintf("Direct solution relative residual=%e\n",relres);
x1=gather(xx(:,1));
x2=gather(xx(:,2));
x1=[x1;zeros(ekle,1)];
x2=[x2;zeros(ekle,1)];
M=ones(4,4);
mu=4*pi*10^-7;
clear G kler a b c d

for jj=1:size(recv,1)
    ii=recv(jj,4);
    nler=eleman(ii,1:4);
    XYZ=node(nler,:)';
    % x0=recv(jj,1);
    % y0=recv(jj,2);
    x0=mean(XYZ(1,:));
    y0=mean(XYZ(2,:));
    z0=mean(XYZ(3,:));
    xler(jj)=x0;
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
        elseif(nnz(al)==1)
            kler2(i)=yuzeybd(ii,sw);
            kler2(i+4)=kler2(i)+totyuzey;
            kler2(i+8)=kler2(i)+totyuzey*2;
            kler2(i+12)=kler2(i)+totyuzey*3;
            kler2(i+16)=kler2(i)+totyuzey*4;
            kler2(i+20)=kler2(i)+totyuzey*5;

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

            if(kler2(i)==0)
            error('0 index');
            end
        end
    end

    kler2=kler2+totkenar*3;
    kler3=[ii ii+totel ii+totel*2]+totkenar*3+totyuzey*6;

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
    rotkenar(i,:)=2*cross(p1,p2)/(6*Ve)^2;
    rotkenar(i+6,:)=0;
    rotkenar(i+12,:)=0;
    duzkenar(i,:)=(L1*p2-L2*p1)/(6*Ve);
    duzkenar(i+6,:)=(L1*p2+L2*p1)/(6*Ve);
    duzkenar(i+12,:)=((2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2)/(6*Ve);
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

    Rx=eye(3);
    Rz=eye(3);
    Ry=eye(3);
    duzkenarA=[duzkenar;duzkenar2;duzkenar3];
    rotkenarA=[rotkenar;rotkenar2;rotkenar3];
    duzkenarf=duzkenarA;
    rotkenarf=rotkenarA/(-sqrt(-1)*w*mu);
    klerf=[kler kler2 kler3];
    e1=x1(klerf);
    e2=x2(klerf);
    E1=(Rx*Ry*Rz*duzkenarf')*e1;
    H1=(rotkenarf'*e1);
    E2=(Rx*Ry*Rz*duzkenarf')*e2;
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
