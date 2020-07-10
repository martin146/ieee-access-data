function [PL] = ericsson_urban(bs_height, ue_height, f, dist, technology)

switch technology
    case 'nbiot'
        corr_fact = -30.3;
    case 'sigfox'
        corr_fact = -21.0;
    case 'lorawan'
        corr_fact = -37.0;
    otherwise
        disp('Unknown technology');
        PL = -1;
        return
end 

a0 = 36.20;
a1 = 30.20;
a2 = 12;
a3 = 0.1;

g = 44.49 * log10(f) - 4.78 * (log10(f))^2;
PL = a0 + a1 * log10(dist) + a2 * log10(bs_height) + a3 * log10(bs_height) * log10(dist) - 3.2 * (log10(11.75 * ue_height))^2 + g + corr_fact;
end

