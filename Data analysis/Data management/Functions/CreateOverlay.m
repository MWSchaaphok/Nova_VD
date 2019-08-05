function [] = CreateOverlay(varx,var1y,varx2,var2y,xlab,ylab,handle)
% Function which creates overlay of two different datasets of the same
% variable
% Can work with 5 or 6 inputs depending on if you want to do it in a
% current figure or an old figure; 
    if nargin == 7
        inputname(1)
        plot(handle,varx,vary1,varx2,var2y);
        title(handle,['Comparison',ylab])
        xlabel(handle,xlab);
        ylabel(handle,ylab);
        legend(handle,'Dataset 1','Dataset 2')
    elseif nargin == 6
        figure;
        plot(varx,var1y,varx2,var2y);
        title(['Comparison ',ylab])
        xlabel(xlab);
        ylabel(ylab);
        legend('Dataset 1','Dataset 2')
    else 
        fprintf('Not the right number of input arguments')
   end
end 