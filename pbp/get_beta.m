function [Beta]=get_beta(A,p,y,c)
n=length(y); s=length(p); q=1-p;
Beta=zeros(s,n);
Beta(:,end) = ones(s,1);

for k=n-1:-1:1,
    p_t = y(k+1)*p + (1-y(k+1))*q;
    Beta(:,k) = A*( Beta(:,k+1).*p_t );
    Beta(:,k) = Beta(:,k)/c(k+1);
end