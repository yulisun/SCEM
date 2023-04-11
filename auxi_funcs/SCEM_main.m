function [p ,Cosup,Rel_diff] = SCEM_main(image_t1,image_t2,par)
%% KNN graph
[Cosup,~] = GMMSP_Cosegmentation(image_t1,image_t2,par.Ns);
[t1_feature,t2_feature] = MMfeatureExtraction(Cosup,image_t1,image_t2);
Ns = size(t1_feature,2);
Kmax =round(Ns.^0.5);
Kmin = round(Kmax/10);
[Kmat_x] = adaptiveKmat(t1_feature,Kmax, Kmin);
[Kmat_y] = adaptiveKmat(t2_feature,Kmax, Kmin);
Kmat_xy = [Kmat_x Kmat_y];
%% SCEM
[B] = Constructing_quadratic_matrix(t1_feature,t2_feature,Kmat_xy,par);
BTB = B+B';
p = (sum(B,2) + sum(B',2))/2;
p = p/max(p);
lambda = par.lambda* (1-p')*B*(1-p)/Ns;
v = 0;
for i = 1 : par.Niter
    p_old = p;
    p (p < 0) = 0;
    p (p > 1) = 1;
    Gradient = BTB * (p-ones(Ns,1)) + lambda * ones(Ns,1);
    v = par.beta*v + (1-par.beta)*Gradient;
    p = p - par.alpha*Gradient;
    Rel_diff(i) = norm(p - p_old)/(norm(p)+eps);
end
p = (p-min(p))/(max(p)-min(p));