function [GlobalRegret, Sucess, NbrPlayArm]= CPUCB(BernoulliMeans, Horizon, NbrIteration)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Sucess = [];
        RegretCPUCB = [];
        NbrPlayArm = [];
        for t = 1:K
            reward = rand() < BernoulliMeans(t);
            Sucess = [Sucess reward];
            NbrPlayArm = [NbrPlayArm 1];
            RegretCPUCB = [RegretCPUCB max(BernoulliMeans)- BernoulliMeans(t)];
        end
        c = 1.01;
        for t = K+1:Horizon
            
            [~, ic] = binofit(Sucess, NbrPlayArm, 1/(t.^c));
            ucb = ic(:,2);
            m = max(ucb); I = find(ucb == m);
            BestArm = I(1+floor(length(I)*rand));
            reward = rand()<BernoulliMeans(BestArm);
            Sucess(BestArm) = Sucess(BestArm) + (reward);
         
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            RegretCPUCB = [RegretCPUCB max(BernoulliMeans)- BernoulliMeans(BestArm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretCPUCB)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('CP UCB')
end