function [] = diskretisering()
% diskretisering
% Test av diskretiseringsfel vid numerisk beräkning av derivatan av
% funktionen f(x) = e^x på intervallet x = [0 2].
% f'(x) approximeras med framåtdifferens (f(x+h) - f(x))/h
% I programmet väljer användaren värdet på h och programmet visar
% den beräknade lösningen (röd markering) och exakt lösning (blå linje)


close all; % Stäng eventuella figurfönster
disp(' ----');
disp('Det här programmet åskådliggör begreppet diskretisering. När man');
disp('diskretiserar ersätter man något kontinuerligt med diskret, t ex')
disp('representerar en kontinuerlig funktion med värden i punkter. I det')
disp('här fallet beräknas derivatan f''(x) i ett antal punkter. Hur tät');
disp('indelningen blir bestäms av valet av deskretiseringsparametern h.')
disp(' ----');
disp(' ');
% Exakt lösning
l = 0;
u = 2;
antalPunkter = 400;
x = linspace(l,u,antalPunkter);
%func = @(x) exp(x);
%fprim = @(x) exp(x);   % Exakt derivata är e^x
func = @(x) exp(x);
fprim = @(x) exp(x);

% Se till att h inte blir för litet eller för stort
lagomStort = false;
while ~lagomStort
    h = OpenDialogBox();
    if isnan(h)
        disp('Hmm, du gav inget värde på h. Kör programmet igen!');
        return
    end
    mode = struct('Interpreter','latex','WindowStyle','modal');
    if (h < 1e-5)
        eh = errordlg('Ge h $\geq$ $10^{-5}$','h för litet',mode);
        waitfor(eh);
        lagomStort = false;
    elseif (h >= 1)
        eh = errordlg('Ge h $\leq$ 1','h för stort', mode);
        waitfor(eh);
        lagomStort = false;
    else
        lagomStort = true;
    end
end
xh = l:h:u;

% Numerisk derivata m h a funktionen ForwardDiff
fprimF = ForwardDiff(func, xh, h);
fprimExakt = fprim(xh);

% Relativa felet mellan exakt och numerisk l?sning (i 2-norm)
felF = norm(fprimExakt - fprimF)/norm(fprimExakt);

% Rita
feltxt = ['Relativt fel i beräkning ',num2str(felF)];
plot(xh,fprimF,'r.','MarkerSize',12);
hold on
plot(x,fprim(x),'b-');
hold off
title(['Diskretiseringsfel i beräkning av derivata, h = ',num2str(h)]);
xlabel('x');
ylabel('Derivata, beräknad och exakt');
legend('Beräknad derivata','Exakt derivata');
text(0.1,7,feltxt,'FontSize',14);
end  % Slut huvudprogram

% -------------------------
% Interna funktioner
% -------------------------

function fxprim = ForwardDiff(fx, x, h)
% fxprim = ForwardDiff(@fx, x, h);
% Beräknar derivatan till funktionen fx i punkterna x med
% framåtdifferens och steglängd h. Funktionen fx defineras 
% som ett funktionshandtag med inparameter x och funktionsv?rdet 
% som utparameter

fxprim = (fx(x+h) - fx(x))./h;
end

% ------------------------
% Interna funktioner

function h = OpenDialogBox()
% h = OpenDialogBox
% Dialogruta för att ge värdet på h

% Text i dialogrutan
txt1 ='Beräkna (f(x+h)-f(x))/h på intervallet x=[0 2].';
txt2 ='Välj parameter h';
txt3 = 'h=';
txt = {sprintf([txt1 '\n' txt2 '\n\n' txt3])};      % Sätt samman text
dlg_title = 'Diskretiseringsfel i framåtdifferens'; % Titel i dialogruta
num_lines = [1 60];                            % Storlek på dialogruta

%options.Interpreter = 'latex';
options.Interpreter = 'none';
options.WindowStyle = 'normal';
options.Resize = 'off';
answer = inputdlg(txt, dlg_title, num_lines, {''}, options);
if isempty(answer)
    h = NaN;
    return
end
h = str2double(answer{:});

end
