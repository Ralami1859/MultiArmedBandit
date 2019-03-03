function [GlobalRegret, Sucess, NbrPlayArm]= MOSS(BernoulliMeans, Horizon, NbrIteration)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Sucess = [];
        RegretMOSS = [];
        NbrPlayArm = [];
        for t = 1:K
            reward = rand() < BernoulliMeans(t);
            Sucess = [Sucess reward];
            NbrPlayArm = [NbrPlayArm 1];
            RegretMOSS = [RegretMOSS max(BernoulliMeans)- BernoulliMeans(t)];
        end
        for t = K+1:Horizon
            
            ucb =  Sucess./NbrPlayArm + sqrt(log(max(Horizon./(length(NbrPlayArm)*NbrPlayArm)))./NbrPlayArm);
            m = max(ucb); I = find(ucb == m);
            BestArm = I(1+floor(length(I)*rand));
            reward = rand()<BernoulliMeans(BestArm);
            Sucess(BestArm) = Sucess(BestArm) + (reward);
         
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            RegretMOSS = [RegretMOSS max(BernoulliMeans)- BernoulliMeans(BestArm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretMOSS)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('MOSS')
end