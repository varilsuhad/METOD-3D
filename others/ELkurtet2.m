function [EL,node_number,K2,totkenar,totyuzey,Y1,yuzeybd,EL2,K,yuzeybd2] = ELkurtet2(node,eleman,rho)

%%%SORT ediyorumki DoF yönleri karışmasın
eleman=sort(eleman,1);

%Sınırlardaki node'ların değerini bulduk

xmin=min(node(1,:));
xmax=max(node(1,:));

ymin=min(node(2,:));
ymax=max(node(2,:));

zmin=min(node(3,:));
zmax=max(node(3,:));

%Şimdi eleman matrisine bakıp kenar tanımlayalım
%Bir sparse matris oluşturacağım burada

c=0;
ix=[];iy=[];iv=[];
for i=1:size(eleman,2)
    al=eleman(:,i);
    al=sort(al,'ascend');

    %toplam 6 adet kenar
    for j=2:4
        c=c+1;
        ix(c)=al(1);iy(c)=al(j);iv(c)=1;
    end

    for j=3:4
        c=c+1;
        ix(c)=al(2);iy(c)=al(j);iv(c)=1;
    end

        c=c+1;
        ix(c)=al(3);iy(c)=al(4);iv(c)=1;
end

tot=size(node,2);
K=sparse(ix,iy,iv,tot,tot);

ep=10^-5;
c=0;

%Sınırdaki nodelar bulunur
sinir_node=zeros(size(node,2),1);
for i=1:size(node,2)
    xi=node(1,i);
    yi=node(2,i);
    zi=node(3,i);

    con1=abs(xi-xmin)<ep;
    con2=abs(xi-xmax)<ep;
    con3=abs(yi-ymin)<ep;
    con4=abs(yi-ymax)<ep;
    con5=abs(zi-zmin)<ep;
    con6=abs(zi-zmax)<ep;

    if(con5==1)
    c=c+1;
    end

    if(con1==1 && (con2==0 && con3==0 && con4==0 && con5==0 && con6==0))
    sinir_node(i)=1; %solda
    elseif (con2==1 && (con1==0 && con3==0 && con4==0 && con5==0 && con6==0))
    sinir_node(i)=2; %sagda
    elseif(con3==1 && (con1==0 && con2==0 && con4==0 && con5==0 && con6==0))
    sinir_node(i)=3;  %önde
    elseif(con4==1 && (con1==0 && con2==0 && con3==0 && con5==0 && con6==0))
    sinir_node(i)=4;   %arkada
    elseif(con5==1 && (con1==0 && con2==0 && con3==0 && con4==0 && con6==0))
    sinir_node(i)=5;   %üstte
    elseif(con6==1 && (con1==0 && con2==0 && con3==0 && con4==0 && con5==0))
    sinir_node(i)=6;   %altta
    elseif(con1==1 && con3==1 && con5==1 && (con2==0 && con4==0 && con6==0))
    sinir_node(i)=7;   % köşe no1
    elseif(con2==1 && con3==1 && con5==1 && (con1==0 && con4==0 && con6==0))
    sinir_node(i)=8;   % köşe no2
    elseif(con2==1 && con4==1 && con5==1 && (con1==0 && con3==0 && con6==0))
    sinir_node(i)=9;   % köşe no3
    elseif(con1==1 && con4==1 && con5==1 && (con2==0 && con3==0 && con6==0))
    sinir_node(i)=10;   % köşe no4
    elseif(con1==1 && con3==1 && con6==1 && (con2==0 && con4==0 && con5==0))
    sinir_node(i)=11;   % köşe no5
    elseif(con2==1 && con3==1 && con6==1 && (con1==0 && con4==0 && con5==0))
    sinir_node(i)=12;   % köşe no6
    elseif(con2==1 && con4==1 && con6==1 && (con1==0 && con3==0 && con5==0))
    sinir_node(i)=13;   % köşe no7
    elseif(con1==1 && con4==1 && con6==1 && (con2==0 && con3==0 && con5==0))
    sinir_node(i)=14;   % köşe no8
    elseif(con1==1 && con5==1 && (con2==0 && con3==0 && con4==0 && con6==0 ))
    sinir_node(i)=15;   % Ey1
    elseif(con2==1 && con5==1 && (con1==0 && con3==0 && con4==0 && con6==0 ))
    sinir_node(i)=16;   % Ey3
    elseif(con1==1 && con6==1 && (con2==0 && con3==0 && con4==0 && con5==0 ))
    sinir_node(i)=17;   % Ey2
    elseif(con2==1 && con6==1 && (con1==0 && con3==0 && con4==0 && con5==0 ))
    sinir_node(i)=18;   % Ey4
    elseif(con3==1 && con5==1 && (con1==0 && con2==0 && con4==0 && con6==0 ))
    sinir_node(i)=19;   % Ex1
    elseif(con4==1 && con5==1 && (con1==0 && con2==0 && con3==0 && con6==0 ))
    sinir_node(i)=20;   % Ex2
    elseif(con3==1 && con6==1 && (con1==0 && con2==0 && con4==0 && con5==0 ))
    sinir_node(i)=21;   % Ex3
    elseif(con4==1 && con6==1 && (con1==0 && con2==0 && con3==0 && con5==0 ))
    sinir_node(i)=22;   % Ex4
    elseif(con1==1 && con3==1 && (con2==0 && con4==0 && con5==0 && con6==0 ))
    sinir_node(i)=23;   % Ez1
    elseif(con2==1 && con3==1 && (con1==0 && con4==0 && con5==0 && con6==0 ))
    sinir_node(i)=24;   % Ez2
    elseif(con1==1 && con4==1 && (con2==0 && con3==0 && con5==0 && con6==0 ))
    sinir_node(i)=25;   % Ez3
    elseif(con2==1 && con4==1 && (con1==0 && con3==0 && con5==0 && con6==0 ))
    sinir_node(i)=26;   % Ez4
    else
    sinir_node(i)=0;
    end

