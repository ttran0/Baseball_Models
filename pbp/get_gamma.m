function [Gamma,Xi] = get_gamma(Alpha,Beta,A,p,y,c)

Gamma = Alpha.*Beta;
[s,n] = size(Alpha);
q = 1-p;
Xi = zeros(s,s,n);

for k=2:n,
    p_t = y(k)*p + (1-y(k))*q;
    v = p_t.*Beta(:,k);
    M = Alpha(:,k-1)*( v' );
    Xi(:,:,k) = M.*A/c(k);
end;