function [R1,M1,sag] = third_mixed_order_fun(eleman,node,EL)

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

eleman=eleman';
node=node';

ep=10^-5;

lis=[1 2;1 3; 1 4 ; 2 3; 2 4 ;3 4]; %bu kenar node listesi
lis2=[3 2 4 ; 3 1 4; 2 1 4; 2 1 3];
lis3=[1 2 3 4 ; 2 3 4 1; 3 4 1 2; 4 1 2 3];

d=zeros(4,1);
c=d;b=d;a=d;
le=zeros(6,1);
M=ones(4,4);

Clar=zeros(4,4,3);
Dlar=zeros(4,4);
CDlar=zeros(4,4,4,4);

al=EL(:,5:10);
totkenar=max(al(:));

al=EL(:,16:19);
totyuzey=max(al(:));

totel=size(EL,1);

sag=zeros(totkenar*3+totyuzey*6+totel*3,2);
ix1=[];iy1=[];iv1a=[];iv1b=[];sayac1=0; %rot +F

rot1=zeros(6,6);  %edge1 edge1
F1=zeros(6,6);    %edge1 edge1

kler=zeros(1,6);

spmd

for ii=1:size(eleman,1)

if(mod(ii,spmdSize)==spmdIndex-1)
else
continue;
end

sigma=1./EL(ii,11);
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
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        rot22(i,j)=sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

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
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        rot22(i,j+4)=sum1;

        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);

        sum1=0;
       for jj=1:length(xa)

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
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        rot22(i+4,j)=sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

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
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        rot22(i+4,j+4)=sum1;

        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);

        sum1=0;
       for jj=1:length(xa)

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
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);

        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        rot23(i,j)=sum1;

        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);

        sum1=0;
       for jj=1:length(xa)

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
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);

        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);

        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        rot27(i,j)=sum1;

    i1=lis2(i,2);
    i2=lis2(i,3);
    i3=lis2(i,1);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);

        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        rot27(i+4,j)=sum1;

        i1=lis2(i,3);
        i2=lis2(i,1);
        i3=lis2(i,2);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross((L2^2-2*L2*L3)*p3+(2*L2*L3-L3^2)*p2,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);

        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(i4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(i4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=4*cross(L3*L4*p2+L2*L4*p3+L2*L3*p4,p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F7(i,j)=sum1*le(i)*le(j);
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(L1*p2-L2*p1);

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F8(i,j)=le(i)*sum1;

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2+L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F9(i,j)=sum1*le(i)*le(j);
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

        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F10(i,j)=le(i)*sum1;

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F11(i,j)=sum1*le(i)*le(j);
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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F12(i,j)=le(i)*sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=L2*(L3*p1-L1*p3)+L3*(L2*p1-L1*p2);

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F12(i,j+4)=le(i)*sum1;

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F13(i,j)=le(i)*sum1;

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

        sek2=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F14(i,j)=sum1;

        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);

        sum1=0;
       for jj=1:length(xa)

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F16(i,j)=le(i)*sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F16(i,j+4)=le(i)*sum1;

        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F16(i,j+8)=le(i)*sum1;

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2-L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);

        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F17(i,j)=le(i)*sum1;

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2+L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F18(i,j)=le(i)*sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2+L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F18(i,j+4)=le(i)*sum1;

        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2+L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F18(i,j+8)=le(i)*sum1;

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2+L2*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);

        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F19(i,j)=le(i)*sum1;

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F20(i,j)=le(i)*sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F20(i,j+4)=le(i)*sum1;

        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F20(i,j+8)=le(i)*sum1;

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);

        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F21(i,j)=le(i)*sum1;

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

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F22(i,j)=sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

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

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F22(i,j+4)=sum1;

        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);

        sum1=0;
       for jj=1:length(xa)

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

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F22(i+4,j)=sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

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

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F22(i+4,j+4)=sum1;

        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);

        sum1=0;
       for jj=1:length(xa)

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
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F23(i,j)=sum1;

        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);

        sum1=0;
       for jj=1:length(xa)

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
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F24(i,j)=sum1;

        j1=lis2(j,2);
        j2=lis2(j,3);
        j3=lis2(j,1);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F24(i,j+4)=sum1;

        j1=lis2(j,3);
        j2=lis2(j,1);
        j3=lis2(j,2);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*L2*p3+L1*L3*p2+L2*L3*p1;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F27(i,j)=sum1;

        i1=lis2(i,2);
        i2=lis2(i,3);
        i3=lis2(i,1);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F27(i+4,j)=sum1;

        i1=lis2(i,3);
        i2=lis2(i,1);
        i3=lis2(i,2);

        sum1=0;
       for jj=1:length(xa)

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=(3*L2^2*L3-3*L2*L3^2)*p1+(L1*L3^2-2*L1*L2*L3)*p2+(2*L1*L2*L3-L1*L2^2)*p3;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

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

        p1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(i4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(i2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(i3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(i4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;

        p1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        p3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,2);
        p4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=sekil1(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=sekil1(j2,xa(jj),ya(jj),za(jj),Jxyz,1);
        L3=sekil1(j3,xa(jj),ya(jj),za(jj),Jxyz,1);
        L4=sekil1(j4,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=3*L2*L3*L4*p1-L1*L3*L4*p2-L1*L2*L4*p3-L1*L2*L3*p4;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        F28(i,j)=sum1;

    end
end

F1=sigma*F1; %sonrada iw ve mu ekleyeceğiz şimdilik reel olarak kalsın
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

kler=EL(ii,5:10);

kler2=EL(ii,16:19);
al=EL(ii,16:19);
al(al>0)=al(al>0)+totyuzey;
kler2(5:8)=al;
al(al>0)=al(al>0)+totyuzey;
kler2(9:12)=al;

klerv2=zeros(1,45);  %tüm non-phi
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

% return

iszerov2=length(find(klerv2<0));  %tüm non-phi

    if(iszerov2==0)

        rr=repmat(klerv2',[1 45]); %row nolar
        cc=rr'; %col nolar;

        ix1(sayac1+1:sayac1+2025)=rr(:);
        iy1(sayac1+1:sayac1+2025)=cc(:);
        iv1a(sayac1+1:sayac1+2025)=RR(:);
        iv1b(sayac1+1:sayac1+2025)=FF(:);
        sayac1=sayac1+2025;
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

    iszero=length(find(kler<0));

    if(iszero~=0) %Eğer sınıra denk gelmiyorsa burası

        %Eğer sınırda kenar varsa burası

        ke=find(kler<0); % bunlar dizeyden düşecek
        nke=find(kler>0); % bunlar kalacak
        nke2=find(kler2(1:8)>0); % bunlar kalacak
        nke3=find(kler2>0); % bunlar kalacak

        sag_local1=zeros(6,2);
        sag_local4=zeros(8,2);
        sag_local6=zeros(12,2);
        sag_local7=zeros(3,2);

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
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot4(ke(i),nke2)'*val;

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
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot4(ke(i),nke2)'*val;

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
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot4(ke(i),nke2)'*val;

            val=al(2);

            sag_local1(nke,1)=sag_local1(nke,1)-rot1(nke,ke(i))*val;
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot4(ke(i),nke2)'*val;

            else
            error('1-6 olmalı');

            end
        end

            sag(kler(nke),:)=sag(kler(nke),:)+sag_local1(nke,:);
            sag(kler2(nke2)+totkenar*3,:)=sag(kler2(nke2)+totkenar*3,:)+sag_local4(nke2,:);
         end

    iszero2=length(find(kler2<0));

    if(iszero2~=0)
        nke=find(kler>0); % bunlar kalacak
        nke2=find(kler2(1:8)>0); % bunlar kalacak
        nke3=find(kler2>0); % bunlar kalacak
        ke=find(kler2<0); % bunlar dizeyden düşecek

        sag_local1=zeros(6,2);
        sag_local4=zeros(8,2);
        sag_local6=zeros(12,2);
        sag_local7=zeros(3,2);

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
            if(ke(i)<=8)
            sag_local1(nke,1)=sag_local1(nke,1)-rot4(nke,ke(i))*val;
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot6(nke2,ke(i))*val;
            sag_local6(nke3,1)=sag_local6(nke3,1)-rot22(ke(i),nke3)'*val;
            sag_local7(:,1)=sag_local7(:,1)-rot23(ke(i),:)'*val;
            end
            sag_local4(nke2,1)=sag_local4(nke2,1)-rot22(nke2,ke(i))*val;
            sag_local6(nke3,1)=sag_local6(nke3,1)-rot26(nke3,ke(i))*val;
            sag_local7(:,1)=sag_local7(:,1)-rot27(ke(i),:)'*val;

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

            if(ke(i)<=8)
            sag_local1(nke,2)=sag_local1(nke,2)-rot4(nke,ke(i))*val;
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot6(nke2,ke(i))*val;
            sag_local6(nke3,2)=sag_local6(nke3,2)-rot22(ke(i),nke3)'*val;
            sag_local7(:,2)=sag_local7(:,2)-rot23(ke(i),:)'*val;
            end
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot22(nke2,ke(i))*val;
            sag_local6(nke3,2)=sag_local6(nke3,2)-rot26(nke3,ke(i))*val;
            sag_local7(:,2)=sag_local7(:,2)-rot27(ke(i),:)'*val;

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

            if(ke(i)<=8)
            sag_local1(nke,2)=sag_local1(nke,2)-rot4(nke,ke(i))*val;
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot6(nke2,ke(i))*val;
            sag_local6(nke3,2)=sag_local6(nke3,2)-rot22(ke(i),nke3)'*val;
            sag_local7(:,2)=sag_local7(:,2)-rot23(ke(i),:)'*val;
            end
            sag_local4(nke2,2)=sag_local4(nke2,2)-rot22(nke2,ke(i))*val;
            sag_local6(nke3,2)=sag_local6(nke3,2)-rot26(nke3,ke(i))*val;
            sag_local7(:,2)=sag_local7(:,2)-rot27(ke(i),:)'*val;

            val=al(2); % üst yada alt

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
            error('1-6 olmalı');

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

end
