function [Alpha,c] = get_alpha(A,pie,p,y)
s=length(p); n=length(y); q=1-p;
Alpha=zeros(s,n);
c=zeros(1,n);
Alpha(:,1) = pie.*(p*y(1)+(1-y(1))*q);
c(1)=sum(Alpha(:,1));
Alpha(:,1) = Alpha(:,1)/c(1);
for k=2:n,
    Alpha(:,k) = (A')*Alpha(:,k-1);
    Alpha(:,k) = Alpha(:,k).*( y(k)*p + (1-y(k))*q );
    c(k) = sum(Alpha(:,k));
    Alpha(:,k) = Alpha(:,k)/c(k);
end

