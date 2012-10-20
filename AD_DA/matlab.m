
%% with offset


%data = [[0 0.012];[1 0.033];[2 0.05];[3 0.073];[4 0.089];[5 0.111];[6 0.128]];
%data = [[121 2.371];[122 2.386];[123 2.411];[124 2.427];[125 2.449];[126 2.466];[127 2.486];[128 2.507];[129 2.529];[130 2.544];[131 2.567];[132 2.583];[133 2.606];[134 2.622]];
data = [[250 4.883];[251 4.907];[252 4.922];[253 4.944];[254 4.961]];

vref=4.997;
dvref=vref/(2^8);

nmin=data(1,1)+1;nmax=data(size(data,1),1)+1;

xth=zeros(2*(nmax-nmin+2));
yth=zeros(2*(nmax-nmin+2));
x=zeros(2*(nmax-nmin+2));

xth(1)=(nmin-.5)*dvref;
yth(1)=nmin-1;
for i=nmin:nmax
    xth(2*(i+1-nmin))=i*dvref;
    yth(2*(i+1-nmin))=i-1;
    xth(2*(i+1-nmin)+1)=i*dvref;
    yth(2*(i+1-nmin)+1)=i;
end
xth(2*(i+1-nmin)+2)=(i+.5)*dvref;
yth(2*(i+1-nmin)+2)=i;


for i=1:(size(data,1))
    x(2*i)=data(i,2);
    x(2*i+1)=data(i,2);
end
x(1)=xth(1);
x(2*i+2)=xth(2*i+2);

plot(xth,yth,x,yth)


%% without offset


%data = [[0 0.012];[1 0.033];[2 0.05];[3 0.073];[4 0.089];[5 0.111];[6 0.128]];
%data = [[121 2.371];[122 2.386];[123 2.411];[124 2.427];[125 2.449];[126 2.466];[127 2.486];[128 2.507];[129 2.529];[130 2.544];[131 2.567];[132 2.583];[133 2.606];[134 2.622]];
data = [[250 4.883];[251 4.907];[252 4.922];[253 4.944];[254 4.961]];

vref=4.997;
dvref=vref/(2^8);

nmin=data(1,1)+1;nmax=data(size(data,1),1)+1;

xth=zeros(1,2*(nmax-nmin+2));
yth=zeros(1,2*(nmax-nmin+2));
x=zeros(1,2*(nmax-nmin+2));

xth(1)=(nmin-.5)*dvref;
yth(1)=nmin-1;
for i=nmin:nmax
    xth(2*(i+1-nmin))=i*dvref;
    yth(2*(i+1-nmin))=i-1;
    xth(2*(i+1-nmin)+1)=i*dvref;
    yth(2*(i+1-nmin)+1)=i;
end
xth(2*(i+1-nmin)+2)=(i+.5)*dvref;
yth(2*(i+1-nmin)+2)=i;


for i=1:(size(data,1))
    x(2*i)=data(i,2);
    x(2*i+1)=data(i,2);
end
x(1)=xth(1);
x(2*i+2)=xth(2*i+2);

size(x)
size(xth)
mean(x-xth)
plot(xth+mean(x-xth),yth,x,yth)


%%


%figure('Color',[1 1 1]);
set(0,'DefaultAxesColorOrder',[[0 0 1];[1 0 0];[0 1 0]],...
      'DefaultAxesLineStyleOrder','-')

  
  
data1 = [[0 0.012];[1 0.033];[2 0.05];[3 0.073];[4 0.089];[5 0.111];[6 0.128]];
data2 = [[121 2.371];[122 2.386];[123 2.411];[124 2.427];[125 2.449];[126 2.466];[127 2.486];[128 2.507];[129 2.529];[130 2.544];[131 2.567];[132 2.583];[133 2.606];[134 2.622]];
data3 = [[250 4.883];[251 4.907];[252 4.922];[253 4.944];[254 4.961]];

%data = [data1 data2 data3];
n=8;

par = @(x)(1-2*mod(x,2));                               % par(x) = 1 si x pair, -1 si x impair

thVi = @(x,data)( x(1) + (1+data(:,1)).*(x(2)-x(1))./2^n + x(3)*par(data(:,1)));   % x=[Vmin,Vmax,dV]

params = [0 4.997 0];


subplot(3,3,1,'Color',[1 1 1]);
data = data1;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data1');
subplot(3,3,2,'Color',[1 1 1]);
data = data2;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data2');
subplot(3,3,3,'Color',[1 1 1]);
data = data3;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data3');

data = [data1;data2;data3];
err2  = @(x)( sum((data(:,2)-thVi(x,data)).^2) );

[params,fval] = fminsearch(err2,params);
params

subplot(3,3,7,'Color',[1 1 1]);
data = data1;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data1 CORR');
subplot(3,3,8,'Color',[1 1 1]);
data = data2;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data2 CORR');
subplot(3,3,9,'Color',[1 1 1]);
data = data3;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data3 CORR');

data = [data1;data2;data3];
err2  = @(x)( sum((data(:,2)-thVi([x 0],data)).^2) );

[params,fval] = fminsearch(err2,[0 4.997]);
params = [params 0]

subplot(3,3,4,'Color',[1 1 1]);
data = data1;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data1 LIN CORR');
subplot(3,3,5,'Color',[1 1 1]);
data = data2;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data2 LIN CORR');
subplot(3,3,6,'Color',[1 1 1]);
data = data3;
stairs2(data(:,1), thVi(params,data), data(:,2));
title('data3 LIN CORR');

%%

data1 = [[0 0.012];[1 0.033];[2 0.05];[3 0.073];[4 0.089];[5 0.111];[6 0.128]];
data2 = [[121 2.371];[122 2.386];[123 2.411];[124 2.427];[125 2.449];[126 2.466];[127 2.486];[128 2.507];[129 2.529];[130 2.544];[131 2.567];[132 2.583];[133 2.606];[134 2.622]];
data3 = [[250 4.883];[251 4.907];[252 4.922];[253 4.944];[254 4.961]];
data = [data1;data2;data3];
n=8;

thVi = @(x,data)( x(1) + (1+data(:,1)).*(x(2)-x(1))./2^n + x(3)*par(1+data(:,1)));
thVi([0,4.997,0],data)
mean(data(:,2)-thVi([0,4.997,0],data))