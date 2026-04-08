%% 
clear all;clc;close all;
format longG

%%%ÇALIŞIYOR XX VE YY GÜZEL OLDU!!!!!!!!!!!!!!!!!!!!!!!!!!!

reset(gpuDevice);

% load('Modelfor_modelingEE.mat');
% load('Model_Homo_2000.mat');
% load('testmesh8.mat');
% A=load('hillmodel_deniz1.mat');
% 
% 
% load('Modelfor_modeling_hill.mat');
% recv=A.recv;
% 
% 
% rho=datan.proje{1,1}.modelmesh.unstr{1,1}.model.rho;
% % 
% % rho((rho>10^8))=10^8;
% node=datan.proje{1,1}.modelmesh.unstr{1,1}.model.model.Mesh.Nodes;
% eleman=datan.proje{1,1}.modelmesh.unstr{1,1}.model.model.Mesh.Elements;
% yuzeynode=datan.proje{1,1}.modelmesh.unstr{1,1}.model.node_in_faceIDs';


% load('testhill8nofix.mat');

% load('testhill8.mat');
% load('Two-mountain_ori1.mat');
% load('Two-mountain_refd6.mat');
% load('Two-mountain_new3.mat');

% load('DTM1_init1.mat');
% load('DTM1_init7.mat');
% load('DTM1_grad4.mat');

load('DTM1_final1.mat');



% return



% [thetaMinTet, thetaMinGlobal] = minTetDihedral(node', eleman');
% kars=sort(thetaMinTet);
% 
% 
% return

al=node(:,yuzeynode);
min(al(1,:))
max(al(1,:))
min(al(2,:))
max(al(2,:))

al=node(:,:);
min(al(1,:))
max(al(1,:))
min(al(2,:))
max(al(2,:))


% return

% clear recv
% 
% c=0;
% for i=-2000:1000:2000
%     for j=-2000:1000:2000
%     c=c+1;
%     recv(c,:)=[i j 0];
%     end
% end



% rho(rho==100)=1;

% [recv] = istasyonElemanBagi(yuzeynode,node,eleman,rho,recv(:,1:3));
istasyonElemanBagi(yuzeynode,node,eleman,rho,recv(:,1:3));




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






% [xy, wxy] = triQuad(12);  %%%%7 problemli


% return

eleman=sort(eleman,1);


[EL,node_no,edge_no,totkenar,totyuzey,yuzey_no,yuzeybd] = ELkurtet2(node,eleman,rho); %Eleman matrisi


% return


% close all;
eleman=eleman';
node=node';


ep=10^-5;

lis=[1 2;1 3; 1 4 ; 2 3; 2 4 ;3 4]; %bu kenar node listesi
lis2=[3 2 4 ; 3 1 4; 2 1 4; 2 1 3]; 

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

totyuzey*2+totkenar*2

sag=zeros(totkenar*3+totnode+totyuzey*2,2);

% ix1=[];iy1=[];iv1a=[];iv1b=[];iv1c=[];iv1d=[];sayac1=0;
% iv1e=[];iv1f=[];iv1g=[];
% 
% ix2=[];iy2=[];iv2a=[];iv2b=[];iv2c=[];sayac2=0;
% 


% ix3=[];iy3=[];iv3a=[];iv3b=[];iv3c=[];sayac3=0;%edge12 node1 6x4 bir tane 4x6 var 
% ix4=[];iy4=[];iv4a=[];sayac4=0; %4x4
% ix5=[];iy5=[];iv5=[];sayac5=0;

ix1=[];iy1=[];iv1a=[];iv1b=[];sayac1=0; %rot +F
% ix2=[];iy2=[];iv2=[];sayac2=0; %F
ix3=[];iy3=[];iv3=[];sayac3=0; %D
ix4=[];iy4=[];iv4=[];sayac4=0; %P


% dg=zeros(totkenar*2,1);


% Ves=zeros(size(EL,1),1);


rot1=zeros(6,6);  %edge1 edge1
F1=zeros(6,6);    %edge1 edge1
B1=zeros(6,4);

kler=zeros(1,6);




% return

% xa1=xa4;
% ya1=ya4;
% za1=za4;
% wt1=wt4;
% 
% xa2=xa4;
% ya2=ya4;
% za2=za4;
% wt2=wt4;


