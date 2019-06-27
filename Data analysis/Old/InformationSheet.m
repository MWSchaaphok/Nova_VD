%% Function for data information sheet %% 
function [answer] = InformationSheet()
    prompt = {'Date','Track'};
    dlgtitle = 'Input Data Information Sheet';
    opts.Resize = 'on';
    opts.Interpreter = 'Tex';
    dims = [1 35];
    definput = {date,''};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
end 