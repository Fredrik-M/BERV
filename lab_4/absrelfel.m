% absrelfel
% Kör programmet genom att skriva absrelfel i kommandofönstret. 
% Programmet visar absolut repektive relativt fel

disp(' ')
disp('Du ska nu mata in två tal,')
disp('där vi ska uppfatta det ena som ett korrekt värde')
disp('och det andra som ett närmevärde till rätta värdet.')
disp(' ');
korr = input('Vilket är det korrekta värdet? ');
fel = input('Vilket är närmevärdet? ');
absfel = norm(korr - fel);
relfel = absfel/norm(korr);
disp(' ');
disp(['Absolut fel: ',num2str(absfel)]);
disp(['Relativt fel: ',num2str(relfel), ', eller i procent: ', num2str(relfel*100)]);