% xa1=xa2;
% ya1=ya2;
% za1=za2;
% wt1=wt2;
% 
% xa2=xa3;
% ya2=ya3;
% za2=za3;
% wt2=wt3;


% vall

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
le(1:6)=1;


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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=2*cross(p1,p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=2*cross(p1,p2);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        rot1(i,j)=sum1*le(i)*le(j); 
    end
end



% testJac1(XYZ,xa(1),ya(1),za(1))


% 
% return
% 
% 
% 
% xa=xa1;
% ya=ya1;
% za=za1;
% wt=wt1;
% %%% Rot edge1*edge1
% for i=1:6
%     for j=1:6
% 
%     i1=lis(i,1); 
%     i2=lis(i,2);
% 
%     j1=lis(j,1);
%     j2=lis(j,2);
% 
%         sum1=0;
%        for jj=1:length(xa)
% 
% 
%         [Jxyz0,det0] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
% 
% 
%         % [Jxyz0,det0]=testJac1(XYZ,xa(jj),ya(jj),za(jj));
% 
%         p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz0,2);
%         p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz0,2);
%         % L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
%         % L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
% 
%         sek1=2*cross(p1,p2);
% 
%         p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz0,2);
%         p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz0,2);
%         % L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
%         % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
% 
%         sek2=2*cross(p1,p2);
% 
%         sum1=sum1+dot(sek1,sek2)*wt(jj)*det0;    
%        end
%         rot1a(i,j)=sum1*le(i)*le(j); 
%     end
% end





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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=2*cross(p1,p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);        
        % L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=3*cross(L3*p2+L2*p3,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        rot4(i,j)=sum1*le(i); 


        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=2*cross(p1,p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);        
        % L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=3*cross(L3*p2+L2*p3,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        rot4(i,j+4)=sum1*le(i);        
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=3*cross(L3*p2+L2*p3,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);        
        % L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=3*cross(L3*p2+L2*p3,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);        
        % L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        % L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=3*cross(L3*p2+L2*p3,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);        
        % L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=3*cross(L3*p2+L2*p3,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        rot6(i+4,j+4)=sum1;      
         
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=L1*p2-L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        F1(i,j)=sum1*le(i)*le(j); 
    end
end




% xa=xa1;
% ya=ya1;
% za=za1;
% wt=wt1;
% %%% M edge1*edge1
% for i=1:6
%     for j=1:6
% 
%     i1=lis(i,1); 
%     i2=lis(i,2);
% 
%     j1=lis(j,1);
%     j2=lis(j,2);
% 
%         sum1=0;
%        for jj=1:length(xa)
% 
%         [Jxyz0,det0] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
% 
% 
%         p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz0,2);
%         p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz0,2);
%         L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz0,1);
%         L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz0,1);
% 
%         sek1=L1*p2-L2*p1;
% 
%         p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz0,2);
%         p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz0,2);
%         L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz0,1);
%         L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz0,1);
% 
%         sek2=L1*p2-L2*p1;
% 
%         sum1=sum1+dot(sek1,sek2)*wt(jj)*det0;    
%        end
%         F1a(i,j)=sum1*le(i)*le(j); 
%     end
% end




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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=L1*p2+L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        F2(i,j)=sum1*le(i)*le(j);
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L1*p2+L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=L1*p2+L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        F3(i,j)=sum1*le(i)*le(j);
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=(L1*p2-L2*p1)*le(i);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=(L1*p2-L2*p1)*le(i);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=(L1*p2+L2*p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        % sek2=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);


        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        F5(i,j)=le(i)*sum1; 


        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=(L1*p2+L2*p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        % sek2=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        F5(i,j+4)=le(i)*sum1; 

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        % sek1=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        F6(i+4,j+4)=sum1; 

    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BLER%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;
%%% M edge1*node1
for i=1:6
    i1=lis(i,1); 
    i2=lis(i,2);
    
    for j=1:4
    j1=j;

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p1-p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        B1a(i,j)=sum1*le(i); 
    end
end


xa=xa1;
ya=ya1;
za=za1;
wt=wt1;
%%% M edge1*node2
for i=1:6
    i1=lis(i,1); 
    i2=lis(i,2);
    
    for j=1:6
    j1=lis(j,1); 
    j2=lis(j,2);

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p2+4*L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        B1b(i,j)=sum1*le(i); 
    end
end



xa=xa1;
ya=ya1;
za=za1;
wt=wt1;
%%% M edge2*node1
for i=1:6
    i1=lis(i,1); 
    i2=lis(i,2);
    
    for j=1:4
    j1=j;

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L1*p2+L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p1-p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        B2a(i,j)=sum1*le(i); 
    end
end


xa=xa1;
ya=ya1;
za=za1;
wt=wt1;
%%% M edge2*node2
for i=1:6
    i1=lis(i,1); 
    i2=lis(i,2);
    
    for j=1:6
    j1=lis(j,1); 
    j2=lis(j,2);

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L1*p2+L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p2+4*L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        B2b(i,j)=sum1*le(i); 
    end
end


xa=xa2;
ya=ya2;
za=za2;
wt=wt2;
%M face1-node1
for i=1:4
    for j=1:4

    i1=lis2(i,1); 
    i2=lis2(i,2);
    i3=lis2(i,3);

    j1=j;

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        % sek1=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p1-p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        B3a(i,j)=sum1; 


        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p1-p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        B3a(i+4,j)=sum1; 
    end
end

xa=xa2;
ya=ya2;
za=za2;
wt=wt2;
%M face1-node2
for i=1:4
    for j=1:6

    i1=lis2(i,1); 
    i2=lis2(i,2);
    i3=lis2(i,3);

    j1=lis(j,1); 
    j2=lis(j,2);    

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        % sek1=2*L2*L3*p1-L1*L2*p3-L1*L3*p2;
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p2+4*L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        B3b(i,j)=sum1; 


        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p2+4*L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        B3b(i+4,j)=sum1; 
    end
end


%%%%%%%%%%%%%%CLER%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xa=xa1;
ya=ya1;
za=za1;
wt=wt1;
%%% M node1*node1
for i=1:4
    i1=i;
    
    for j=1:4
    j1=j;

        sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=4*L1*p1-p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p1-p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        C1a(i,j)=sum1; 

    end
end


xa=xa1;
ya=ya1;
za=za1;
wt=wt1;
%%% M node1*node2
for i=1:4
    i1=i;
    
        for j=1:6
        j1=lis(j,1); 
        j2=lis(j,2);

       sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=4*L1*p1-p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p2+4*L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        C2a(i,j)=sum1; 

    end
end


xa=xa1;
ya=ya1;
za=za1;
wt=wt1;
%%% M node2*node2
for i=1:6
i1=lis(i,1); 
i2=lis(i,2);
    
       for j=1:6
        j1=lis(j,1); 
        j2=lis(j,2);

       sum1=0;
       for jj=1:length(xa)

        if(quad==1)
        [Jxyz,det1] = quadJac(XYZ,xa(jj),ya(jj),za(jj),ekval,sgn);
        end             

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek1=4*L1*p2+4*L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        
        sek2=4*L1*p2+4*L2*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;    
       end
        C3a(i,j)=sum1; 

    end
end







% MM=[F1 F2 F4;
%     F2' F3 F5;
%     F4' F5' F6];

BB=[B1a B1b;
    B2a B2b;
    B3a B3b];

% GG=MM\BB;

PP=[C1a C2a;C2a' C3a]*sigma;
BB(abs(BB)<10^-9)=0;


DD=BB'*sigma;



% return


F1=sigma*F1; %sonrada iw ve mu ekleyeceğiz şimdilik reel olarak kalsın
F2=sigma*F2;
F3=sigma*F3;
F4=sigma*F4;
F5=sigma*F5;
F6=sigma*F6;


FF=[F1 F2 F4;
    F2' F3 F5;
    F4' F5' F6];

% PP=GG'*FF*GG;
% DD=GG'*FF;


% PP=BB'*GG*sigma;
% DD=BB'*sigma;


RR=[rot1 zeros(6,6) rot4;...
   zeros(6,6) zeros(6,6) zeros(6,8);...
   rot4' zeros(8,6) rot6];



% if(nnz(isnan(RR))>0 || nnz(isnan(FF))>0 || nnz(isnan(PP))>0 || nnz(isnan(DD))>0)
% break;
% end


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
    elseif(nnz(al)==1)
        kler2(i)=yuzeybd(ii,sw);
        kler2(i+4)=kler2(i)+totyuzey;
        if(kler2(i)==0)
        error('0 index');
        end
    else
        kler2(i)=yuzeybd(ii,sw);
        kler2(i+4)=kler2(i);
        if(kler2(i)==0)
        error('0 index');
        end
    end
end

kler3=EL(ii,12:15)-totkenar;





klerv2=zeros(1,20);  %tüm non-phi
for i=1:6
    if(kler(i)>0)
    klerv2(i)=kler(i);
    klerv2(i+6)=kler(i)+totkenar;
    else
    klerv2(i)=kler(i);
    klerv2(i+6)=kler(i);
    end
end

for i=13:20
    if(kler2(i-12)>0)
        klerv2(i)=kler2(i-12)+totkenar*2;
    else
        klerv2(i)=kler2(i-12);
    end
end


klerv1=zeros(1,10); %tüm phi
klerv1(1:4)=kler3;
for i=1:6
if(kler(i)>0)
klerv1(i+4)=kler(i)+totnode;
else
klerv1(i+4)=kler(i);
end
end


% return

iszerov1=length(find(klerv1<0));  %tüm phi
iszerov2=length(find(klerv2<0));  %tüm non-phi


    if(iszerov2==0)

        rr=repmat(klerv2',[1 20]); %row nolar
        cc=rr'; %col nolar;
        
        ix1(sayac1+1:sayac1+400)=rr(:);
        iy1(sayac1+1:sayac1+400)=cc(:);
        iv1a(sayac1+1:sayac1+400)=RR(:);
        iv1b(sayac1+1:sayac1+400)=FF(:);
        sayac1=sayac1+400;
    else
        nke=find(klerv2>0); % bunlar kalacak
        rr=repmat(klerv2(nke)',[1 length(nke)]); %row nolar
        cc=rr'; %col nolar;
        nonz=length(nke)^2;

        RRm=RR(nke,nke);
        FFm=FF(nke,nke);
        

        ix1(sayac1+1:sayac1+nonz)=rr(:);
        iy1(sayac1+1:sayac1+nonz)=cc(:);
        iv1a(sayac1+1:sayac1+nonz)=RRm(:);
        iv1b(sayac1+1:sayac1+nonz)=FFm(:);        
        sayac1=sayac1+nonz;        
    end


    if(iszerov1==0)

        rr=repmat(klerv1',[1 10]); %row nolar
        cc=rr'; %col nolar;
        
        ix4(sayac4+1:sayac4+100)=rr(:);
        iy4(sayac4+1:sayac4+100)=cc(:);
        iv4(sayac4+1:sayac4+100)=PP(:);
        sayac4=sayac4+100;
    else
        nke=find(klerv1>0); % bunlar kalacak
        rr=repmat(klerv1(nke)',[1 length(nke)]); %row nolar
        cc=rr'; %col nolar;
        nonz=length(nke)^2;

        PPm=PP(nke,nke);

        ix4(sayac4+1:sayac4+nonz)=rr(:);
        iy4(sayac4+1:sayac4+nonz)=cc(:);
        iv4(sayac4+1:sayac4+nonz)=PPm(:);
        sayac4=sayac4+nonz;        
    end


    if(iszerov1==0 && iszerov2==0)
        rr=repmat(klerv1',[1 20]); %row nolar
        cc=repmat(klerv2,[10 1]); %col nolar
        
        ix3(sayac3+1:sayac3+200)=rr(:);
        iy3(sayac3+1:sayac3+200)=cc(:);
        iv3(sayac3+1:sayac3+200)=DD(:);
        sayac3=sayac3+200;

    else
        nke=find(klerv1>0); % bunlar kalacak
        nke2=find(klerv2>0); % bunlar kalacak

        rr=repmat(klerv1(nke)',[1 length(nke2)]); %row nolar
        cc=repmat(klerv2(nke2),[length(nke) 1]); %row nolar
        
        nonz=length(nke)*length(nke2);
        DDm=DD(nke,nke2);


        ix3(sayac3+1:sayac3+nonz)=rr(:);
        iy3(sayac3+1:sayac3+nonz)=cc(:);
        iv3(sayac3+1:sayac3+nonz)=DDm(:);
        sayac3=sayac3+nonz;
    end




    iszero=length(find(kler<0));
    

    if(iszero~=0) %Eğer sınıra denk gelmiyorsa burası
    
        %Eğer sınırda kenar varsa burası
        
        ke=find(kler<0); % bunlar dizeyden düşecek
        nke=find(kler>0); % bunlar kalacak
        nke2=find(kler2>0); % bunlar kalacak
        
        sag_local1=zeros(6,2);
        sag_local3=zeros(8,2);
        
        for i=1:length(ke)
            
            %Burada noktaların sırası önemli vektörler n1 den n2 ye gidiyor
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


            %Burada hangi yüzeyde olduğuba bakıyorum
            if(kler(ke(i))==-1 || kler(ke(i))==-2) %solda sagda  y-z yönünde açı var
            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(1)-xyz2(1))>ep)
            error('x aynı olmalı');
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
            val=al(1); % sol yada sagdaki kenarın değeri 

            % val=1;

            sag_local1(nke,1)=sag_local1(nke,1)-rot1(nke,ke(i))*val;
            sag_local3(nke2,1)=sag_local3(nke2,1)-rot4(ke(i),nke2)'*val;
            
            % 
            elseif(kler(ke(i))==-3 || kler(ke(i))==-4) %önde arkada x-z yönünde açı var

            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(2)-xyz2(2))>ep)
            error('y aynı olmalı');
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
            val=al(1); % ön yada arka kenarın değeri bu

            % val=1;

            sag_local1(nke,2)=sag_local1(nke,2)-rot1(nke,ke(i))*val;
            sag_local3(nke2,2)=sag_local3(nke2,2)-rot4(ke(i),nke2)'*val;

            elseif(kler(ke(i))==-5 || kler(ke(i))==-6) %üstte altta x y yününde açı var
            
            if( abs(xyz1(3)-xyz2(3))>ep)
            error('z aynı olmalı');
            end

            xyz1=node(n1,:);
            xyz2=node(n2,:);   
            nor(1)=xyz2(1)-xyz1(1);
            nor(2)=xyz2(2)-xyz1(2);
            aci=atan2(nor(2),nor(1))/pi*180;

            % aci=360-aci;

            %Ex basıyorum
            vec=[1;0]; 
            R1=[cosd(aci) -sind(aci) ; sind(aci) cosd(aci)];
            al=R1*vec;
            val=al(1); % üst yada alt
            % val=al(2);

            sag_local1(nke,2)=sag_local1(nke,2)-rot1(nke,ke(i))*val;
            sag_local3(nke2,2)=sag_local3(nke2,2)-rot4(ke(i),nke2)'*val;

            val=al(2);

            sag_local1(nke,1)=sag_local1(nke,1)-rot1(nke,ke(i))*val;
            sag_local3(nke2,1)=sag_local3(nke2,1)-rot4(ke(i),nke2)'*val;
            
            else
            error('1-6 olmalı');

            end
        end

            sag(kler(nke),:)=sag(kler(nke),:)+sag_local1(nke,:);
            sag(kler2(nke2)+totkenar*2,:)=sag(kler2(nke2)+totkenar*2,:)+sag_local3(nke2,:);
         end

    iszero2=length(find(kler2<0));


    if(iszero2~=0)
        nke=find(kler>0); % bunlar kalacak
        nke2=find(kler2>0); % bunlar kalacak
        ke=find(kler2<0); % bunlar dizeyden düşecek
        
        sag_local1=zeros(6,2);
        sag_local3=zeros(8,2);
        
        % lis2=[3 2 4 ; 3 1 4; 2 1 4; 2 1 3]; 
        
        for i=1:length(ke)
            
            %Burada noktaların sırası önemli vektörler n1 den n2 ye gidiyor
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
            end
            

            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(1)-xyz2(1))<ep)
            kler2(ke(i))=-1;
            % error('x aynı olmalı');
            elseif(abs(xyz1(2)-xyz2(2))<ep)
            kler2(ke(i))=-3;
            else
            kler2(ke(i))=-5;
            end      

            if(kler2(ke(i))==-1 || kler2(ke(i))==-2) %solda sagda  y-z yönünde açı var
            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(1)-xyz2(1))>ep)
            error('x aynı olmalı');
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
            val=al(1); % sol yada sagdaki kenarın değeri 

            % val=1;

            sag_local1(nke,1)=sag_local1(nke,1)-rot4(nke,ke(i))*val;
            sag_local3(nke2,1)=sag_local3(nke2,1)-rot6(nke2,ke(i))*val;
            
            elseif(kler2(ke(i))==-3 || kler2(ke(i))==-4) %önde arkada x-z yönünde açı var

            xyz1=node(n1,:);
            xyz2=node(n2,:);

            if( abs(xyz1(2)-xyz2(2))>ep)
            error('y aynı olmalı');
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
            val=al(1); % ön yada arka kenarın değeri bu

            sag_local1(nke,2)=sag_local1(nke,2)-rot4(nke,ke(i))*val;
            sag_local3(nke2,2)=sag_local3(nke2,2)-rot6(nke2,ke(i))*val;
        
            elseif(kler2(ke(i))==-5 || kler2(ke(i))==-6) %üstte altta x y yününde açı var
            

            if( abs(xyz1(3)-xyz2(3))>ep)
            error('z aynı olmalı');
            end

            % %BURAYI KAPATINCA BİRŞEY OLMUYOR
            % 
            xyz1=node(n1,:);
            xyz2=node(n2,:);   
            nor(1)=xyz2(1)-xyz1(1);
            nor(2)=xyz2(2)-xyz1(2);
            aci=atan2(nor(2),nor(1))/pi*180;

            % aci=360-aci;

            %Ex basıyorum
            vec=[1;0]; 
            R1=[cosd(aci) -sind(aci) ; sind(aci) cosd(aci)];
            al=R1*vec;
            val=al(1); % üst yada alt
            % val=al(2); % üst yada alt

            % val=1;
            sag_local1(nke,2)=sag_local1(nke,2)-rot4(nke,ke(i))*val;
            sag_local3(nke2,2)=sag_local3(nke2,2)-rot6(nke2,ke(i))*val;           
            val=al(2); % üst yada alt

            % val=al(1);
            % val=1;

            sag_local1(nke,1)=sag_local1(nke,1)-rot4(nke,ke(i))*val;
            sag_local3(nke2,1)=sag_local3(nke2,1)-rot6(nke2,ke(i))*val;

            else
            error('1-6 olmalı');

            end
        end

        sag(kler(nke),:)=sag(kler(nke),:)+sag_local1(nke,:);
        sag(kler2(nke2)+totkenar*2,:)=sag(kler2(nke2)+totkenar*2,:)+sag_local3(nke2,:);
        

    end

end


% return

R1=sparse(ix1,iy1,iv1a,totkenar*2+totyuzey*2,totkenar*2+totyuzey*2); % double curl
M1=sparse(ix1,iy1,iv1b,totkenar*2+totyuzey*2,totkenar*2+totyuzey*2); % 
D1=sparse(ix3,iy3,iv3,totnode+totkenar,totkenar*2+totyuzey*2); % 
P1=sparse(ix4,iy4,iv4,totnode+totkenar,totnode+totkenar); % 



% return

R1=spmdReduce(@plus,R1,1);
M1=spmdReduce(@plus,M1,1);
D1=spmdReduce(@plus,D1,1);
P1=spmdReduce(@plus,P1,1);

sag=spmdReduce(@plus,sag,1);

end

R1=R1{1};
M1=M1{1};
D1=D1{1};
P1=P1{1};

sag=sag{1};





return

load('DTM1_IE_veri.mat');
P=2;
ara=[21,14];    
a=e{11,P};
T=a(1:21,5);
ff=1./T;


kk=1;
kk=21;

f=ff(kk); % frekanslar
mu=4*pi*10^-7;
w=2*pi*f;

kat=sqrt(-1)*w*mu;


kat2=mu;
kat3=mu*sqrt(-1)/w;


B1=[R1+kat*M1];
Amatris1=[B1 -kat2*D1' ; ...
          -kat2*D1  -kat3*P1];
bsag=sag(1:totkenar*3+totyuzey*2+totnode,:);
MM=blkdiag(B1,-kat3*P1);



[x1,res1,relres1] = gpbicgV4M9(Amatris1,bsag(:,1),MM,10^-9,200);
% [x2,res2,relres2] = gpbicgV4M9(Amatris1,bsag(:,2),MM,10^-9,200,x2);


return


load('DTM1_IE_veri.mat');
P=2;
ara=[21,14];    
a=e{11,P};
T=a(1:21,5);
ff=1./T;


kk=21;


f=ff(kk); % frekanslar
mu=4*pi*10^-7;
w=2*pi*f;

kat=sqrt(-1)*w*mu;


kat2=mu;
kat3=mu*sqrt(-1)/w;


Amatris1=[R1+kat*M1];


[kappa_est, invA1_est, it] = condest_hager_core(Amatris1, 18);

kappa_est/10^12




return


load('DTM1_IE_veri.mat');
P=2;
ara=[21,14];    
a=e{11,P};
T=a(1:21,5);
ff=1./T;




for kk=1:length(ff)




f=ff(kk); % frekanslar
mu=4*pi*10^-7;
w=2*pi*f;

kat=sqrt(-1)*w*mu;


kat2=mu;
kat3=mu*sqrt(-1)/w;


B1=[R1+kat*M1];
Amatris1=[B1 -kat2*D1' ; ...
          -kat2*D1  -kat3*P1];


bsag=sag(1:totkenar*3+totyuzey*2+totnode,:);


dr=totkenar*2+totyuzey*2;
Amatris2=Amatris1(1:dr,1:dr);
sag2=sag(1:dr,:);

[v0,r0,c0]=sparse2csr(Amatris2);
rowg=gpuArray(r0);
colg=gpuArray(c0);
valg=gpuArray(v0);
bg=gpuArray(sag2);

tic
[xx]=LUcuDSS(rowg,colg,valg,complex(bg),int32(2)); %sweeping
toc

relres=norm(Amatris2*xx-sag2)/norm(sag2);
fprintf("Düz çözüm relative residual=%e\n",relres);

xx=gather(xx);
dr2=size(bsag,1);

xx=[xx;zeros(dr2-dr,2)];

x1=xx(:,1);
x2=xx(:,2);





M=ones(4,4);
mu=4*pi*10^-7;
clear G le kler a b c d gradnode jj
for jj=1:size(recv,1)

    ii=recv(jj,4); 

    % iii=xyon(jj);
    % ii=yuzeyeleman(iii,1); 
    % ll=yuzeyeleman(iii,3:5);



    nler=eleman(ii,1:4);
    % ll=recv(jj,5:7);
    
    XYZ=node(nler,:)';

    % x0=recv(jj,1);
    % y0=recv(jj,2);
    x0=mean(XYZ(1,:)); 
    y0=mean(XYZ(2,:));    
    z0=mean(XYZ(3,:))+10; 
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
        elseif(nnz(al)==1)
            kler2(i)=yuzeybd(ii,sw);
            kler2(i+4)=kler2(i)+totyuzey;
            if(kler2(i)==0)
            error('0 index');
            end
        else
            kler2(i)=yuzeybd(ii,sw);
            kler2(i+4)=kler2(i);
            if(kler2(i)==0)
            error('0 index');
            end
        end
    end
    kler2=kler2+totkenar*2;


    klern=EL(ii,12:15)-totkenar;
    klern=[klern kler(1:6)+totnode]+totkenar*2+totyuzey*2;


    le(1)=sqrt((XYZ(1,1)-XYZ(1,2))^2+(XYZ(2,1)-XYZ(2,2))^2+(XYZ(3,1)-XYZ(3,2))^2);
    le(2)=sqrt((XYZ(1,1)-XYZ(1,3))^2+(XYZ(2,1)-XYZ(2,3))^2+(XYZ(3,1)-XYZ(3,3))^2);
    le(3)=sqrt((XYZ(1,1)-XYZ(1,4))^2+(XYZ(2,1)-XYZ(2,4))^2+(XYZ(3,1)-XYZ(3,4))^2);
    le(4)=sqrt((XYZ(1,2)-XYZ(1,3))^2+(XYZ(2,2)-XYZ(2,3))^2+(XYZ(3,2)-XYZ(3,3))^2);
    le(5)=sqrt((XYZ(1,2)-XYZ(1,4))^2+(XYZ(2,2)-XYZ(2,4))^2+(XYZ(3,2)-XYZ(3,4))^2);
    le(6)=sqrt((XYZ(1,3)-XYZ(1,4))^2+(XYZ(2,3)-XYZ(2,4))^2+(XYZ(3,3)-XYZ(3,4))^2);
    le(1:6)=1;
  



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
    duzkenar(i,:)=(L1*p2-L2*p1)/(6*Ve)*le(i);
    duzkenar(i+6,:)=(L1*p2+L2*p1)/(6*Ve)*le(i);
    
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

    end


    for i=1:4
    i1=i;        
    L1=duzkose(i1);
    p1=G(i1,:);
    gradnode(i,:)=(4*L1*p1-p1)/(6*Ve);
    end

    for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);  

    L1=duzkose(i1);
    L2=duzkose(i2);    
    p1=G(i1,:);
    p2=G(i2,:);    

    gradnode(i+4,:)=(4*L1*p2+4*L2*p1)/(6*Ve);
    end    
 
    Rx=eye(3);
    Rz=eye(3);
    Ry=eye(3);

    duzkenarA=[duzkenar;duzkenar2];
    rotkenarA=[rotkenar;rotkenar2];
   

    duzkenarf=[-sqrt(-1)*w*duzkenarA;-gradnode ];
    rotkenarf=[rotkenarA/mu;zeros(10,3)];  %%%
    klerf=[kler kler2 klern];

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

    Z=inv([hx1 hy1;hx2 hy2])*[ex1 ey1 -hz1;ex2 ey2 -hz2];    
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




