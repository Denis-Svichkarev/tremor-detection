%% LOSS function

load ionosphere
rng(1); % For reproducibility
% Train an SVM classifier. Specify a 15% holdout sample for testing, standardize the data, and specify that 'g' is the positive class.

CVSVMModel = fitcsvm(X,Y,'Holdout',0.15,'ClassNames',{'b','g'},...
    'Standardize',true);
CompactSVMModel = CVSVMModel.Trained{1}; % Extract the trained, compact classifier
testInds = test(CVSVMModel.Partition);   % Extract the test indices
XTest = X(testInds,:);
YTest = Y(testInds,:);

% The SVM classifier misclassifies approximately 8% of the test sample.
L = loss(CompactSVMModel,XTest,YTest)

%% ROC

load ionosphere

resp = strcmp(Y,'b'); % resp = 1, if Y = 'b', or 0 if Y = 'g' 
pred = X(:,3:34);

mdlSVM = fitcsvm(pred,resp,'Standardize',true);
mdlSVM = fitPosterior(mdlSVM);
[~,score_svm] = resubPredict(mdlSVM);
[Xsvm,Ysvm,Tsvm,AUCsvm] = perfcurve(resp,score_svm(:,mdlSVM.ClassNames),'true');

hold on
plot(Xsvm,Ysvm)

legend('Support Vector Machines')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves for SVM Classification')
hold off