function [varargout] = SmoothVars(method,varargin)
    % Smooths all data in varargin using one of the methods
    % Available methods are: 'movmean','movmedian','gaussian','lowess','loess','rlowess',
    % 'rloess','sgolay'
    

    % Note that varargout must equal varargin and be the same order!
    nin = nargin; 
    nout = nargout;
    if nin-1~= nout
       fprintf('Number of inputs unequal number of outputs');
       return 
    end
    for n = 1:nin-1
        FN = fieldnames(varargin{n});
        num = numel(FN);
        for j = 2:num
            try
                varargout{n}.(FN{j}) = smoothdata(varargin{n}.(FN{j}),method);
            catch
                varargout{n}.(FN{j}) = [];
            end
        end 
    end
end