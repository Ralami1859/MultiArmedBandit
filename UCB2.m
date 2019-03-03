function [GlobalRegret, Sucess, NbrPlayArm]= UCB2(BernoulliMeans, Horizon, alpha,  NbrIteration)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Sucess = [];
        Sucess2 = [];
        RegretUCB2 = [];
        NbrPlayArm = [];
        r = zeros(1,K);
        for t = 1:K
            reward = rand() < BernoulliMeans(t);
            Sucess = [Sucess reward];
            NbrPlayArm = [NbrPlayArm 1];
            RegretUCB2 = [RegretUCB2 max(BernoulliMeans)- BernoulliMeans(t)];
        end

        while( t<= Horizon)
            m =  Sucess./NbrPlayArm;
            tau = Tau(r,alpha);
            a = sqrt((1+alpha).*log(exp(1).*t./tau)./(2.*tau));
            ucb = m + a;
            [maxMean BestArm]= max(ucb);
            
            for i = 1:min(Tau(r(BestArm)+1,alpha) - Tau(r(BestArm),alpha));
                reward = rand()<BernoulliMeans(BestArm);
                Sucess(BestArm) = Sucess(BestArm) + (reward);
            
                NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
                RegretUCB2 = [RegretUCB2 max(BernoulliMeans)- BernoulliMeans(BestArm)];
                t = t+1;
            end
            r(BestArm) = r(BestArm) + 1;
        end
        RegretUCB2 = RegretUCB2(1:Horizon);
        GlobalRegret = [GlobalRegret;cumsum(RegretUCB2)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('UCB 2')
end