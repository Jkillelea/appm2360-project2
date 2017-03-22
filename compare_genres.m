function mat_out = compare_genres(mat_in)
  len     = size(mat_in, 1);
  width   = size(mat_in, 2);
  mat_out = eye(len); % match every one with itself by default

  for k = 1:width % each col
    col = mat_in(:, k);
    for i = 1:len % check each movie (if in genre and then to each other)
      for j = 1:len
        if col(i) == 1 && col(j) == 1
          mat_out(i, j) = 1;
        end
      end
    end
  end

end
