function [PL] = sui(bs_height, ue_height, cat, f, dist, technology)


switch technology
    case 'nbiot'
        corr_fact = -0.5;
    case 'sigfox'
        corr_fact = 4.8;
    case 'lorawan'
        corr_fact = -10.0;
    otherwise
        disp('Unknown technology');
        PL = -1;
        return
end 


switch cat
    case 'A'
        a = 4.6;
        b = 0.0075;
        c = 12.6;
    case 'B'
        a = 4;
        b = 0.0065;
        c = 17.1;
    case 'C'
        a = 3.6;
        b = 0.005;
        c = 20;
    otherwise
        a = 4;
        b = 0.0065;
        c = 17.1;
end

if (ue_height <= 3)
    Lbh = -10 * log10(ue_height / 3);
else
    Lbh = -20 * log10(ue_height / 3);
end

Lbf = 6 * log10(f / 2000);

f = f * 1e6;
c_speed = 299792458;
lambda = c_speed / f;
d0 = 100;
gamma = a - b * bs_height + c / bs_height;

d0E = d0 * 10 ^(-((Lbf + Lbh) / (10 * gamma)));

A = 20 * log10((4 * pi * d0E) / lambda);

dist = dist * 1000;

if dist <= d0E
        PL = 20 * log10((4 * pi * dist) / lambda);
    else
        PL = A + 10 * gamma * log10(dist / d0) + Lbf + Lbh;
end

PL = PL + corr_fact;


