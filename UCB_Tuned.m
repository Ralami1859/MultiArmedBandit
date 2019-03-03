function [GlobalRegret, Sucess, NbrPlayArm]= UCB_Tuned(BernoulliMeans, Horizon, NbrIteration)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Sucess = [];
        Sucess2 = [];
        RegretUCBTuned = [];
        NbrPlayArm = [];
        for t = 1:K
            reward = rand() < BernoulliMeans(t);
            Sucess = [Sucess reward];
            Sucess2 = [Sucess2 reward.^2];
            NbrPlayArm = [NbrPlayArm 1];
            RegretUCBTuned = [RegretUCBTuned max(BernoulliMeans)- BernoulliMeans(t)];
        end

        for t = K+1:Horizon
            m =  Sucess./NbrPlayArm;
            V = Sucess2./NbrPlayArm - m.^2 + sqrt(2*log(t)./NbrPlayArm); % Note: this
                                                                          % correction
                                                                          % makes sense
                                                                          % for rewards
                                                                          % in [0,1]
                %ucb = m + sqrt(log(self.t)./self.N.*min(1/4, V)) % This one could also be used
            ucb = m + sqrt(log(t)./NbrPlayArm.*V);
            maxMean = max(ucb);
            I = find(ucb == maxMean);
            BestArm = I(1+floor(length(I)*rand));
            reward = rand()<BernoulliMeans(BestArm);
            Sucess(BestArm) = Sucess(BestArm) + (reward);
            Sucess2(BestArm) = Sucess2(BestArm) + (reward).^2;
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            RegretUCBTuned = [RegretUCBTuned max(BernoulliMeans)- BernoulliMeans(BestArm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretUCBTuned)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('UCB Tuned')
end