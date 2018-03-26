function [x,f,eflag,outpt] = provaOpt(x0, profileFunction)

options = optimoptions('fmincon','Display','iter-detailed','Algorithm',...
                       'interior-point','UseParallel',true);

xLast = []; % Last place computeall was called
myf = []; % Use for objective at xLast
myc = []; % Use for nonlinear inequality constraint
myceq = []; % Use for nonlinear equality constraint

fun = @objfun; % the objective function, nested below
cfun = @constr; % the constraint function, nested below

A = [];
b = [];
Aeq = [];
beq = [];
lb = [] ;
ub = [];

% Call fmincon
[x,f,eflag,outpt] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,cfun,options);

    function y = objfun(x)
        disp(["X= " x])
        if ~isequal(x,xLast) % Check if computation is necessary
            disp("Evaluating objective function")
            [myf,myc,myceq] = MainRoutine(x, profileFunction);
            xLast = x;
        else
            disp("Obtaining evaluated objective function")
        end
        % Now compute objective function
        y = myf;
    end

    function [c,ceq] = constr(x)
        disp(["X= " x])
        if ~isequal(x,xLast) % Check if computation is necessary
            disp("Evaluating nonlinear constraint")
            [myf,myc,myceq] = MainRoutine(x, profileFunction);
            xLast = x;
        else
            disp("Obtaining evaluated nonlinear constraints")
        end
        % Now compute constraint functions
        c = myc; % In this case, the computation is trivial
        ceq = myceq;
    end

end