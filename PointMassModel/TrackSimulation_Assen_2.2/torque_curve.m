function [Tm, rpm_m] = Check_Tm(v_w)
%% Check Tm available 
% Compute rpm of the motor at vehicle speed
v_mm   = 60*v_w;                  % Velocity of the wheel in meter/minute
rpm_rs = v_mm/d;                    % Rpm of the rear sprochet
rpm_m  = rpm_rs/gear_ratio;         % Rpm of motor

% Check powercurve for max T available

if (rpm_m>5500)
    display("Warning: Max rotational speed exceeded");
    Tm = 0;
elseif (rpm_m>4500)
    display("Warning: Peak rotational speed");
    Tm = 210 - 0.0388*(rpm_m-3200);
elseif (rpm_m>3200)
    Tm = 210 - 0.0388*(rpm_m-3200);
elseif (rpm_m>1732)
    Tm =400-0.12*(rpm_m-1732);
else
    Tm = 400;
end
end
