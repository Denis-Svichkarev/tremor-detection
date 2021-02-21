function [label, p] = mtlb_classify_action(X)
    model = load('Mtlb_SVM_Acc_ACT_MOT_Model').model;
    [label, p] = predict(model, X);
end