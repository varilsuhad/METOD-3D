% ========================================================================
% Author: Deniz Varılsüha
% Affiliation: Istanbul Technical University (ITU)
% Contact: deniz.varilsuha@itu.edu.tr
% Journal: Computers & Geosciences
% Manuscript metadata: Included for journal submission compliance
% Last updated: 2026-04-08
% ========================================================================
function [EL,HPm1,HPm2,totkenarhp,totyuzeyhp] = hprefinementsubF(EL,eleman,node,recvelems,Knodes,hpl)

HPm1=zeros(length(recvelems),6);
HPm2=zeros(length(recvelems),4);

c=0;
for ii=1:length(recvelems)

el=recvelems(ii);
nds=EL(el,1:4);

c=c+1;
EL(el,20+hpl)=c;

nler=EL(el,12:15);

kler=EL(el,5:10);
kler2=EL(el,16:19);

bak=ismember(nds,Knodes);

if(nnz(bak)<=1)
HPm1(c,:)=kler;
HPm2(c,:)=kler2;

% c=c+1;
% EL(el,20)=c;

continue;
end

cc=0;
for i=1:3
    for j=i+1:4
        cc=cc+1;
        if(bak(i)==1 && bak(j)==1)

            %%%%%%%%%%%%%%%%%%%%GERI AÇ
        % if(kler(cc)>0)
        % kler(cc)=0;
        % end

        end
    end
end

if(nnz(bak)==3)

    if(bak(2)==1 && bak(3)==1 && bak(4)==1)
        if(kler2(1)>0)
        kler2(1)=0;
        end
        if(kler(4)>0)
        kler(4)=0;
        end
        if(kler(5)>0)
        kler(5)=0;
        end
        if(kler(6)>0)
        kler(6)=0;
        end
    elseif (bak(1)==1 && bak(3)==1 && bak(4)==1)
        if(kler2(2)>0)
        kler2(2)=0;
        end
        if(kler(2)>0)
        kler(2)=0;
        end
        if(kler(3)>0)
        kler(3)=0;
        end
        if(kler(6)>0)
        kler(6)=0;
        end
    elseif (bak(1)==1 && bak(2)==1 && bak(4)==1)
        if(kler2(3)>0)
        kler2(3)=0;
        end
        if(kler(1)>0)
        kler(1)=0;
        end
        if(kler(3)>0)
        kler(3)=0;
        end
        if(kler(5)>0)
        kler(5)=0;
        end
    elseif (bak(1)==1 && bak(2)==1 && bak(3)==1)
        if(kler2(4)>0)
        kler2(4)=0;
        end
        if(kler(1)>0)
        kler(1)=0;
        end
        if(kler(2)>0)
        kler(2)=0;
        end
        if(kler(4)>0)
        kler(4)=0;
        end
    else
    error('Olamaz yuzey');
    end

end

if(nnz(bak)==4 && nnz(nler>0)==4)
warning('Olamaz atıldı');
EL(el,20+hpl)=0;
c=c-1;
continue;
end

HPm1(c,:)=kler;
HPm2(c,:)=kler2;

end

ii=find(EL(:,20+hpl)>0);

Tsub = eleman(:,ii);
TRsub = triangulation(Tsub', node');
F = freeBoundary(TRsub);

figure;
patch('Faces',F,'Vertices',node','FaceColor','y','EdgeColor','k','FaceAlpha',1);
axis equal; camlight; lighting gouraud;

al1=unique(HPm1(:));
al1(find(al1==0))=[];

% if(al1(1)==0)
%     al1(1)=[];
% end

liste1=zeros(max(al1),1);
ii=find(al1>0);
al1a=al1(ii);

liste1(al1a)=1:length(al1a);
totkenarhp=length(al1a);

al1=unique(HPm2(:));
al1(find(al1==0))=[];

% if(al1(1)==0)
%     al1(1)=[];
% end

liste2=zeros(max(al1),1);
ii=find(al1>0);
al1a=al1(ii);

liste2(al1a)=1:length(al1a);
totyuzeyhp=length(al1a);

% return

for ii=1:c

    % el=recvelems(ii);
    al=HPm2(ii,:);

    if(nnz(al)==0)
        continue;
    end

    for i=1:4
        ko=al(i);

        if(ko>0)
            sakla=liste2(HPm2(ii,i));
        HPm2(ii,i)=sakla;

        if(sakla==0)
        error('Olamaz');
        end
        elseif(ko<0)
        HPm2(ii,i)=ko;
        end
    end

    al=HPm1(ii,:);

    for i=1:6
        ko=al(i);
        if(ko>0)
        HPm1(ii,i)=liste1(HPm1(ii,i));
        elseif(ko<0)
        HPm1(ii,i)=ko;
        end
    end

end

HPm1=HPm1(1:c,:);
HPm2=HPm2(1:c,:);

end
