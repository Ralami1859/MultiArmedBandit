function [GlobalRegret, Sucess, NbrPlayArm]= DMED(BernoulliMeans, Horizon, genuine, NbrIteration)
    %genuine = true;  % Variant: with this set to false, use a less aggressive list
                         % pruning criterion corresponding to the the version called
                         % DMED in [Garivier & Cappé, COLT 2011]; the default is the
                         % original proposal of [Honda & Takemura, COLT 2010] (called
                         % DMED+ in [Garivier & Cappé, COLT 2011])

    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Sucess = [];
        Sucess2 = [];
        RegretDMED = [];
        NbrPlayArm = [];
        L = (1:K);
        for t = 1:K
            reward = rand() < BernoulliMeans(t);
            Sucess = [Sucess reward];
            NbrPlayArm = [NbrPlayArm 1];
            RegretDMED = [RegretDMED max(BernoulliMeans)- BernoulliMeans(t)];
        end

        for t = K+1:Horizon
            if(length(L) > 0)
                BestArm = L(1);
                L = L(2:end);
            else
                [~,c] = max(Sucess./NbrPlayArm); % Current best empirical mean
                if (genuine)
                    L = find(NbrPlayArm.*DivKL(Sucess./NbrPlayArm, Sucess(c)/NbrPlayArm(c)) < ...
                      log(t./NbrPlayArm));
                else
                    L = find(NbrPlayArm.*DivKL(Sucess./NbrPlayArm, Sucess(c)/NbrPlayArm(c)) < ...
                      log(t));
                end
                BestArm = L(1);
                L = L(2:end);
            end
            reward = rand()<BernoulliMeans(BestArm);
            Sucess(BestArm) = Sucess(BestArm) + (reward);
            
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            RegretDMED = [RegretDMED max(BernoulliMeans)- BernoulliMeans(BestArm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretDMED)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('DMED')
end