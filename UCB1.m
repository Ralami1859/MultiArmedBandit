function [GlobalRegret, Success, NbrPlayArm]= UCB1(BernoulliMeans, Horizon, NbrIteration)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Success = [];
        RegretUCB = [];
        NbrPlayArm = [];
        for t = 1:K
            Success = [Success (rand()< BernoulliMeans(t))];
            NbrPlayArm = [NbrPlayArm 1];
            RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(t)];
        end

        for t = K+1:Horizon
            [~, BestArm] = max(Success./NbrPlayArm + sqrt(2*log(t)./NbrPlayArm));
            Success(BestArm) = Success(BestArm) + (rand()<BernoulliMeans(BestArm));
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(BestArm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretUCB)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('UCB 1')
end