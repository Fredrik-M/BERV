function [] = diskretisering()
% diskretisering
% Test av diskretiseringsfel vid numerisk ber�kning av derivatan av
% funktionen f(x) = e^x p� intervallet x = [0 2].
% f'(x) approximeras med fram�tdifferens (f(x+h) - f(x))/h
% I programmet v�ljer anv�ndaren v�rdet p� h och programmet visar
% den ber�knade l�sningen (r�d markering) och exakt l�sning (bl� linje)


close all; % St�ng eventuella figurf�nster
disp(' ----');
disp('Det h�r programmet �sk�dligg�r begreppet diskretisering. N�r man');
disp('diskretiserar ers�tter man n�got kontinuerligt med diskret, t ex')
disp('representerar en kontinuerlig funktion med v�rden i punkter. I det')
disp('h�r fallet ber�knas derivatan f''(x) i ett antal punkter. Hur t�t');
disp('indelningen blir best�ms av valet av deskretiseringsparametern h.')
disp(' ----');
disp(' ');
% Exakt l�sning
l = 0;
u = 2;
antalPunkter = 400;
x = linspace(l,u,antalPunkter);
%func = @(x) exp(x);
%fprim = @(x) exp(x);   % Exakt derivata �r e^x
func = @(x) exp(x);
fprim = @(x) exp(x);

% Se till att h inte blir f�r litet eller f�r stort
lagomStort = false;
while ~lagomStort
    h = OpenDialogBox();
    if isnan(h)
        disp('Hmm, du gav inget v�rde p� h. K�r programmet igen!');
        return
    end
    mode = struct('Interpreter','latex','WindowStyle','modal');
    if (h < 1e-5)
        eh = errordlg('Ge h $\geq$ $10^{-5}$','h f�r litet',mode);
        waitfor(eh);
        lagomStort = false;
    elseif (h >= 1)
        eh = errordlg('Ge h $\leq$ 1','h f�r stort', mode);
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
feltxt = ['Relativt fel i ber�kning ',num2str(felF)];
plot(xh,fprimF,'r.','MarkerSize',12);
hold on
plot(x,fprim(x),'b-');
hold off
title(['Diskretiseringsfel i ber�kning av derivata, h = ',num2str(h)]);
xlabel('x');
ylabel('Derivata, ber�knad och exakt');
legend('Ber�knad derivata','Exakt derivata');
text(0.1,7,feltxt,'FontSize',14);
end  % Slut huvudprogram

% -------------------------
% Interna funktioner
% -------------------------

function fxprim = ForwardDiff(fx, x, h)
% fxprim = ForwardDiff(@fx, x, h);
% Ber�knar derivatan till funktionen fx i punkterna x med
% fram�tdifferens och stegl�ngd h. Funktionen fx defineras 
% som ett funktionshandtag med inparameter x och funktionsv?rdet 
% som utparameter

fxprim = (fx(x+h) - fx(x))./h;
end

% ------------------------
% Interna funktioner

function h = OpenDialogBox()
% h = OpenDialogBox
% Dialogruta f�r att ge v�rdet p� h

% Text i dialogrutan
txt1 ='Ber�kna (f(x+h)-f(x))/h p� intervallet x=[0 2].';
txt2 ='V�lj parameter h';
txt3 = 'h=';
txt = {sprintf([txt1 '\n' txt2 '\n\n' txt3])};      % S�tt samman text
dlg_title = 'Diskretiseringsfel i fram�tdifferens'; % Titel i dialogruta
num_lines = [1 60];                            % Storlek p� dialogruta

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
