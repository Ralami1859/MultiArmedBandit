% Algorithme Thompson Sampling en environnement stationnaire
% BernoulliMeansMatrix = NbrPeriode * NbrAction

function GlobalRegretTS = ThompsonSampling(BernoulliMeansMatrix, VectHorizon, alpha0, beta0, NbrIteration)

if nargin == 4
    NbrIteration = 100;
end
if nargin == 3
    NbrIteration = 100;
    beta0 = 1;
end
if nargin == 2
    NbrIteration = 100;
    beta0 = 1;
    alpha0 = 1;
end

if(alpha0 <= 0)
    error('Alpha0 doit être strictement positif')
end
if(beta0 <= 0)
    error('Beta0 doit être strictement positif')
end
    
[NbrPeriode, K] = size(BernoulliMeansMatrix);
if(NbrPeriode ~= length(VectHorizon))
    error('Nbr colonnes de la matrice des moyennes ne correpond pas ')
end

GlobalRegretTS = [];
figure


for iter = 1:NbrIteration;
    display(iter)
    regret = [];
    alphas = alpha0*ones(1,K);
    betas = beta0*ones(1,K);
    for n = 1:NbrPeriode;
        t = 1;
        bernoulliMeans = BernoulliMeansMatrix(n,:);
        while(t <= VectHorizon(n))    
            theta = [];
            BestMean = max(bernoulliMeans);
            for i = 1:length(bernoulliMeans);
                theta = [theta betarnd(alphas(i),betas(i))];
            end
            [~, action] = max(theta);
            reward = rand() < bernoulliMeans(action);
            regret = [regret BestMean-bernoulliMeans(action)];
            if(reward == 1)
                alphas(action) = alphas(action) + 1;
            else
                betas(action) = betas(action) + 1;
            end
           t = t+1;
        end
    end
    regret = cumsum(regret);
    GlobalRegretTS = [GlobalRegretTS; regret];
end
plot(mean(GlobalRegretTS,1),'k.')
xlabel('Time')
ylabel('Global Regret')
title('Thompson Sampling')
end