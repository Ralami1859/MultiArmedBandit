function GlobalRegret = Exp3S(BernoulliMeansMatrix, VectHorizon, gamma, NbrIteration)

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

    Horizon = sum(VectHorizon);
    alpha = 1/Horizon;
    GlobalRegret = [];
    
    for iter  = 1:NbrIteration;
        tic
        display(iter)
       
        w = ones(1,K);
        
        regret = [];

        for n = 1:NbrPeriode
            
            t = 0;
            BernoulliMeansMatrix1 = BernoulliMeansMatrix(n,:);
            BestMean = max(BernoulliMeansMatrix1);
            while t < VectHorizon(n);

                p = (1-gamma)*w/sum(w) + gamma/K;
                Proba = cumsum(p);
                action = Proba > rand();
                action = find(action == 1,1,'first');
                regret = [regret BestMean(1)- BernoulliMeansMatrix1(action)];
                x = zeros(1,K);
                x(action) = rand() < BernoulliMeansMatrix1(action);
                x(action) = x(action)/p(action);
                w = w.*exp(gamma.*x/K) + exp(1)*alpha/K*sum(w);
                w = w/sum(w);
                t = t+1;
            end
        end
        regret = cumsum(regret);
        GlobalRegret = [GlobalRegret; regret];
        toc
    end
    figure;
    plot(mean(GlobalRegret,1));
    title('Exp3S')
     xlabel('time')
    ylabel('regret')
    %save(['GlobalRegretEXP3S_gamma',num2str(gamma),'_Horizon',num2str(Horizon),'.mat'],'GlobalRegret');
end