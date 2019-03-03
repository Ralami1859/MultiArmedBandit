function [ArmToPlay, Theta] = GlobalS_UCB_Tuned_BA_RecommendArm(Proba, Sucess, Sucess2, NbrPlayArm)
    
   Time = [1:length(Proba)];
    Theta = [];
    
    for k = 1:size(Sucess,2)
        m =  Sucess(:,k)./NbrPlayArm(:,k);
        V = Sucess2(:,k)./NbrPlayArm(:,k) - m.^2 + sqrt(2*log(Time)'./NbrPlayArm(:,k)); % Note: this
                                                                              % correction
                                                                              % makes sense
                                                                              % for rewards
                                                                              % in [0,1]
                    %ucb = m + sqrt(log(self.t)./self.N.*min(1/4, V)) % This one could also be used
        Theta =[Theta  Proba*(m + sqrt(log(Time)'./NbrPlayArm(:,k).*V(:,k)))];
    end
    [~, ArmToPlay] = max(Theta);
    
end