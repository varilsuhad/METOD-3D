% ========================================================================
% Author: Deniz Varılsüha
% Affiliation: Istanbul Technical University (ITU)
% Contact: deniz.varilsuha@itu.edu.tr
% Journal: Computers & Geosciences
% Manuscript metadata: Included for journal submission compliance
% Last updated: 2026-04-08
% ========================================================================
% Forward modeling routine for the TM2/TMM model using mixed third-order
% basis functions.
% This script assembles and solves the mixed-order system, then computes
% MT impedance, apparent resistivity, and phase responses.
clear all;clc;close all;
format longG

reset(gpuDevice);
load('TM2_cubic.mat');

eleman=sort(eleman,1);
[EL,node_no,edge_no,totkenar,totyuzey,yuzey_no,yuzeybd] = build_tet_topology_maps(node,eleman,rho); %Element matrix

[R1,M1,sag] = third_mixed_order_fun(eleman,node,EL);
eleman=eleman';
node=node';

% return

lis=[1 2;1 3; 1 4 ; 2 3; 2 4 ;3 4]; %this is the edge-node list
lis2=[3 2 4 ; 3 1 4; 2 1 4; 2 1 3];
lis3=[1 2 3 4 ; 2 3 4 1; 3 4 1 2; 4 1 2 3];

ww=load('usuimodelFEFF.mat');
flist=ww.f;

for kk=1:length(flist)

f=flist(kk); % frequencies

mu=4*pi*10^-7;
w=2*pi*f;
kat=sqrt(-1)*w*mu;

Amatris=[R1+kat*M1];

[v0,r0,c0]=sparse2csr(Amatris);
rowg=gpuArray(r0);
colg=gpuArray(c0);
valg=gpuArray(v0);
bg=gpuArray(sag);

tic
[xx]=LUcuDSSMG(rowg,colg,valg,complex(bg),int32(size(bg,2)),int32(2)); %sweeping
toc

relres=norm(Amatris*xx-sag)/norm(sag);
fprintf("Direct solution relative residual=%e\n",relres);

xx=gather(xx);
x1=xx(:,1);
x2=xx(:,2);

% [val,row,col]=sparse2csr(Amatris,1);
% n = size(sag,1);
%
% tic
% pardiso_LUC(1,row,col,n) ;  % analyze
% toc
%
% tic
% pardiso_LUC(2,val);
% toc
%
% tic
% x=pardiso_LUC(3,complex(sag));
% toc
%
% pardiso_LUC(4)
%

totel=size(EL,1);

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

    duzkenar(i,:)=(L1*p2-L2*p1)/(6*Ve)*le(i);
    duzkenar(i+6,:)=(L1*p2+L2*p1)/(6*Ve)*le(i);
    duzkenar(i+12,:)=((2*L1*L2-L2^2)*p1+(L1^2-2*L1*L2)*p2)/(6*Ve)*le(i);
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

    duzkenarA=[duzkenar;duzkenar2;duzkenar3];
    rotkenarA=[rotkenar;rotkenar2;rotkenar3];

    duzkenarf=[duzkenarA];
    rotkenarf=[rotkenarA/(-sqrt(-1)*w*mu)];
    klerf=[kler kler2 kler3];

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

    Zler(kk,jj,1)=Z(1,1);
    Zler(kk,jj,2)=Z(1,2);
    Zler(kk,jj,3)=Z(2,1);
    Zler(kk,jj,4)=Z(2,2);
    Tler(kk,jj,1)=T(1,1);
    Tler(kk,jj,2)=T(2,1);

    Zler0(kk,jj,1)=Z0(1,1);
    Zler0(kk,jj,2)=Z0(1,2);
    Zler0(kk,jj,3)=Z0(2,1);
    Zler0(kk,jj,4)=Z0(2,2);
    Tler0(kk,jj,1)=T0(1,1);
    Tler0(kk,jj,2)=T0(2,1);

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
