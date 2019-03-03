function GlobalRegret = Exp3R(BernoulliMeansMatrix, VectHorizon, H, delta, gamma,  NbrIteration)
    
    if nargin == 3
        NbrIteration = 100;
        delta = 0.05;
        gamma = 0.05;
    end
    if nargin == 4;
        gamma = 0.05;
        NbrIteration = 100;
    end
    if nargin == 5;
        NbrIteration = 100;
    end
    
    [NbrPeriode, K] = size(BernoulliMeansMatrix);
    if(NbrPeriode ~= length(VectHorizon))
        error('Nbr colonnes de la matrice des moyennes ne correpond pas ')
    end
    
    Horizon = sum(VectHorizon);
    %alpha = 1/sum(VectHorizon);
    GlobalRegret = [];

    figure;
   
    for iter = 1:NbrIteration;
        tic
        display(iter);
        %fenetre = Horizon/NbrChangement;
        J = zeros(1,2);
        J(1) = 1;
        t = 1;
        w = ones(1,K);
        N = [];
        regret = [];
        X = [];

        %Parametrage par défaut selon Robin et Raphael
        %delta = sqrt(log(Horizon)/(K*Horizon));
        %gamma = sqrt(K*log(K)*log(Horizon)/Horizon);
        %H = sqrt(Horizon*log(Horizon));

        for n1 = 1:NbrPeriode
            BernoulliMeansMatrix1 = BernoulliMeansMatrix(n1,:);
            BestMean = max(BernoulliMeansMatrix1);
            t0 = 1;
            while t0 <= VectHorizon(n1)
                %% Running Exp3 on time t
                p = (1-gamma)*w/sum(w) + gamma/K;
                Proba = cumsum(p);
                action = Proba > rand();
                action = find(action == 1,1,'first');
                regret = [regret BestMean-BernoulliMeansMatrix1(action)];
                x = rand() < BernoulliMeansMatrix1(action);
                y = zeros(1,K);
                n = zeros(1,K);
                n(action) = 1;
                y(action) = x;
                X = [X; y];
                N = [N; n];
                x = x/p(action);
                w(action) = w(action)*exp(gamma*x/K);
                w = w/sum(w);
                %% Drift detection

                J(2) = t;
                if min(sum(N(J(1):J(2),:))) >= gamma*H/K;
                    if(DriftDetection(p, delta, H, gamma, J, X, N))
                        w = ones(1,K);
                    end
                    J(1) = t;
                end
                t = t + 1;
                t0 = t0 + 1;
            end
        end
        regret = cumsum(regret);
        GlobalRegret = [GlobalRegret; regret];
        toc
    end

    plot(mean(GlobalRegret,1))
    title('Exp3R')
     xlabel('time')
    ylabel('regret')
    
end
                
        
        