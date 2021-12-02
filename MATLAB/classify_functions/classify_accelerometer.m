function [label, p1, p2, p3] = classify_accelerometer(X)
	A = loadLearnerForCoder('SVM_MODEL_ACC_MOV_STA');
	B = loadLearnerForCoder('SVM_MODEL_ACC_TRE_MOV');

    A.ScoreTransform = 'logit';
    B.ScoreTransform = 'logit';
    
    [act_label, act_p] = predict(A, X);
    [tre_label, tre_p] = predict(B, X);
        
    if act_p(1,1) > 0.5
        label = tre_label;
        p1 = act_p(1,1) * tre_p(1,1);
        p2 = act_p(1,1) * tre_p(1,2);
        p3 = act_p(1,2);
        
    else
        label = act_label;
        p1 = tre_p(1,1) * act_p(1,1);
        p2 = tre_p(1,2) * act_p(1,1);
        p3 = act_p(1,2);
    end
end