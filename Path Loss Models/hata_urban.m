function [PL] = hata_urban(bs_height, ue_height, f, dist, technology)

switch technology
    case 'nbiot'
        corr_fact = -13.0;
    case 'sigfox'
        corr_fact = -5.0;
    case 'lorawan'
        corr_fact = -19.0;
    otherwise
        disp('Unknown technology');
        PL = -1;
        return
end   

a_h = 3.2 * (log10(11.75 * ue_height))^2 - 4.97;
PL = 69.55 + 26.16 * log10(f) - 13.82 * log10(bs_height) - a_h + (44.9 - 6.55 * log10(bs_height)) * log10(dist) + corr_fact;
end

