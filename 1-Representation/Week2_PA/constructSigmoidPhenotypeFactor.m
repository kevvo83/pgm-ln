function phenotypeFactor = constructSigmoidPhenotypeFactor(alleleWeights, geneCopyVarOneList, geneCopyVarTwoList, phenotypeVar)
% This function takes a cell array of alleles' weights and constructs a 
% factor expressing a sigmoid CPD.
%
% You can assume that there are only 2 genes involved in the CPD.
%
% In the factor, for each gene, each allele assignment maps to the allele
% whose weight is at the corresponding location.  For example, for gene 1,
% allele assignment 1 maps to the allele whose weight is at
% alleleWeights{1}(1) (same as w_1^1), allele assignment 2 maps to the
% allele whose weight is at alleleWeights{1}(2) (same as w_2^1),....  
% 
% You may assume that there are 2 possible phenotypes.
% For the phenotypes, assignment 1 maps to having the physical trait, and
% assignment 2 maps to not having the physical trait.
%
% THE VARIABLE TO THE LEFT OF THE CONDITIONING BAR MUST BE THE FIRST
% VARIABLE IN THE .var FIELD FOR GRADING PURPOSES
%
% Input:
%   alleleWeights: Cell array of weights, where each entry is an 1 x n 
%   of weights for the alleles for a gene (n is the number of alleles for
%   the gene)
%   geneCopyVarOneList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the first parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor)
%   geneCopyVarTwoList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the second parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor) -- Note that both copies of each gene are from the same person,
%   but each copy originally came from a different parent
%   phenotypeVar: Variable number corresponding to the variable for the 
%   phenotype (goes in the .var part of the factor)
%
% Output:
%   phenotypeFactor: Factor in which the values are the probabilities of 
%   having each phenotype for each allele combination (note that this is 
%   the FULL CPD with no evidence observed)

phenotypeFactor = struct('var', [], 'card', [], 'val', []);

numAlleles = length(alleleWeights{1});
numGenes = length(alleleWeights);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INSERT YOUR CODE HERE
% Note that computeSigmoid.m will be useful for this function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% Fill in phenotypeFactor.var.  This should be a 1-D row vector.
phenotypeFactor.var = [phenotypeVar geneCopyVarOneList' geneCopyVarTwoList'];

% Fill in phenotypeFactor.card.  This should be a 1-D row vector.
phenotypeFactor.card = [2 numAlleles numAlleles numAlleles numAlleles];

assignments = IndexToAssignment(1:prod(phenotypeFactor.card), phenotypeFactor.card);

phenotypeFactor.val = zeros(1, prod(phenotypeFactor.card));
% Replace the zeros in phentoypeFactor.val with the correct values.
for x = 1:length(assignments)
  phenotype = assignments(x, 1);
  gene_allele_combos = assignments(x, 2:columns(assignments));
  
  f = 0;
  
  copies1_or_alleles1 = gene_allele_combos(1:numAlleles); % instances of g1c1, g2c1 from Parent 1
  copies2_or_alleles2 = gene_allele_combos(1+numAlleles:end); % instances of g1c2, g2c2 from Parent 2
  
  % Reference/inspiration for this for loop - https://github.com/KWMalik/pgm-class/blob/master/PGM_Programming_Assignment_2/constructSigmoidPhenotypeFactor.m
  for j=1:numGenes
    f = f + alleleWeights{j}(copies1_or_alleles1(j)) + alleleWeights{j}(copies2_or_alleles2(j));
  endfor
  
  f = computeSigmoid(f);
  
  if phenotype == 1
    phenotypeFactor.val(x) = f;
  else
    phenotypeFactor.val(x) = 1 - f;
  endif
  
endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%