load('DTM1_IE_veri.mat');
P=2;
ara=[21,14];    

a=e{11,P};


xx1=real(a(1:21:end,7));


save('mixedsecondDTM1.mat','R1','M1','roa','faza','Zler','Tler');




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


zxx=abs(E(:,5)+sqrt(-1)*E(:,6)).^2.*0.2.*E(:,4);

zxx=abs(E(:,5)+sqrt(-1)*E(:,6)).^2./(mu*2*pi./E(:,4));
zxy=abs(E(:,7)+sqrt(-1)*E(:,8)).^2./(mu*2*pi./E(:,4));
zyx=abs(E(:,9)+sqrt(-1)*E(:,10)).^2./(mu*2*pi./E(:,4));
zyy=abs(E(:,11)+sqrt(-1)*E(:,12)).^2./(mu*2*pi./E(:,4));

zxxf=angle(E(:,5)+sqrt(-1)*E(:,6))/pi*180;
zxyf=angle(E(:,7)+sqrt(-1)*E(:,8))/pi*180;
zyxf=angle(E(:,9)+sqrt(-1)*E(:,10))/pi*180;
zyyf=angle(E(:,11)+sqrt(-1)*E(:,12))/pi*180;





st=9;

figure;
subplot(4,2,1);loglog(ff,zxx,'x'); axis([min(ff) max(ff) 10^-6 1]);
hold on; semilogx(ff,squeeze(roa(:,st,4)),'o');title('Zxx');
subplot(4,2,2);semilogx(ff,zxxf,'x');
hold on; semilogx(ff,squeeze(faza(:,st,4))+180,'o');title('Zxx');



