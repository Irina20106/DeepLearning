function [arr] = rand_example(size_arr)

base = 1:1:size_arr;
arr = zeros(1,size_arr);
dynamic_size = size_arr;
for i=1:1:size_arr
    dynamic_size = size_arr - (i-1);
    j = randi(dynamic_size);
    arr(i) = base(j);
    t = base(j);
    base(j) = base(dynamic_size);
    base(dynamic_size) = t;
end


end