end

%Şimdi kenarları numaralandıralım sınırlardaki kenarların no'su farklı
%olacak
[ix,iy,iv]=find(K);

ix2=ix;
iy2=iy;
iv2=1:length(iv);
K=sparse(ix2,iy2,iv2,tot,tot);

%Kenarlar numaralandırılır
c=0;
c2=0;
for i=1:length(ix)

xi=ix(i);
yi=iy(i);

c2=c2+1;
iv2(i)=c2;

if(sinir_node(xi)==0 || sinir_node(yi)==0)
    c=c+1;
    iv(i)=c;
    % continue;
else

    if ((sinir_node(xi)==1 || sinir_node(xi)==7 || sinir_node(xi)==10 || sinir_node(xi)==11 || sinir_node(xi)==14 ...
        || sinir_node(xi)==15 || sinir_node(xi)==17 || sinir_node(xi)==23 || sinir_node(xi)==25) && ...
        (sinir_node(yi)==1 || sinir_node(yi)==7 || sinir_node(yi)==10 || sinir_node(yi)==11 || sinir_node(yi)==14 ...
        || sinir_node(yi)==15 || sinir_node(yi)==17 || sinir_node(yi)==23 || sinir_node(yi)==25))
    iv(i)=-1;  % ayırt edebilmek için
    %kenar solda
    elseif ((sinir_node(xi)==2 || sinir_node(xi)==8 || sinir_node(xi)==9 || sinir_node(xi)==12 || sinir_node(xi)==13 ...
        || sinir_node(xi)==16 || sinir_node(xi)==18 || sinir_node(xi)==24 || sinir_node(xi)==26) && ...
        (sinir_node(yi)==2 || sinir_node(yi)==8 || sinir_node(yi)==9 || sinir_node(yi)==12 || sinir_node(yi)==13 ...
        || sinir_node(yi)==16 || sinir_node(yi)==18 || sinir_node(yi)==24 || sinir_node(yi)==26))
    iv(i)=-2;
    %kenar sagda
    elseif ((sinir_node(xi)==3 || sinir_node(xi)==7 || sinir_node(xi)==8 || sinir_node(xi)==11 || sinir_node(xi)==12 ...
        || sinir_node(xi)==19 || sinir_node(xi)==21 || sinir_node(xi)==23 || sinir_node(xi)==24) && ...
        (sinir_node(yi)==3 || sinir_node(yi)==7 || sinir_node(yi)==8 || sinir_node(yi)==11 || sinir_node(yi)==12 ...
        || sinir_node(yi)==19 || sinir_node(yi)==21 || sinir_node(yi)==23 || sinir_node(yi)==24))
    iv(i)=-3;
    %kenar önde
    elseif ((sinir_node(xi)==4 || sinir_node(xi)==9 || sinir_node(xi)==10 || sinir_node(xi)==13 || sinir_node(xi)==14 ...
        || sinir_node(xi)==20 || sinir_node(xi)==22 || sinir_node(xi)==25 || sinir_node(xi)==26) && ...
        (sinir_node(yi)==4 || sinir_node(yi)==9 || sinir_node(yi)==10 || sinir_node(yi)==13 || sinir_node(yi)==14 ...
        || sinir_node(yi)==20 || sinir_node(yi)==22 || sinir_node(yi)==25 || sinir_node(yi)==26))
    iv(i)=-4;
    %kenar arkada
    elseif ((sinir_node(xi)==5 || sinir_node(xi)==7 || sinir_node(xi)==8 || sinir_node(xi)==9 || sinir_node(xi)==10 ...
        || sinir_node(xi)==19 || sinir_node(xi)==20 || sinir_node(xi)==15 || sinir_node(xi)==16) && ...
        (sinir_node(yi)==5 || sinir_node(yi)==7 || sinir_node(yi)==8 || sinir_node(yi)==9 || sinir_node(yi)==10 ...
        || sinir_node(yi)==19 || sinir_node(yi)==20 || sinir_node(yi)==15 || sinir_node(yi)==16))
    iv(i)=-5;
    %kenar üstte
    elseif ((sinir_node(xi)==6 || sinir_node(xi)==11 || sinir_node(xi)==12 || sinir_node(xi)==13 || sinir_node(xi)==14 ...
        || sinir_node(xi)==21 || sinir_node(xi)==22 || sinir_node(xi)==17 || sinir_node(xi)==18) && ...
        (sinir_node(yi)==6 || sinir_node(yi)==11 || sinir_node(yi)==12 || sinir_node(yi)==13 || sinir_node(yi)==14 ...
        || sinir_node(yi)==21 || sinir_node(yi)==22 || sinir_node(yi)==17 || sinir_node(yi)==18))
    iv(i)=-6;
    %kenar altta
    elseif ((sinir_node(xi)==7 || sinir_node(xi)==8) && (sinir_node(yi)==7 || sinir_node(yi)==8))
    iv(i)=-3;
    %kenar Ex1
    elseif ((sinir_node(xi)==9 || sinir_node(xi)==10) && (sinir_node(yi)==9 || sinir_node(yi)==10))
    iv(i)=-4;
    %kenar Ex2
    elseif ((sinir_node(xi)==11 || sinir_node(xi)==12) && (sinir_node(yi)==11 || sinir_node(yi)==12))
    iv(i)=-3;
    %kenar Ex3
    elseif ((sinir_node(xi)==13 || sinir_node(xi)==14) && (sinir_node(yi)==13 || sinir_node(yi)==14))
    iv(i)=-4;
    %kenar Ex4
    elseif ((sinir_node(xi)==7 || sinir_node(xi)==10) && (sinir_node(yi)==7 || sinir_node(yi)==10))
    iv(i)=-1;
    %kenar Ey1
    elseif ((sinir_node(xi)==11 || sinir_node(xi)==14) && (sinir_node(yi)==11 || sinir_node(yi)==14))
    iv(i)=-1;
    %kenar Ey2
    elseif ((sinir_node(xi)==8 || sinir_node(xi)==9) && (sinir_node(yi)==8 || sinir_node(yi)==9))
    iv(i)=-2;
    %kenar Ey3
    elseif ((sinir_node(xi)==12 || sinir_node(xi)==13) && (sinir_node(yi)==12 || sinir_node(yi)==13))
    iv(i)=-2;
    %kenar Ey4
    elseif ((sinir_node(xi)==7 || sinir_node(xi)==11) && (sinir_node(yi)==7 || sinir_node(yi)==11))
    iv(i)=-1;
    %kenar Ez1
    elseif ((sinir_node(xi)==8 || sinir_node(xi)==12) && (sinir_node(yi)==8 || sinir_node(yi)==12))
    iv(i)=-2;
    %kenar Ez2
    elseif ((sinir_node(xi)==9 || sinir_node(xi)==13) && (sinir_node(yi)==9 || sinir_node(yi)==13))
    iv(i)=-2;
    %kenar Ez3
    elseif ((sinir_node(xi)==10 || sinir_node(xi)==14) && (sinir_node(yi)==10 || sinir_node(yi)==14))
    iv(i)=-1;
    %kenar Ez4
    elseif( (sinir_node(xi)<=6) && (sinir_node(yi)<=6) && abs(sinir_node(xi)-sinir_node(yi))~=0)
    c=c+1;
    iv(i)=c;
    %Yüzeyler arası meshin içinden geçiyor, sınırda değil
    elseif( ((sinir_node(xi)==23 || sinir_node(xi)==24 || sinir_node(xi)==25 || sinir_node(xi)==26 ) && (sinir_node(yi)==5 || sinir_node(yi)==6)) ...
         || ((sinir_node(yi)==23 || sinir_node(yi)==24 || sinir_node(yi)==25 || sinir_node(yi)==26) && (sinir_node(xi)==5 || sinir_node(xi)==6)))
    %Ez kenarların ortasondaki nokta alt veya üst noktalarla bağ kuramaz
    %meshin içinden geçer
    c=c+1; %%DÜZELTTİM
    iv(i)=c;
    elseif( ((sinir_node(xi)==19 || sinir_node(xi)==20 || sinir_node(xi)==21 || sinir_node(xi)==22) && (sinir_node(yi)==1 || sinir_node(yi)==2)) ...
         || ((sinir_node(yi)==19 || sinir_node(yi)==20 || sinir_node(yi)==21 || sinir_node(yi)==22) && (sinir_node(xi)==1 || sinir_node(xi)==2)))
    %Ex kenarların ortasındaki noktalar Sol ve sag yüzeylerdeki noktalarla
    %bağ kuramaz meshin içinden geçer
    c=c+1; %%DÜZELTTİM
    iv(i)=c;
    elseif( ((sinir_node(xi)==15 || sinir_node(xi)==16 || sinir_node(xi)==17 || sinir_node(xi)==18) && (sinir_node(yi)==3 || sinir_node(yi)==4)) ...
         || ((sinir_node(yi)==15 || sinir_node(yi)==16 || sinir_node(yi)==17 || sinir_node(yi)==18) && (sinir_node(xi)==3 || sinir_node(xi)==4)))
    %Ey kenarların ortasındaki noktalar ön ve arka yüzeylerdeki noktalarla
    %bağ kuramaz meshin içinden geçer
    c=c+1; %%DÜZELTTİM
    iv(i)=c;
    else

        xi
        yi
        sinir_node(xi)
        sinir_node(yi)

        warning('Bir problem var, kesin error');
    end
