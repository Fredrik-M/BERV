% Returns the velocity at the given position on the given route, computed
% by linear interpolation between the two closest data points.

function s = velocity(d, route)

dData = load(route, 'distance_km').distance_km;
sData = load(route, 'speed_kmph').speed_kmph;

i_1 = findPos(dData, d);
i_0 = i_1 - 1;

x = [dData(i_0) dData(i_1)];
y = [sData(i_0) sData(i_1)];

c = myLinInterpol(x, y);

s = [1, d] * c';