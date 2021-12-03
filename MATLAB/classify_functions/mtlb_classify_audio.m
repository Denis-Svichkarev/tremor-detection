function [label, p1, p2, p3] = mtlb_classify_audio(X)
    A = load('MODEL_AUD_MOV_STA').model;
    B = load('MODEL_AUD_TRE_MOV').model;
    
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