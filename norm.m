function [norma] = norm(matrix)

matrix = matrix.^2;
summa = sum(sum(matrix,1));
norma = summa/(size(matrix,1)*size(matrix,2));

end