% p1 - tremor, p2 - movement, p3 - static
function [label, p1, p2, p3] = classify_audio(X)
	A = loadLearnerForCoder('SVM_MODEL_AUD_MOV_STA');
	B = loadLearnerForCoder('SVM_MODEL_AUD_TRE_MOV');
    C = loadLearnerForCoder('SVM_MODEL_AUD_TRE_STA');
    
    % Comment ScoreTransform lines for MATLAB Coder, keep for test function
    
    A.ScoreTransform = 'logit';
    B.ScoreTransform = 'logit';
    C.ScoreTransform = 'logit';
     
    [a_label, mov_sta_p] = predict(A, X);
    [b_label, tre_mov_p] = predict(B, X);
    [c_label, tre_sta_p] = predict(C, X);
        
    m1 = mov_sta_p(1, 1);
    s1 = mov_sta_p(1, 2);
    
    t1 = tre_mov_p(1, 1);
    m2 = tre_mov_p(1, 2);
    
    t2 = tre_sta_p(1, 1);
    s2 = tre_sta_p(1, 2);
    
    p1 = (t1 + t2) / 2;
    p2 = (m1 + m2) / 2;
    p3 = (s1 + s2) / 2;
    
    if p1 > p2
       if p1 > p3
           label = {'Tremor'};
       else
           label = {'Static'};
       end
    else
        if p2 > p3
            label = {'Movement'};
        else
            label = {'Static'};
        end
    end
end