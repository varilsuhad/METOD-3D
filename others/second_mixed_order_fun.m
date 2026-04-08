function [R1,M1,sag] = second_mixed_order_fun(eleman,node,EL)
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


al=EL(:,5:10);
totkenar=max(al(:));

al=EL(:,16:19);
totyuzey=max(al(:));

sag=zeros(totkenar*2+totyuzey*2,2);

ix1=[];iy1=[];iv1a=[];iv1b=[];sayac1=0; %rot +F

rot1=zeros(6,6);  %edge1 edge1
F1=zeros(6,6);    %edge1 edge1
B1=zeros(6,4);
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



F1=sigma*F1; %sonrada iw ve mu ekleyeceğiz şimdilik reel olarak kalsın
F2=sigma*F2;
F3=sigma*F3;
F4=sigma*F4;
F5=sigma*F5;
F6=sigma*F6;


FF=[F1 F2 F4;
    F2' F3 F5;
    F4' F5' F6];

RR=[rot1 zeros(6,6) rot4;...
   zeros(6,6) zeros(6,6) zeros(6,8);...
   rot4' zeros(8,6) rot6];


kler=EL(ii,5:10);


kler2=EL(ii,16:19);
al=EL(ii,16:19);
al(al>0)=al(al>0)+totyuzey;
kler2(5:8)=al;



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


R1=sparse(ix1,iy1,iv1a,totkenar*2+totyuzey*2,totkenar*2+totyuzey*2); % double curl
M1=sparse(ix1,iy1,iv1b,totkenar*2+totyuzey*2,totkenar*2+totyuzey*2); % 

R1=spmdReduce(@plus,R1,1);
M1=spmdReduce(@plus,M1,1);

sag=spmdReduce(@plus,sag,1);

end

R1=R1{1};
M1=M1{1};
sag=sag{1};






end