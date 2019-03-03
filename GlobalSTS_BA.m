function [GlobalRegretMatrix]= GlobalSTS_BA(BernoulliMeansMatrix, VectHorizon, N, NbrIteration)

Horizon = sum(VectHorizon);
   if nargin == 3
        NbrIteration = 40;
    end
    if nargin == 2;
        N = min(1000,Horizon);
        NbrIteration = 40;
    end
    
    [NbrPeriode, K] = size(BernoulliMeansMatrix);
    if(NbrPeriode ~= length(VectHorizon))
        error('Nbr colonnes de la matrice des moyennes ne correpond pas ')
    end

GlobalRegretMatrix = [];
NbrChangement = length(VectHorizon); 
gamma = NbrChangement/Horizon;
GlobalRegret = zeros(1,Horizon);

for iter = 1:NbrIteration;
    tic
    %display(iter)
    regret = [];
    Proba = [1];
    t = 0;
    alpha0 = 1; beta0 = 1;
    alphas = [alpha0*ones(1,K)]; % NbrLigne = NbrProba; NbrCol = NbrBras;
    betas = [beta0*ones(1,K)]; % NbrLigne = NbrProba; NbrCol = NbrBras;

   display(iter);
   
   for n = 1:NbrPeriode
       t = 0;
       BernoulliMeansMatrix1 = BernoulliMeansMatrix(n,:);
       BestMean = max(BernoulliMeansMatrix1);
       while(t < VectHorizon(n))
     %display(t)
            [action] = selectActionAllRunlengths(Proba, alphas, betas);
            regret = [regret BestMean-BernoulliMeansMatrix1(action)];
            reward = rand() < BernoulliMeansMatrix1(action);
            [Proba ] = updateChangeModel(Proba,alphas,betas,action,reward,gamma);
            [alphas, betas] = updateArmModel(alphas, betas, action, reward, alpha0, beta0);
            if(length(Proba) > N)
                [Proba, alphas, betas] = Resampling(Proba, alphas, betas);
            end  
            t = t+1;
        end
   end
    regret = cumsum(regret);
    %GlobalRegret = GlobalRegret + regret;
    GlobalRegretMatrix = [GlobalRegretMatrix;regret];
    toc
end
figure
plot(mean(GlobalRegretMatrix,1))
xlabel('Time')
ylabel('Cumulative Regret')
title('Global STS Bayesian Aggregation')