clear; close all; clc;
format shortG;
load './pg_movies.mat'

% len = 212;
% fields = { 'Action'
%            'Animation'
%            'Comedy'
%            'Drama'
%            'Documentary'
%            'Romance'
%            'Short'
% };

% mat = compare_genres([pg_movies.Action, pg_movies.Animation, pg_movies.Comedy, pg_movies.Drama, pg_movies.Documentary, pg_movies.Romance, pg_movies.Short]);
mat = compare_genres([pg_movies.Action, pg_movies.Drama, pg_movies.Romance]);
% spy(mat)

[vecs, vals] = eig(mat);
[val, idx]   = max(max(vals));    % extract largest Eigenvalue from matrix (flatten, find max)

fprintf('max Eigenvalue: %f.\n', val);

vec          = vecs(:, idx);       % extract largest Eigenvector
[~,   idxs]   = sort(vec);         % sort the Eigenvector to get indexes sorted (we care about the last one)
idxs          = idxs((end-2):end); % pull out the last three indexes

% fprintf('best movie at position %d.\n', idx);
for i = idxs
  fprintf('%s.\n', pg_movies.title{i});
end
