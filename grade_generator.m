% set path
path = 'grading/';
addpath(genpath(path))

% grab file names
fileNames = dir([path, '*.xlsx']); 

% determine number of files (including uploading document)
nFiles = numel(fileNames);
firstLast = 2; % number of columns for names

% initialize fields and values for structure
files = struct;

% extract data from spreadsheets
largestFileName = 0; 
for i = 1:nFiles
    
    % read xls file
    [num, str] = xlsread(fileNames(i).name);
    
    % separate first and last name for CogLab
    if size(str, 2) == 1
        temp = cell(size(str, 1), 2);
        for n = 1:size(str, 1)
            split = strsplit(str{n}, ', ');
            temp{n, 1} = split{1}; 
            temp{n, 2} = split{2}; 
        end
        str = temp; 
    end
    
    % remove potential duplicates from LC
    if size(str, 2) == 2
        [~, i1, i2] = unique(strcat(str(:,1),str(:,2)));
        temp = zeros(max(i2), 1); 

        for s = 1:max(i2)
            temp(s) = max(num(i2 == s)); 
        end
        str = str(i1, :);
        num = temp; 
    end
    
    % create dynamic field name and assign values to structure
    field = ['f', num2str(i)];
    files.(field).name = fileNames(i).name;
    files.(field).students = str;
    files.(field).score = num;
    
    % update largest file name
    largestFileName = max(largestFileName, length(fileNames(i).name)); 

end

% create master name list
master_names = [];
for i = 1:nFiles
    field = ['f', num2str(i)];
    if length(files.(field).name) == largestFileName
        master_names = files.(field).students(2:end, 1:2); 
    end
end

% create comparision matrix
out = struct;           % initialize output structure
n1 = 'Vacca-Capecci';   % exception name in master_names
n2 = 'Capecci-Moore';   % exception name in LC / BB
for f = 1:nFiles
    field = ['f', num2str(f)];
    if length(files.(field).name) ~= largestFileName
        comp_matrix = []; 
        for i = 1:size(master_names, 1)
            for j = 1:size(files.(field).students, 1)
                comp_matrix(i, j) = (strncmpi(master_names{i, 1}, files.(field).students{j, 1}, 3) && ...
                    strncmpi(master_names{i, 2}, files.(field).students{j, 2}, 3));
                % catch exception 
                if (strcmp(master_names{i, 1}, n2) && ...
                    strcmp(files.(field).students{j, 1}, n1))
                    comp_matrix(i, j) = 1; 
                end
            end
        end
        out.(field).name = files.(field).name;
        out.(field).scores = comp_matrix * files.(field).score; 
        out.(field).misses = files.(field).students{logical(abs(sum(comp_matrix, 1) - 1))};
        out.(field).Nmisses = sum(abs(sum(comp_matrix, 1) - 1)); 
    end
end

% save outputs to csv files
outpath = 'graded/';
for i = 1:length(fieldnames(out))
    field = ['f', num2str(i)];
    csvwrite(fullfile(outpath, [out.(field).name, '_out']), out.(field).scores); 
end

