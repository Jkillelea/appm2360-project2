clear; close all; clc;
format shortG;
load './pg_movies.mat'

% fields = {'Action' 'Animation' 'Comedy' 'Drama' 'Documentary' 'Romance' 'Short'}
% >> summary(pg_movies)
%
%     year: 212x1 double
%         Values:
%             min       1938 <- earliest movie
%             median    2001 <- median movie date
%             max       2005 <- latest
%
%     length: 212x1 double
%         Values:
%             min         7 <- shortest
%             median     97 <- median length
%             max       208 <- longest
%
%     budget: 212x1 double
%         Values:
%             min       1.25e+05 <- smallest budget
%             median     2.6e+07 <- median budget
%             max        1.4e+08 <- largest budget
%

sample_matrix = [ 1     1     0     1     1; ...
                  1     1     0     0     0; ...
                  0     0     1     1     1; ...
                  1     0     1     1     1; ...
                  1     0     1     1     1; ...
];
% YES - Any film matrix we set up is symmetric
% det(sample_matrix) = 0 -> therefore the matrix is not invertible
[sample_vecs, sample_vals] = eig(sample_matrix);
sample_vals                = sum(sample_vals); % flatten from diagonal to vector
[sample_eigenvalue, idx]   = max(abs(sample_vals));
sample_eigenvector         = sample_vecs(:, idx);
[~, idx] = sort(sample_eigenvector);
fprintf('Best movie from sample matrix is number %d.\n\n', idx(end));

% compare all the movies
mat = compare_genres([pg_movies.Action, pg_movies.Animation, pg_movies.Comedy, pg_movies.Drama, pg_movies.Documentary, pg_movies.Romance, pg_movies.Short]);
[vecs, vals]  = eig(mat);
[maxval, idx] = max(max(abs(vals))); % extract largest Eigenvalue from matrix (flatten, find max)
maxvec        = vecs(:, idx);        % extract largest Eigenvector
[~,   idxs]   = sort(maxvec);        % sort the Eigenvector to get indexes sorted (we care about the last one)
idxs          = idxs((end-2):end);   % pull out the last three indexes

fprintf('\nFull matrix - max Eigenvalue: %f.\n', maxval);
fprintf('Best three:\n');
for i = idxs % print out each movie
  fprintf('\t%s.\n', pg_movies.title{i});
end
fprintf('\n');

% compare the Action, Drama, and Romance movies
mat = compare_genres([pg_movies.Action, pg_movies.Drama, pg_movies.Romance]);

[vecs, vals]  = eig(mat);
[maxval, idx] = max(max(abs(vals))); % extract largest Eigenvalue from matrix (flatten, find max)
maxvec        = vecs(:, idx);        % extract largest Eigenvector
[~,   idxs]   = sort(maxvec);        % sort the Eigenvector to get indexes sorted (we care about the last one)
idxs          = idxs((end-2):end);   % pull out the last three indexes

fprintf('\nAction/Drama/Romance matrix - max Eigenvalue: %f.\n', maxval);
fprintf('Best three:\n');
for i = idxs % print out each movie
  fprintf('\t%s.\n', pg_movies.title{i});
end
