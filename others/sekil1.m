function [son] = sekil1(i1,a,b,c,J,ok)


if(ok==1)
    if(i1==1)
    son=1-a-b-c;
    elseif(i1==2)
    son=a;
    elseif(i1==3)
    son=b;
    elseif(i1==4)
    son=c;
    else
    error('asf');
    end
else
    if(i1==1)
    son=-J(:,1)-J(:,2)-J(:,3);
    elseif(i1==2)
    son=J(:,1);
    elseif(i1==3)
    son=J(:,2);
    elseif(i1==4)
    son=J(:,3);
    else
    error('asf');
    end
end




end