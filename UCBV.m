function [GlobalRegret, Sucess, NbrPlayArm]= UCBV(BernoulliMeans, Horizon, NbrIteration)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Sucess = [];
        Sucess2 = [];
        RegretUCBV = [];
        NbrPlayArm = [];
        for t = 1:K
            reward = rand() < BernoulliMeans(t);
            Sucess = [Sucess reward];
            Sucess2 = [Sucess2 reward.^2];
            NbrPlayArm = [NbrPlayArm 1];
            RegretUCBV = [RegretUCBV max(BernoulliMeans)- BernoulliMeans(t)];
        end

        for t = K+1:Horizon
            m =  Sucess./NbrPlayArm;
            V = Sucess2./NbrPlayArm - m.^2;
            ucb = m + sqrt(2*log(t).*V./NbrPlayArm) + 3*log(t)./NbrPlayArm;
            maxMean = max(ucb);
            I = find(ucb == maxMean);
            BestArm = I(1+floor(length(I)*rand));
            reward = rand()<BernoulliMeans(BestArm);
            Sucess(BestArm) = Sucess(BestArm) + (reward);
            Sucess2(BestArm) = Sucess2(BestArm) + (reward).^2;
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            RegretUCBV = [RegretUCBV max(BernoulliMeans)- BernoulliMeans(BestArm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretUCBV)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('UCB V')
end