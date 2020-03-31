% Returns the velocity at the given position on the given route, computed
% by linear interpolation between the two closest data points.

function s = velocity(d, route)

dData = load(route, 'distance_km').distance_km;
sData = load(route, 'speed_kmph').speed_kmph;

s = zeros(1, length(d));

for i = 1:length(d)
    pos = findPos(dData, d(i));
    c = myLinInterpol([dData(pos - 1) dData(pos)], ...
                      [sData(pos - 1) sData(pos)])';
    
    s(i) = [1, d(i)] * c;
end