end
end

sinirdakenar=length(find(iv<0));

totkenar=max(iv);

fprintf("\n %d kenar sınırda ve %d kenar içerde\n", sinirdakenar,totkenar);

%tekrar sparse matrisi kuralım
K2=sparse(ix,iy,iv,tot,tot);
% K2o=sparse(ix,iy,iv2,tot,tot);

%Sınırdaki kenarları çizdirmece
figure;
for i=1:length(sinir_node)
    if(sinir_node(i)~=0)
    hold on;plot3(node(1,i),node(2,i),node(3,i),'.k')
    end
end
rotate3d

for ii=1:length(iv)
    if(iv(ii)<0)
    i1=ix(ii);
    i2=iy(ii);
    hold on;plot3([node(1,i1) node(1,i2)],[node(2,i1) node(2,i2)],[node(3,i1) node(3,i2)],'-k')
    end
end

axis equal

% return

EL=zeros(size(eleman,2),15);
%ilk 4 girdisi nodelar olacak sonraki 6 girdi kenarların no'ları olacak
%11. değer ise rho olsun
%Son 4 numara ise node numaraları olacak, belki ilerde onları da çözmek
%gerekirse diye. Iteratif çözüm için gerekiyor
EL2=zeros(size(eleman,2),10);

ii=find(sinir_node==0);
vec=1:length(ii);
node_number=ones(length(sinir_node),1)*-7;
node_number(ii)=vec;
totnode=length(vec); %sınırda olmayan node sayısı
%Eğer sınırdaysa -7 verdim

