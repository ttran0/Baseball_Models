clc
clear all



% Game 8 Justin Verlander 2011
% k = 9; % GAME 8
% A = [0.3020, 0.3095, 0.3885;0.9771, 0.0229, 0;0,0.1787, 0.8213];
% p = [1;0;0.3988];
% pie = [0;1;0];


%GAME 12 JUSTIN VERLANDER 20111
% k = 13; % GAME 12
% A = [0.9773,0.0227,0; 0, 0, 1 ; 0.1357, 0.7152, 0.1492];
% p = [0.4522;1;0];
% pie = [0;1;0];
% 
% 


% k=9; %GAME K-1


%DATA INPUT
pitchers = {'FelixHernandez'};
l=1;
data = readtable(char(strcat(pitchers(l),'pbp_11.csv')),'ReadVariableNames',false);
fip_data = readtable(char(strcat(pitchers(l),'fip_11.csv')),'ReadVariableNames',false);
fip = str2double(table2array(fip_data(2:end,2)));
[m n] = size(data);
num_games = m-1;
HS = nan(m-1,n-2);




% for k = 2:m
for k = 4:4
    k
    %SELECTING GAME K-1
    y = table2array(data(k,2:end-1));
    na_val = strcmp(y,'NA');
    index = find(na_val==0);
    y = str2double(y(index));
    N = length(y);

  
    %PARAMETER ESTIMATIONS
    A = unifrnd(0,1,3);
    A = bsxfun(@rdivide,A,sum(A,2));
    pie = unifrnd(0,1,3,1);
    pie = pie/sum(pie);
    p = rand(3,1);
%     A = [0.3020, 0.3095, 0.3885;0.9771, 0.0229, 0;0,0.1787, 0.8213];
%     p = [1;0;0.3988];
%     pie = [0;1;0];
%     %xi = zeros(s,s,n);
    log_likelihood_old = -inf;
    flag = 0;
    iter=0;
    
    while (flag == 0),
        
        [Alpha,c] = get_alpha(A,pie,p,y);
        [Beta] = get_beta(A,p,y,c);
        [Gamma,Xi] = get_gamma(Alpha,Beta,A,p,y,c);
        
        LLcur = sum( log(c) )
        
        pie = Gamma(:,1)/sum( Gamma(:,1) );
        p = (Gamma*(y'))./( sum(Gamma,2) );
        
        A = sum(Xi,3);
        A = bsxfun(@rdivide,A,sum(A,2));
        
        iter = iter+1
        if( abs(LLcur-log_likelihood_old) <1e-10 ),
            flag = 1;
        end;
        
        log_likelihood_old = LLcur;
        
    end
    
    
    
    
    %RECOVER STATES
    q=1-p;
    ind = zeros(3,N);
    g = zeros(3,N);
    g(:,1) = pie .* (y(1)*p+(1-y(1))*q);
    for j = 2:N
        %B = bsxfun(@times,A,g(:,j-1));
        Y = y(j)*p + (1-y(j))*q;
        B = ( g(:,j-1)*( Y' ) ).*A;
        [vv,ii] = max(B);
        g(:,j) = vv;
        ind(:,j) = ii;
        %[~,ind(:,j)]= max(B);
        %[g(:,j),~] = max(B);
    end
    
    states = zeros(N,1);
    [~,states(N)] = max(g(:,end));
    
    for j = N-1:-1:1
        states(j) = ind(states(j+1),j+1);
    end
    
    HS(k-1,1:length(states)) = states; 
    
end
    
%PITCHERS FIP (GAME-BY-GAME)
pit = strcat(pitchers{1},'fip');
eval([pit '= fip;']);
    
