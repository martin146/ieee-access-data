function [PL] = urban_3gpp(bs_height_rooftop, f, dist, technology)

switch technology
    case 'nbiot'
        corr_fact = -8.4;
    case 'sigfox'
        corr_fact = -2.5;
    case 'lorawan'
        corr_fact = -17.0;
    otherwise
        disp('Unknown technology');
        PL = -1;
        return
end 


PL = 40*(1 - 4e-3 * bs_height_rooftop) * log10(dist) - 18 * log10(bs_height_rooftop) + 21 * log10(f) + 80 + corr_fact;

end

