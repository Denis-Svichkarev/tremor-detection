function [label, p1, p2, p3] = mtlb_classify_accelerometer(X)
    act_mot_model = load('Mtlb_SVM_Acc_ACT_MOT_Model').model;
    tre_mov_model = load('Mtlb_SVM_Acc_TRE_MOV_Model').model;
    
    [act_label, act_p] = predict(act_mot_model, X);
    [tre_label, tre_p] = predict(tre_mov_model, X);
        
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