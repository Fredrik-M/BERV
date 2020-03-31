% absrelfel
% K�r programmet genom att skriva absrelfel i kommandof�nstret. 
% Programmet visar absolut repektive relativt fel

disp(' ')
disp('Du ska nu mata in tv� tal,')
disp('d�r vi ska uppfatta det ena som ett korrekt v�rde')
disp('och det andra som ett n�rmev�rde till r�tta v�rdet.')
disp(' ');
korr = input('Vilket �r det korrekta v�rdet? ');
fel = input('Vilket �r n�rmev�rdet? ');
absfel = norm(korr - fel);
relfel = absfel/norm(korr);
disp(' ');
disp(['Absolut fel: ',num2str(absfel)]);
disp(['Relativt fel: ',num2str(relfel), ', eller i procent: ', num2str(relfel*100)]);