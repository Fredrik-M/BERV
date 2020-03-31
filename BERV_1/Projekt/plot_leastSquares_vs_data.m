sData = load('roadster.mat', 'speed_kmph').speed_kmph;
cData = load('roadster.mat', 'consumption_Whpkm').consumption_Whpkm;

c = myOLS(sData, cData);
x = 1:0.1:sData(length(sData));
X = [1./x' ones(length(x), 1) x' x.^2'];

scatter(sData, cData, 'r');
hold on
plot(x, X * c, 'b--');