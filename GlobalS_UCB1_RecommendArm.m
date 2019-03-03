function [ArmToPlay, Theta] = GlobalS_UCB1_RecommendArm(Proba, Succeses, NbrPlayArm)
    
    Proba = cumsum(Proba);
    u = rand();
    a = Proba > u;
    a = find(a == 1);
    
    if(isempty(a))
        BestProba = 1;
    else
        BestProba = a(1);
    end
    Theta = Succeses(BestProba,:)./NbrPlayArm(BestProba,:) + sqrt(2*log(BestProba)./NbrPlayArm(BestProba,:));
    [~, ArmToPlay] = max(Theta);
    
end