function res = compare_movies(movies_vec)
  len = length(movies_vec);
  res = eye(len);

  for i = 1:len % row
    if movies_vec(i, 1) == 1
      for j = 1:len % column
        if movies_vec(j, 1) == 1
          res(i, j) = 1;
        end
      end
    end
  end

  return % res
end
