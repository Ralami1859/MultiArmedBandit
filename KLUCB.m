function [GlobalRegret,S,N]= KLUCB(BernoulliMeans, Horizon, NbrIteration, variant)
    GlobalRegret = [];
    figure
    for iter = 1:NbrIteration
        display(iter)
        K = length(BernoulliMeans);
        S = zeros(1,K);
        N = zeros(1,K);
        U_ucb = zeros(1,K);
        RegretKLUCB = [];
        for k = 1:K
            x = rand() < BernoulliMeans(k);
            N(k) = N(k) + 1;
            S(k) = S(k) + (x == 1);
        end
        for t = K+1:Horizon;
%             for k = 1:K;
%                 %[U_ucb(k), val] = fminbnd(@(x) KLUCBFunction(x,S(k),N(k),t,Horizon),S(k)./N(k),1);
%                 %[U_ucb(k), val] = fminsearch(@(x) KLUCBFunction(x,S(k),N(k),t,Horizon),S(k)./N(k));
%                 U_ucb(k) = SearchingKLUCBIndex(S(k),N(k),t,Horizon);
%             end
            %U_ucb
            U_ucb = SearchingKLUCBIndex(S,N,t,Horizon, variant);
            [~, BestArm] = max(U_ucb);
            x = rand() < BernoulliMeans(BestArm);
            N(BestArm) = N(BestArm) + 1;
            S(BestArm) = S(BestArm) + (x == 1);
            RegretKLUCB = [RegretKLUCB max(BernoulliMeans)-BernoulliMeans(BestArm)];
        end
        plot(RegretKLUCB)
        hold on 
        GlobalRegret = [GlobalRegret;cumsum(RegretKLUCB)];
    end
        figure
        plot(mean(GlobalRegret,1),'k.');
        title('KL UCB')
end