function GlobalRegret = RExp3(BernoulliMeansMatrix, VectHorizon, batchSize, gamma, NbrIteration)

    if nargin == 4
        NbrIteration = 100;
    end
    if nargin == 3;
        gamma = 0.05;
        NbrIteration = 100;
    end
    
    [NbrPeriode, K] = size(BernoulliMeansMatrix);
    if(NbrPeriode ~= length(VectHorizon))
        error('Nbr colonnes de la matrice des moyennes ne correpond pas ')
    end
    
    Horizon = sum(VectHorizon);    
    GlobalRegret = [];
    vectHorizonCumule = cumsum(VectHorizon);
    figure 
    for iter = 1:NbrIteration;
        display(iter);        
        regret = [];
        t = 0;
        tic
        j = 1;
        
        while j <= floor(Horizon/batchSize)+1;
            tau = (j-1)*batchSize;
            w = ones(1,K);


            for tt= tau+1:min(Horizon, tau+batchSize)

                ind = find(t<= vectHorizonCumule,1,'first');
                BernoulliMeans = BernoulliMeansMatrix(ind,:);
                BestMean = max(BernoulliMeans);
                t = t+1;
                p = (1-gamma)*w/sum(w) + gamma/K;
                Proba = cumsum(p);
                action = Proba > rand();
                action = find(action == 1,1,'first');
                regret = [regret BestMean- BernoulliMeans(action)];
                x = rand() < BernoulliMeans(action);
                x = x/p(action);
                w(action) = w(action)*exp(gamma*x/K);
                w = w/sum(w);
            end
            j = j +1;
            %t = t+1;
        end
        toc
        regret = cumsum(regret);
        GlobalRegret = [GlobalRegret; regret];
    end
     
    figure
    plot(mean(GlobalRegret,1));
    title('REXP3')
    xlabel('time')
    ylabel('Cumulative regret')
    %save(['GlobalRegretREXP3_gamma',num2str(gamma),' BatchSize',num2str(batchSize),'.mat'],'GlobalRegret');
end