
function GlobalRegret = Exp3(BernoulliMeansMatrix, VectHorizon, gamma, NbrIteration)

    if nargin == 3
        NbrIteration = 100;
    end
    if nargin == 2;
        gamma = 0.05;
        NbrIteration = 100;
    end
    
    [NbrPeriode, K] = size(BernoulliMeansMatrix);
    if(NbrPeriode ~= length(VectHorizon))
        error('Nbr colonnes de la matrice des moyennes ne correpond pas ')
    end

    GlobalRegret = [];
    
    for iter = 1:NbrIteration;
        display(iter);
        w = ones(1,K);
        regret = [];
        tic
            
        for n = 1:NbrPeriode    
            t = 0;
            BernoulliMeansMatrix1 = BernoulliMeansMatrix(n,:);
            while t < VectHorizon(n);
                 
                BestMean = max(BernoulliMeansMatrix1);
                p = (1-gamma)*w/sum(w) + gamma/K;
                Proba = cumsum(p);
                action = Proba > rand();
                action = find(action == 1,1,'first');
                regret = [regret BestMean- BernoulliMeansMatrix1(action)];
                x = rand() < BernoulliMeansMatrix1(action);
                x = x/p(action);
                w(action) = w(action)*exp(gamma*x/K);
                 w = w/sum(w);
                t = t+1;
            end
        end
        toc
        regret = cumsum(regret);
        GlobalRegret = [GlobalRegret; regret];
    end
    figure
    plot(mean(GlobalRegret,1));
    title('Exp3')
     xlabel('time')
    ylabel('regret')
    %save(['GlobalRegretEXP3_gamma',num2str(gamma),'.mat'],'GlobalRegret');
    
end