subplot(4,2,3);semilogx(ff,zxy,'x');
hold on; semilogx(ff,squeeze(roa(:,st,3)),'o');title('Zxy');
subplot(4,2,4);semilogx(ff,zxyf,'x');
hold on; semilogx(ff,squeeze(faza(:,st,3))+180,'o');title('Zxy');


subplot(4,2,5);semilogx(ff,zyx,'x');
hold on; semilogx(ff,squeeze(roa(:,st,2)),'o');title('Zyx');
subplot(4,2,6);semilogx(ff,zyxf,'x');
hold on; semilogx(ff,squeeze(faza(:,st,2))-180,'o');title('Zyx');


subplot(4,2,7);loglog(ff,zyy,'x');axis([min(ff) max(ff) 10^-6 1]);
hold on; semilogx(ff,squeeze(roa(:,st,1)),'o');title('Zyy');xlabel('frequency');
subplot(4,2,8);semilogx(ff,zyyf,'x');xlabel('frequency');
hold on; semilogx(ff,squeeze(faza(:,st,1))-180,'o');title('Zyy');



ezxx=abs((zxx-squeeze(roa(:,st,4)))./zxx)*100;
ezxy=abs((zxy-squeeze(roa(:,st,3)))./zxy)*100;
ezyx=abs((zyx-squeeze(roa(:,st,2)))./zyx)*100;
ezyy=abs((zyy-squeeze(roa(:,st,1)))./zyy)*100;


figure;
semilogx(ff,ezxy,'+');hold on;semilogx(ff,ezyx,'v');hold on;
legend('Zxy error','Zyx error');xlabel('frequency');ylabel('%');





