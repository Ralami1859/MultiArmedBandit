% Sliding Window UCB
% tau : taille de la fenêtre
%ksi, B paramètres UCB

function GlobalRegret = SW_UCB(BernoulliMeansMatrix, VectHorizon, tau , ksi, B, NbrIteration)
    
    if nargin == 3
        ksi = 0.6;
        B = 0.6;
        NbrIteration = 100;
    end
    if nargin == 4;
        B = 0.6;
        NbrIteration = 100;
    end
    if nargin == 5;
        NbrIteration = 100;
    end
    
    [NbrPeriode, K] = size(BernoulliMeansMatrix);
    if(NbrPeriode ~= length(VectHorizon))
        error('Nbr colonnes de la matrice des moyennes ne correpond pas ')
    end
    
    GlobalRegret = [];
    
    for iter = 1:NbrIteration;
        tic
        display(iter)
        tau = floor(tau);
        t = 1;
        X = [];
        ArmPlayed = [];
        regret = [];
        for k = 1:K;
            X = [X rand() < BernoulliMeansMatrix(1,k)];
            ArmPlayed = [ArmPlayed k];
            t = t + 1;
        end
        for n = 1:NbrPeriode
            t0 = 0;
            while(t0 < VectHorizon(n))
                BernoulliMeansMatrix1 = BernoulliMeansMatrix(n,:);
                BestMean = max(BernoulliMeansMatrix1);
                X_t = [];
                N_t = [];
                for k = 1:K;
                    vectInstant = (t-tau+1)*(t-tau+1 >= 1) + 1*(t-tau+1 < 1) : t-1;
                    vect_k = ArmPlayed(vectInstant) == k;
                    N_t = [N_t sum(vect_k)];
                    X_t = [X_t sum(X(vectInstant(vect_k)))];
                end
                [~, k_max] = max(X_t./N_t + B.*sqrt(ksi.*log(min(t,tau))./N_t));
                X = [X rand() < BernoulliMeansMatrix1(k_max)];
                ArmPlayed = [ArmPlayed k_max];
                regret = [regret BestMean - BernoulliMeansMatrix1(k_max)];
                t = t + 1;
                t0 = t0 + 1;
            end
        end
        regret = cumsum(regret);
        GlobalRegret = [GlobalRegret; regret];
        toc
    end
        figure;
        plot(mean(GlobalRegret,1));
        xlabel('Time');ylabel('Regret');
        title('SW UCB');
        %save(['GlobalRegretSWUCB_Tau=',num2str(tau),'.mat'],'GlobalRegret');
end
            
            