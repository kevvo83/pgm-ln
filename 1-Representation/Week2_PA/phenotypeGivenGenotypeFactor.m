function phenotypeFactor = phenotypeGivenGenotypeFactor(alphaList, genotypeVar, phenotypeVar)
% This function computes the probability of each phenotype given the 
% different genotypes for a trait. Genotypes (assignments to the genotype
% variable) are indexed from 1 to the number of genotypes, and the alphas
% are provided in the same order as the corresponding genotypes so that the
% alpha for genotype assignment i is alphaList(i).
%
% For the phenotypes, assignment 1 maps to having the physical trait, and 
% assignment 2 maps to not having the physical trait.
%
% THE VARIABLE TO THE LEFT OF THE CONDITIONING BAR MUST BE THE FIRST
% VARIABLE IN THE .var FIELD FOR GRADING PURPOSES
%
% Input:
%   alphaList: Vector of alpha values for each genotype (n x 1 vector,
%   where n is the number of genotypes) -- the alpha value for a genotype
%   is the probability that a person with that genotype will have the
%   physical trait 
%   genotypeVar: The variable number for the genotype variable (goes in the
%   .var part of the factor)
%   phenotypeVar: The variable number for the phenotype variable (goes in
%   the .var part of the factor)
%
% Output:
%   phenotypeFactor: Factor in which the val has the probability of having 
%   each phenotype for each genotype combination (note that this is the 
%   FULL CPD with no evidence observed)

phenotypeFactor = struct('var', [], 'card', [], 'val', []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%INSERT YOUR CODE HERE
% The number of genotypes is the length of alphaList.
% The number of phenotypes is 2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% Fill in phenotypeFactor.var.  This should be a 1-D row vector.
phenotypeFactor.var = [phenotypeVar, genotypeVar];
% Fill in phenotypeFactor.card.  This should be a 1-D row vector.
phenotypeFactor.card = [2 length(alphaList)];

% Initialize the var structure
phenotypeFactor.val = zeros(1, prod(phenotypeFactor.card));

% Replace the zeros in phentoypeFactor.val with the correct values.

% CPD looks like this for the non-Mendelian model
% --------------------------------------------------
%Genotype:       FF          Ff          ff
%Phenotype_Yes:  alpha1      alpha2      alpha3
%Phenotype_No:   (1-alpha1)  (1-alpha2)  (1-alpha3)
phenotype_yes_idx_for_assignment = [];
phenotype_no_idx_for_assignment = [];
for i = 1:size(alphaList)(1)
  % Get the indexes for the phenotype trait Yes
  phenotype_yes_idx_for_assignment = [phenotype_yes_idx_for_assignment; 1 i];
  % Get the indexes for the phenotype trait No
  phenotype_no_idx_for_assignment = [phenotype_no_idx_for_assignment; 2 i];
endfor

% Yes trait assignment to alpha_x
inds = AssignmentToIndex(phenotype_yes_idx_for_assignment, phenotypeFactor.card);
for idx = 1:size(inds)(1)
  phenotypeFactor.val(inds(idx)) = alphaList(idx);
endfor

% No trait assignment to 1 - alpha_x
inds = AssignmentToIndex(phenotype_no_idx_for_assignment, phenotypeFactor.card);
for idx = 1:size(inds)(1)
  phenotypeFactor.val(inds(idx)) = 1 - alphaList(idx);
endfor

#phenotypeFactor.val = [alphaList(1) (1-alphaList(1)) alphaList(2) (1-alphaList(2)) alphaList(3) (1-alphaList(3))];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%