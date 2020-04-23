% y  :: [D_A, D_R, Dp_A, Dp_R, M_A, M_R, A, R, C]
% dy :: dy/dt

function dy = CO_ODE(t, y, p)
    dy = zeros(9, 1);
    
    dy(1) = p.theta_A * y(3) - p.gamma_A * y(1) * y(7);
    dy(2) = p.theta_R * y(4) - p.gamma_R * y(2) * y(7);
    dy(3) = p.gamma_A * y(1) * y(7) - p.theta_A * y(3);
    dy(4) = p.gamma_R * y(2) * y(7) - p.theta_R * y(4);
    dy(5) = p.alphaP_A * y(3) + p.alpha_A * y(1) - p.delta_MA * y(5);
    dy(6) = p.alphaP_R * y(4) + p.alpha_R * y(2) - p.delta_MR * y(6);
    dy(7) = p.beta_A * y(5) + p.theta_A * y(3) + p.theta_R * y(4) ...
            - y(7) * (p.gamma_A * y(1) + p.gamma_R * y(2) + p.gamma_C * y(8) + p.delta_A);
    dy(8) = p.beta_R * y(6) - p.gamma_C * y(7) * y(8) + p.delta_A * y(9) - p.delta_R * y(8);
    dy(9) = p.gamma_C * y(7) * y(8) - p.delta_A * y(9); 
end