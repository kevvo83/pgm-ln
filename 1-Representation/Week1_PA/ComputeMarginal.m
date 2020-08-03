%ComputeMarginal Computes the marginal over a set of given variables
%   M = ComputeMarginal(V, F, E) computes the marginal over variables V
%   in the distribution induced by the set of factors F, given evidence E
%
%   M is a factor containing the marginal over variables V
%   V is a vector containing the variables in the marginal e.g. [1 2 3] for
%     X_1, X_2 and X_3.
%   F is a vector of factors (struct array) containing the factors 
%     defining the distribution
%   E is an N-by-2 matrix, each row being a variable/value pair. 
%     Variables are in the first column and values are in the second column.
%     If there is no evidence, pass in the empty matrix [] for E.


function M = ComputeMarginal(V, F, E)

% Check for empty factor list
if (numel(F) == 0)
      warning('Warning: empty factor list');
      M = struct('var', [], 'card', [], 'val', []);      
      return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE:
% M should be a factor
% Remember to renormalize the entries of M!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the inverse of the .var array - on which to sum-up over
%   The V input parameter to the FactorMarginalization() function is the
%   list of variables to sum over.
%   Whereas the V input paramater to ComputeMarginal() is the variables in the
%   marginal - so the variables to be summed over are the inverse of that.
var_to_be_summed_over = [];
for x = 1:length(F)
  var_to_be_summed_over = union(F(x).var, var_to_be_summed_over);
endfor

% variable from FACTORS.INPUT(i).var to be summed over to compute marginal
var_to_be_summed_over = setdiff(var_to_be_summed_over, V);

M = struct('var', [], 'card', [], 'val', []); % Returns empty factor. Change this.

M = ObserveEvidence(F, E);
M = ComputeJointDistribution(M);
M = FactorMarginalization(M, var_to_be_summed_over);

M.val = M.val / sum(M.val);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
