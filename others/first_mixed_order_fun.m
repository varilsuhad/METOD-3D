% ========================================================================
% Author: Deniz Varılsüha
% Affiliation: Istanbul Technical University (ITU)
% Contact: deniz.varilsuha@itu.edu.tr
% Journal: Computers & Geosciences
% Manuscript metadata: Included for journal submission compliance
% Last updated: 2026-04-08
% ========================================================================
function [R1,M1,sag] = first_mixed_order_fun(eleman,node,EL)

xa1= [ 0.2500000000000000, 0.5000000000000000, 0.1666666666666667, 0.1666666666666667, 0.1666666666666667];
ya1= [ 0.2500000000000000, 0.1666666666666667, 0.1666666666666667, 0.1666666666666667, 0.5000000000000000];
za1= [ 0.2500000000000000, 0.1666666666666667, 0.1666666666666667, 0.5000000000000000, 0.1666666666666667];
wt1= [-0.8000000000000000, 0.4500000000000000, 0.4500000000000000, 0.4500000000000000, 0.4500000000000000]/6;

eleman=eleman';
node=node';

ep=10^-5;

lis=[1 2;1 3; 1 4 ; 2 3; 2 4 ;3 4]; %this is the edge-node list
lis2=[3 2 4 ; 3 1 4; 2 1 4; 2 1 3];

d=zeros(4,1);
c=d;b=d;a=d;
M=ones(4,4);

Clar=zeros(4,4,3);
Dlar=zeros(4,4);
CDlar=zeros(4,4,4,4);

al=EL(:,5:10);
totkenar=max(al(:));

al=EL(:,12:15);
al=al(al>0);
totnode=max(al)-totkenar;

sag=zeros(totkenar,2);

ix1=[];iy1=[];iv1a=[];iv1b=[];sayac1=0; %curl + F

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
%%% M edge1*edge1
for i=1:6
    for j=1:6

    i1=lis(i,1);
    i2=lis(i,2);

    j1=lis(j,1);
    j2=lis(j,2);

        sum1=0;
       for jj=1:length(xa)

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
%%% M edge1*node1
for i=1:6
    i1=lis(i,1);
    i2=lis(i,2);

    for j=1:4
    j1=j;

        sum1=0;
       for jj=1:length(xa)

        p1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,2);
        p2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(i1,xa(jj),ya(jj),za(jj),Jxyz,1);
        L2=evaluate_shape_function(i2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek1=L1*p2-L2*p1;

        p1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,2);
        % p2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,2);
        L1=evaluate_shape_function(j1,xa(jj),ya(jj),za(jj),Jxyz,1);
        % L2=evaluate_shape_function(j2,xa(jj),ya(jj),za(jj),Jxyz,1);

        sek2=p1;

        sum1=sum1+dot(sek1,sek2)*wt(jj)*det1;
       end
        B1(i,j)=sum1;
    end
end

F1=sigma*F1; %we will add i*w and mu later; keep it real for now
FF=[F1];
RR=rot1;

% cc=0;
% for i=1:3
%     for j=i+1:4
%         cc=cc+1;
%         kler(cc)=full(edge_no(nler(i),nler(j)));
%     end
% end

kler=EL(ii,5:10);

% kler2=zeros(1,8);
% for i=1:4
%     if(i==1)
%         al=kler([4 5 6]);
%         sw=1;
%     elseif(i==2)
%         al=kler([2 3 6]);
%         sw=2;
%     elseif(i==3)
%         al=kler([1 3 5]);
%         sw=3;
%     elseif(i==4)
%         al=kler([1 2 4]);
%         sw=4;
%     end
%
%     al(al<0)=0;
%
%     if(nnz(al)>1)
%         al=sort(al(al>0));
%         kler2(i)=full(yuzey_no(al(1),al(2)));
%         kler2(i+4)=kler2(i)+totyuzey;
%     elseif(nnz(al)==1)
%         kler2(i)=yuzeybd(ii,sw);
%         kler2(i+4)=kler2(i)+totyuzey;
%         if(kler2(i)==0)
%         error('0 index');
%         end
%     else
%         kler2(i)=yuzeybd(ii,sw);
%         kler2(i+4)=kler2(i);
%         if(kler2(i)==0)
%         error('0 index');
%         end
%     end
% end

% kler2=EL(ii,16:19);
% kler2(5:8)=EL(ii,16:19);

kler3=EL(ii,12:15)-totkenar;

klerv2=kler;

% klerv2=zeros(1,6);  %all non-phi terms
% for i=1:6
%     if(kler(i)>0)
%     % klerv2(i+6)=kler(i)+totkenar;
%     else
%     klerv2(i)=kler(i);
%     % klerv2(i+6)=kler(i);
%     end
% end

iszerov2=length(find(klerv2<0));  %all non-phi terms

if(iszerov2==0)

    rr=repmat(klerv2',[1 6]); %row indices
    cc=rr'; %column indices;

    ix1(sayac1+1:sayac1+36)=rr(:);
    iy1(sayac1+1:sayac1+36)=cc(:);
    iv1a(sayac1+1:sayac1+36)=RR(:);
    iv1b(sayac1+1:sayac1+36)=FF(:);
    sayac1=sayac1+36;
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

        sag_local=zeros(6,2);

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

            sag_local(nke,1)=sag_local(nke,1)-rot1(nke,ke(i))*val;
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

            sag_local(nke,2)=sag_local(nke,2)-rot1(nke,ke(i))*val;

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

            % val=1;
            sag_local(nke,2)=sag_local(nke,2)-rot1(nke,ke(i))*val;
            val=al(2);
            % val=al(1);
            % val=1;

            sag_local(nke,1)=sag_local(nke,1)-rot1(nke,ke(i))*val;

            else
            error('must be between 1 and 6');

            end
        end

            sag(kler(nke),:)=sag(kler(nke),:)+sag_local(nke,:);
            % sag(kler2(nke2)+totkenar*2,:)=sag(kler2(nke2)+totkenar*2,:)+sag_local2(nke2,:);
            end

end

R1=sparse(ix1,iy1,iv1a,totkenar,totkenar); % double curl
M1=sparse(ix1,iy1,iv1b,totkenar,totkenar); %

R1=spmdReduce(@plus,R1,1);
M1=spmdReduce(@plus,M1,1);

sag=spmdReduce(@plus,sag,1);
end

R1=R1{1};
M1=M1{1};

sag=sag{1};

end