fprintf("\n %d node sınırda ve %d node içerde\n", length(sinir_node)-totnode,totnode);

for i=1:size(eleman,2)
    EL(i,1:4)=eleman(:,i);

    n1=eleman(1,i);
    n2=eleman(2,i);
    n3=eleman(3,i);
    n4=eleman(4,i);

    nn=sort([n1 n2]);
    EL(i,5)=K2(nn(1),nn(2));
    EL2(i,1)=K(nn(1),nn(2));

    nn=sort([n1 n3]);
    EL(i,6)=K2(nn(1),nn(2));
    EL2(i,2)=K(nn(1),nn(2));

    nn=sort([n1 n4]);
    EL(i,7)=K2(nn(1),nn(2));
    EL2(i,3)=K(nn(1),nn(2));

    nn=sort([n2 n3]);
    EL(i,8)=K2(nn(1),nn(2));
    EL2(i,4)=K(nn(1),nn(2));

    nn=sort([n2 n4]);
    EL(i,9)=K2(nn(1),nn(2));
    EL2(i,5)=K(nn(1),nn(2));

    nn=sort([n3 n4]);
    EL(i,10)=K2(nn(1),nn(2));
    EL2(i,6)=K(nn(1),nn(2));

    EL(i,11)=rho(i);

    if(node_number(n1)<0)
    EL(i,12)=node_number(n1);
    else
    EL(i,12)=node_number(n1)+totkenar;
    end

    if(node_number(n2)<0)
    EL(i,13)=node_number(n2);
    else
    EL(i,13)=node_number(n2)+totkenar;
    end

    if(node_number(n3)<0)
    EL(i,14)=node_number(n3);
    else
    EL(i,14)=node_number(n3)+totkenar;
    end

    if(node_number(n4)<0)
    EL(i,15)=node_number(n4);
    else
    EL(i,15)=node_number(n4)+totkenar;
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% TÜM ELEMANLAR DAHİL DDÜŞÜRME YOK%%%%%%%%%%%%%%%%%%%

