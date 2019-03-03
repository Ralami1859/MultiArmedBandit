function [GlobalRegret] = BayesUCB(BernoulliMeans, Horizon, NbrIteration)
    GlobalRegret = [];
    for iter = 1:NbrIteration;
        display(iter)
        K = length(BernoulliMeans);
        alphas = ones(1,K);
        betas = ones(1,K);
        RegretBayesUCB = [];
        for t = 1:Horizon
            q = betainv(1 - 1./(t.*log(Horizon)), alphas, betas);
            [~, BestArm] = max(q);
            x = rand() < BernoulliMeans(BestArm);
            RegretBayesUCB = [RegretBayesUCB max(BernoulliMeans) - BernoulliMeans(BestArm)];
            if(x == 1)
                alphas(BestArm) = alphas(BestArm) + 1;
            else
                betas(BestArm) = betas(BestArm) + 1;
            end
        end
        GlobalRegret = [GlobalRegret; cumsum(RegretBayesUCB)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('Bayes UCB')
end