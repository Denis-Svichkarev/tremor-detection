function [label, p] = mtlb_classify_tremor(X)
    model = load('Mtlb_SVM_Acc_TRE_MOV_Model').model;
    [label, p] = predict(model, X);
end