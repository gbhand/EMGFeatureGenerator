function chunks = chunkify(datasets, windows, fs)

chunk_size = windows * fs;
Nsets = length(datasets);
cell_chunks = cell(Nsets,1);

% Assume datasets is a cell array
for i = 1:Nsets
    d_raw = datasets{i};
    len = length(d_raw);
    
    num_chunks = floor(len / chunk_size);
    new_size = num_chunks * chunk_size;
    
    d = d_raw(1:new_size);
    cell_chunks{i} = reshape(d, chunk_size, num_chunks);
    
end

chunks = [cell_chunks{:}];





end