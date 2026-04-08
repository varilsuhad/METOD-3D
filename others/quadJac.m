function [Jxyz,det1] = quadJac(XYZ,a,b,c,ekval,sgn)


x1=XYZ(:,1);
x2=XYZ(:,2);
x3=XYZ(:,3);
x4=XYZ(:,4);


x12=ekval(1,:)';
x13=ekval(2,:)';
x14=ekval(3,:)';
x23=ekval(4,:)';
x24=ekval(5,:)';
x34=ekval(6,:)';



L1=1-a-b-c;
L2=a;
L3=b;
L4=c;


da=(1-4*L1)*x1+(4*L2-1)*x2+(4*L1-4*L2)*x12-4*L3*x13-4*L4*x14+4*L3*x23+4*L4*x24;
db=(1-4*L1)*x1+(4*L3-1)*x3+(4*L1-4*L3)*x13-4*L2*x12-4*L4*x14+4*L2*x23+4*L4*x34;
dc=(1-4*L1)*x1+(4*L4-1)*x4+(4*L1-4*L4)*x14-4*L2*x12-4*L3*x13+4*L2*x24+4*L3*x34;


Jabc=[da' ; db' ; dc'];
det1=det(Jabc)*sgn;

Jxyz=inv(Jabc);

end