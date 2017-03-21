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

mat = compare_genres([pg_movies.Action, pg_movies.Drama, pg_movies.Romance]);
% spy(mat)

[vecs, vals] = eig(mat);
[val, idx]   = max(max(vals));    % extract largest Eigenvalue from matrix (flatten, find max)
vec          = vecs(:, idx);       % extract largest Eigenvector
[~,   idxs]   = sort(vec);         % sort the Eigenvector to get indexes sorted (we care about the last one)
idxs          = idxs((end-2):end); % pull out the last three indexes

% print out results to console and file
fid = fopen('output.txt', 'w');
for id = [1, fid]
  fprintf(id, 'max Eigenvalue: %f.\n', val);
  for i = idxs
    fprintf(id, '%s.\n', pg_movies.title{i});
  end
  fprintf(id, 'best: %s.\n', pg_movies.title{idxs(end)});
end
fclose(fid);