al=EL2(:,1:6);
totkenar2=max(al(:));

%Yüzeyler
ix=[];iy=[];iv=[];
c=0;c2=0;

for i=1:size(EL2,1)

    %yuzey1 12 13 23
    k1=EL2(i,5-4);
    k2=EL2(i,6-4);
    k3=EL2(i,8-4);

    kk=[k1 k2 k3];

    kk=sort(kk(kk>0));
    c=c+1;
    ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;

    %yuzey2  12 14 42
    k1=EL2(i,5-4);
    k2=EL2(i,7-4);
    k3=EL2(i,9-4);

    kk=[k1 k2 k3];

    kk=sort(kk(kk>0));
    c=c+1;
    ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;

    %yuzey3  13 14 34
    k1=EL2(i,6-4);
    k2=EL2(i,7-4);
    k3=EL2(i,10-4);

    kk=[k1 k2 k3];

    kk=sort(kk(kk>0));
    c=c+1;
    ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;

    %yuzey4  23 42 34
    k1=EL2(i,8-4);
    k2=EL2(i,9-4);
    k3=EL2(i,10-4);

    kk=[k1 k2 k3];

    kk=sort(kk(kk>0));
    c=c+1;
    ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;

end

YY1=sparse(ix,iy,iv,totkenar2,totkenar2);
[ix,iy,iv]=find(YY1);

