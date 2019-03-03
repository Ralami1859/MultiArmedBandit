
function [ArmToPlay]= SWUCB_RecommendArm(X, K, ArmPlayed, tau, t, B , ksi)
    X_t = [];
    N_t = [];
    for k = 1:K;
        vectInstant = (t-tau+1)*(t-tau+1 >= 1) + 1*(t-tau+1 < 1) : t-1;
        vect_k = ArmPlayed(vectInstant) == k;
        N_t = [N_t sum(vect_k)];
        X_t = [X_t sum(X(vectInstant(vect_k)))];
    end
    [~, ArmToPlay] = max(X_t./N_t + B.*sqrt(ksi.*log(min(t,tau))./N_t));
end