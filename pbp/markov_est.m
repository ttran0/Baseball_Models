clc
clear all
% Y = csvread('chain.csv',1,1);
% y=Y(4000,:);
s=3;
% n=length(y);
% y=reshape(y,[1,length(y)]);

% pitchers = {'JustinVerlander';'FelixHernandez'};
pitchers = {'FelixHernandez'} ;
N=1;
game = zeros(N,6);
for I = 1:N
    
    for l = 1:length(pitchers)
        data = readtable(char(strcat(pitchers(l),'pbp_11.csv')),'ReadVariableNames',false);
        fip_data = readtable(char(strcat(pitchers(l),'fip_11.csv')),'ReadVariableNames',false);
        fip = str2double(table2array(fip_data(2:end,2)));
        [m n] = size(data);
        num_games = m-1;
        
        tran_mat = zeros(s,s,num_games);
        emis_prob = zeros(s,num_games);
        initial_prob = zeros(s,num_games);
        for k = 2:num_games+1
            k
            
            A = unifrnd(0,1,3);
            A = bsxfun(@rdivide,A,sum(A,2));
            pie = unifrnd(0,1,3,1);
            pie = pie/sum(pie);
            p = rand(3,1);
           
            log_likelihood_old = -inf;
            
            
            y = table2array(data(k,2:end-1));
            na_val = strcmp(y,'NA');
            index = find(na_val==0);
            dat = str2double(y(index));
            y = dat;
            flag = 0;
            iter=0;
            
            while (flag == 0),
                
                [Alpha,c] = get_alpha(A,pie,p,y);
                [Beta] = get_beta(A,p,y,c);
                [Gamma,Xi] = get_gamma(Alpha,Beta,A,p,y,c);
           
                LLcur = sum( log(c) );
                
                pie = Gamma(:,1)/sum( Gamma(:,1) );
                p = (Gamma*(y'))./( sum(Gamma,2) );
                
                A = sum(Xi,3);
                A = bsxfun(@rdivide,A,sum(A,2));
                
                iter = iter+1;
                if( abs(LLcur-log_likelihood_old) <1e-10 ),
                    flag = 1;
                end;
                
                log_likelihood_old = LLcur;
                
            end
            
            transition_mat(:,:,k-1) = A;
            emis_prob(:,k-1) = p;
            initial_prob(:,k-1) = pie;
        end
        pit = strcat(pitchers{l},'fip');
        eval([pit '= fip;']);
        pit = strcat(pitchers{l},'transition');
        eval([pit '= transition_mat;']);
        pit = strcat(pitchers{l},'emission');
        eval([pit '= emis_prob;']);
        pit = strcat(pitchers{l},'initial');
        eval([pit '= initial_prob;']);
    end
    
    [~,~,k] = size(FelixHernandeztransition);
    for i=1:k
        m(i) = max(diag(FelixHernandeztransition(:,:,i),0));
    end
    
    S = sort(m);
    ind = find(m >= S(end-5))
    
    game(I,:) = ind;
    % keyboard;

end
%     B(:,:,:,l) = transition_mat;
%     emission(:,:,l) = emis_prob;
%     initial(:,:,l) = initial_prob;
