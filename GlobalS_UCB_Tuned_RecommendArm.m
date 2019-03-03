function [ArmToPlay, Theta] = GlobalS_UCB_Tuned_RecommendArm(Proba, Sucess, Sucess2, NbrPlayArm)
    
    Proba = cumsum(Proba);
    u = rand();
    a = Proba > u;
    a = find(a == 1);
    
    if(isempty(a))
        BestProba = 1;
    else
        BestProba = a(1);
    end
    
    m =  Sucess(BestProba,:)./NbrPlayArm(BestProba,:);
    V = Sucess2(BestProba,:)./NbrPlayArm(BestProba,:) - m.^2 + sqrt(2*log(BestProba)./NbrPlayArm(BestProba,:)); % Note: this
                                                                          % correction
                                                                          % makes sense
                                                                          % for rewards
                                                                          % in [0,1]
                %ucb = m + sqrt(log(self.t)./self.N.*min(1/4, V)) % This one could also be used

    Theta = m + sqrt(log(BestProba)./NbrPlayArm(BestProba,:).*V(BestProba,:));
    
    [~, ArmToPlay] = max(Theta);
    
end