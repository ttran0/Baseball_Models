% Y = csvread('chain.csv',1,1);
% y = Y(1,:);
% p_it = [1/3;1/3;3/7];
% q_it = 1-p_it;
% pi_it = [1/4;2/4;1/4];
% A_it = [1/3, 1/5, 7/15 ;1/7,1/7,5/7;6/10,3/10,1/10];
% 
% 
% n= length(y);
% beta = zeros(3,n);
% alpha = zeros(3,n);
% xi = zeros(3,3);
% A=zeros(3,3);
% p=zeros(3,1);
% gamma = zeros(3,n);
% p_it_old = zeros(3,1);
% 
% beta(:,end) = ones(3,1);
% alpha(:,1) = pi_it .* (y(1)*p_it + (1-y(1))*q_it);
% c = sum(alpha(:,1));
% alpha(:,1) = alpha(:,1)/c;
% 
% tol = 1e-10;
% iter=1;
% 
% %While (norm(p_it-pi_it_old)>tol)    
%     p_it_old = p_it
%             
%     for k=1:length(y)-1
%        
%         alpha(:,k+1) = (A_it'*alpha(:,k)) .* (p_it*y(k)+q_it*(1-y(k)));
%         
%         c = sum(alpha(:,k+1));
%         
%         alpha(:,k+1) = alpha(:,k+1)/c;
%         
%         beta(:,n-k) = A_it*(beta(:,n-k+1).*(y(k+1)*p_it + (1-y(k+1))*q_it));
%         
%         beta(:,n-k) = beta(:,n-k)/c;
%         
%         gamma (:,k) = alpha(:,k) .* beta(:,n-k);
%         
%         for i=1:3
%             for j=1:3
%                 xi(i,j) = alpha(i,k)*(y(k)*p_it(j) + (1-y(k))*q_it(j)) * A_it(i,j) * beta(j,n-k) ;
%             end
%         end
%         
%         A_k = bsxfun(@rdivide,xi,sum(xi,2)); %Matrix A at state K
%         
%         A = A+A_k;
%         
%         p_k = [gamma(1,k)*y(k);gamma(2,k)*y(k);gamma(3,k)*y(k)];
%         
%         p = p+p_k;
%         
%         pi_it = gamma(:,k);
%     end
%   
%     iter=iter+1
% %     A_it = A;
% %     p_it = p;
% % end  
% 
% 
% 
% 
Y = csvread('chain.csv',1,1);
s=3;
y=Y(1,:);
y=reshape(y,[1,length(y)]);
A = [1/3, 1/5, 7/15 ;1/7,1/7,5/7;6/10,3/10,1/10];
pie = [1/4;2/4;1/4];
p = [1/3;1/3;3/7];
xi = zeros(s,s,n);
log_likelihood_old = -inf;
flag = 0;
while (flag == 0),
    [Alpha,c] = get_alpha(A,pie,p,y);
    Beta = get_beta(A,p,y,c);
    log_likelihood = sum(log(c));
    
    double(log_likelihood - log_likelihood_old > 0 )
    
    gamma = alpha .* beta;
    q = 1-p;
    for k=2:n,
        w = Alpha(:,k-1)*c(k); 
        v = ( y(k)*p + (1-y(k))*q ).*Beta(:,k);
        xi(:,:,k) = ( w*v' ).*A;
    end;
    pie = gamma(:,1)/sum(gamma(:,1));
    A = sum(xi,3);
    A = bsxfun(@rdivide,A,sum(A,2));
    p = sum( bsxfun(@times,gamma,y) , 2 );
    p = p./( sum(gamma,2) );
    
    if (abs(log_likelihood_old-log_likelihood) < 1e-8)
        flag = 1;
    else
        log_likelihood_old = log_likelihood;
    end
end