iv=[1:length(iv)];
YY1=sparse(ix,iy,iv,totkenar2,totkenar2);
% totyuzey1=length(iv);

for ii=1:size(EL2,1)

nler=eleman(1:4,ii);
kler=zeros(1,6);

cc=0;
for i=1:3
    for j=i+1:4
        cc=cc+1;
        kler(cc)=full(K(nler(i),nler(j)));
    end
end

kler2=zeros(1,4);
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

    if(nnz(al)>1)
        al=sort(al(al>0));
        kler2(i)=full(YY1(al(1),al(2)));
    end
end

EL2(ii,7:10)=kler2;

end

%Yüzeyler
ix=[];iy=[];iv=[];
c=0;c2=0;
yuzeybd=zeros(size(EL,1),4);

for i=1:size(EL,1)

    % if(i==3469)
    %  i
    % end

    % n1=EL(i,12);
    % n2=EL(i,13);
    % n3=EL(i,14);
    % n4=EL(i,15);

    %yuzey1 12 13 23
    k1=EL(i,5);
    k2=EL(i,6);
    k3=EL(i,8);

    kk=[k1 k2 k3];
    nzk=nnz(kk<0);

    if(nzk==3)
        % yuzeybd(i,4)=max(kk);
        yuzeybd(i,4)=mode(kk);
    elseif(nzk==2)
        c2=c2+1;
        nod=sort(EL(i,1:3));
        addi(c2,:)=[i nod kk(kk>0) 4];
        % c=c+1;
        % ix(c)=kk(kk>0);iy(c)=kk(kk>0);iv(c)=1;
    elseif (nzk==1 || nzk==0)
        kk=sort(kk(kk>0));
        c=c+1;
        ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;
    else
        error('1 yuzey');
    end

    %yuzey2  12 14 42
    k1=EL(i,5);
    k2=EL(i,7);
    k3=EL(i,9);

    kk=[k1 k2 k3];
    nzk=nnz(kk<0);

    if(nzk==3)
        % yuzeybd(i,3)=max(kk);
        yuzeybd(i,3)=mode(kk);
    elseif(nzk==2)
        c2=c2+1;
        nod=sort(EL(i,[1 2 4]));
        addi(c2,:)=[i nod kk(kk>0) 3];
        % c=c+1;
        % ix(c)=kk(kk>0);iy(c)=kk(kk>0);iv(c)=1;
    elseif (nzk==1 || nzk==0)
        kk=sort(kk(kk>0));
        c=c+1;
        ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;
    else
        error('2 yuzey');
    end

    %yuzey3  13 14 34
    k1=EL(i,6);
    k2=EL(i,7);
    k3=EL(i,10);

    kk=[k1 k2 k3];
    nzk=nnz(kk<0);

    if(nzk==3)
        % yuzeybd(i,2)=max(kk);
        yuzeybd(i,2)=mode(kk);
    elseif(nzk==2)
        c2=c2+1;
        nod=sort(EL(i,[1 3 4]));
        addi(c2,:)=[i nod kk(kk>0) 2];
        % c=c+1;
        % ix(c)=kk(kk>0);iy(c)=kk(kk>0);iv(c)=1;
    elseif (nzk==1 || nzk==0)
        kk=sort(kk(kk>0));
        c=c+1;
        ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;
    else
        error('3 yuzey');
    end

    %yuzey4  23 42 34
    k1=EL(i,8);
    k2=EL(i,9);
    k3=EL(i,10);

    kk=[k1 k2 k3];
    nzk=nnz(kk<0);

    if(nzk==3)
        % yuzeybd(i,1)=max(kk);
        yuzeybd(i,1)=mode(kk);
    elseif(nzk==2)
        c2=c2+1;
        nod=sort(EL(i,[2 3 4]));
        addi(c2,:)=[i nod kk(kk>0) 1];
        % c=c+1;
        % ix(c)=kk(kk>0);iy(c)=kk(kk>0);iv(c)=1;
    elseif (nzk==1 || nzk==0)
        kk=sort(kk(kk>0));
        c=c+1;
        ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;
    else
        error('4 yuzey');
    end

