function res = DriftDetection(p, delta, H, gamma, I, X, N)
    % I contient deux valeurs 
    % X : NbrLigne t : NbrColonne : Bras
    [~, BestAction] = max(p);
    K = length(p);
    epsilon = sqrt(K*log(1/delta)/(2*gamma*H));
    mu_kmax = sum(X(I(1):I(2),BestAction));
    n_kmax = sum(N(I(1):I(2),BestAction));
    mu = sum(X(I(1):I(2),:));
    n = sum(N(I(1):I(2),:));
    res = ~isempty(find(mu./n - mu_kmax./n_kmax >= 2*epsilon == 1, 1));
end