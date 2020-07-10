function [PL] = cost231(bs_height, ue_height, f, dist, street_w, building_d, building_h, phi, technology)

d = dist;
fc = f;
W = street_w;
b = building_d;
hr = building_h;
hm = ue_height;
dhm = hr - hm;
hb = bs_height;
dhb = hb -hr;


switch technology
    case 'nbiot'
        corr_fact = -23.0;
    case 'sigfox'
        corr_fact = -17.0;
    case 'lorawan'
        corr_fact = -30.0;
    otherwise
        disp('Unknown technology');
        PL = -1;
        return
end        

if ((phi > 0) && (phi <= 35))
    L0 = -10 + 0.354 * phi;
elseif((phi > 35) && (phi <= 55))
    L0 = 2.5 + 0.075 * (phi - 35);
elseif((phi > 55) && (phi <= 90))
    L0 = 4 - 0.114 * (phi - 55);
end

Lf = 32.4 + 20 * log10(d) + 20 * log10(fc);

Lrts = -16.9 - 10 * log10(W) + 10 * log10(fc) + 20 * log(dhm) + L0;

if (hb > hr)
    Lbsh = -18 * log10(1 + dhb);
    kd = 18;
else
    Lbsh = 0;
    kd = 18 - 15 * (dhb / hr);
end

if (hb <= hr)
    ka = 54 - 0.8 * dhb;
else
    ka = 54;
end

kf = -4 + 0.7 * ((fc / 925) - 1);
Lms = Lbsh + ka + kd * log10(d) + kf * log10(fc) - 9 * log10(b);

if((Lrts + Lms) > 0)
    L50  = Lf + Lrts + Lms;
else
    L50 = Lf;
end

PL = L50 + corr_fact;
end