end

Y1=sparse(ix,iy,iv,totkenar,totkenar);
[ix,iy,iv]=find(Y1);

iv=[1:length(iv)];
Y1=sparse(ix,iy,iv,totkenar,totkenar);
totyuzey1=length(iv);

if(c2>0)

ix=[];iy=[];iv=[];
addj=addi(:,1:4);
c=0;
for i=1:size(addi,1)
        al1=addj(i,2:4);
    for j=1:size(addi,1)

        if(i==j)
            continue;
        end

        al2=addj(j,2:4);

        bak=ismember(al1,al2);
        if(nnz(bak)==3)

        kk=sort([addi(i,1) addi(j,1)]);

        c=c+1;
        ix(c)=kk(1);iy(c)=kk(2);iv(c)=1;
        end

    end
end

Y2=sparse(ix,iy,iv,totkenar,totkenar);
[ix,iy,iv]=find(Y2);
totyuzey2=length(iv);
iv=[1:length(iv)];
Y2=sparse(ix,iy,iv,totkenar,totkenar);

for i=1:size(addi,1)
        al1=addj(i,2:4);
    for j=i:size(addi,1)

        if(i==j)
            continue;
        end

        al2=addj(j,2:4);

        bak=ismember(al1,al2);
        if(nnz(bak)==3)

         ii1=addi(i,1);
         ii2=addi(j,1);

         [ii,ind]=sort([ii1 ii2]);
         ii1=ii(1);
         ii2=ii(2);

         jj=[i j];
         jj=jj(ind);

         jj1=addi(jj(1),6);
         jj2=addi(jj(2),6);
        %Yüzeybd hem eksili hem de artılı elemanlara sahip
        yuzeybd(ii1,jj1)=full(Y2(ii1,ii2))+totyuzey1;
        yuzeybd(ii2,jj2)=full(Y2(ii1,ii2))+totyuzey1;

        end

    end
end

totyuzey=totyuzey1+totyuzey2;

else
totyuzey=totyuzey1;

end

nz1=nnz(yuzeybd<0);

fprintf("\n %d yuzey sınırda ve %d yuzey içerde\n", nz1,totyuzey);

yuzeybd2=yuzeybd;
% ii=find(yuzeybd2~=0);

% ko=1:length(ii);
% ko=ko+totyuzey;
% yuzeybd2(ii)=ko;

EL=[EL zeros(size(EL,1),4)];

for ii=1:size(EL,1)

nler=eleman(1:4,ii);

kler=zeros(1,6);

cc=0;
for i=1:3
    for j=i+1:4
        cc=cc+1;
        kler(cc)=full(K2(nler(i),nler(j)));
    end
end

kler2=zeros(1,4);
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
        kler2(i)=full(Y1(al(1),al(2)));
        % kler2(i+4)=kler2(i)+totyuzey;
    elseif(nnz(al)==1)
        kler2(i)=yuzeybd(ii,sw);
        % kler2(i+4)=kler2(i)+totyuzey;
        if(kler2(i)==0)
        error('0 index');
        end
    else
        kler2(i)=yuzeybd(ii,sw);
        % kler2(i+4)=kler2(i);
        if(kler2(i)==0)
        error('0 index');
        end
    end
end

EL(ii,16:19)=kler2;

end

end
