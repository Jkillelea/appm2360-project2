close all; clear; clc;

% load data
% fields = 'Action' 'Animation' 'Comedy' 'Drama' 'Documentary' 'Romance' 'Short'
load './pg_movies.mat'


results = struct(...
  'Action',      struct(), ...
  'Animation',   struct(), ...
  'Comedy',      struct(), ...
  'Drama',       struct(), ...
  'Documentary', struct(), ...
  'Romance',     struct(), ...
  'Short',       struct()  ...
);

% do the comparisons
fields = fieldnames(results);
for i = 1:numel(fields)
  comparisons = compare_movies(pg_movies.(fields{i}));

% get Eigenvectors and Eigenvalues
  [vecs, vals] = eig(comparisons);
  vals         = sum(vals);    % values are only on the diagonals and everything else is zero so we can flatten it with a column sum
  [val, idx]   = max(vals);    % extract largest Eigenvalue
  vec          = vecs(:, idx); % extract largest Eigenvector
  [~,   idx]   = sort(vec);    % sort the Eigenvector to get indexes sorted (we care about the last one)
  idx          = idx(end);     % pull out the index relating to the largest value

  % store again. Keep track of the original matrix, the Eigenvalue
  results.(fields{i}) = struct( ...
    'mat', comparisons, ...
    'vec', vec,                     ...
    'val', val,                     ...
    'best', pg_movies.title(idx),   ...
    'best_idx', idx                 ...
  );
end

% print them out to console and file
fileID = fopen('output.txt', 'w');
for i = 1:numel(fields)
  fprintf(        'Best %11s movie: %s.\n', fields{i}, results.(fields{i}).best);
  fprintf(fileID, 'Best %11s movie: %s.\n', fields{i}, results.(fields{i}).best);
end

fclose(fileID);
