%Routh-Hurwitz criterion for system stability
%Lucas Gabriel F. Lima, CTG-UFPE
function Routh_Hurwitz(Poly_Vec)
    syms e

    %Necessery but not sufficient conditions for Stability --------------------------------------
    % 1. coefficients can't be zero:
    if nnz(Poly_Vec)<numel(Poly_Vec)
        disp('Routh-Hurwitz: The system is UNSTABLE (one of the coefficients is equal to zero)')
        return
    end
    
    % 2. All coefficients should have the same sign:
    Changed_Sign= any(diff(sign(Poly_Vec)));
    if Changed_Sign == 1
        disp('Routh-Hurwitz: The system is UNSTABLE (Coefficients have diferrent signs)')
        return
    end

    %makes them all positive if negative
    if Poly_Vec(1)<0
        Poly_Vec=Poly_Vec.*(-1);
    end

    n_rows=numel(Poly_Vec);
    n_columns=ceil(n_rows/2);

    %Empty Matrix
    Matz(n_rows,n_columns)=e;


    %First 2 Lines----------------------------------------------
    count= 1;
    for col =1:numel(Poly_Vec)
        if count>n_rows
            break
        end
    
        Matz(1,col)=Poly_Vec(count);
        if count>=n_rows
            break
        end
        Matz(2,col)=Poly_Vec(count+1);
        count=count+2;
    end

    %Tabulation---------------------------------------------
    Symmetric_Poles= 0; %Number of symmetrical Poles
    for i= 3:n_rows %iterate lines of matrix
        an=Matz(i-1,1);
        a1=Matz(i-2,1);
        a2=an;
        Zero_Counter=0;%Number of zeros in the line

        for j= 1:n_columns-1 %iterate columns of matrix
            b1=Matz(i-2,j+1);
            b2=Matz(i-1,j+1);
        
            detM=a2*b1-a1*b2;
            if detM==0
                detM=e;
                Zero_Counter=Zero_Counter+1;
            end
            Matz(i,j)=detM/an;
        end
        %Especial case: full line of zeros-------------------------------------
        if(Zero_Counter==n_columns-1)
            Symmetric_Poles=Symmetric_Poles+1;
            Ps_Degree=numel(Poly_Vec)-(i-1);
            for j= 1:n_columns-1
                Psj=Matz(i-1, j); % J element of Ps
                Psdt=Psj*(Ps_Degree);
                Matz(i,j)=Psdt;
                Ps_Degree=Ps_Degree-2;
            end
              
        end
    end
   %ESPECIAL CASES---------------------------------------
   % Especial Case #1: Zero Proceded by non zero element
    Matx= limit(Matz, e, 0, 'right');
    disp(Matx)

    % Especial Case #2: Full line of zeros
    if Symmetric_Poles == 1
        disp('Routh-Hurwitz:[Warning] The system has a pair of symetrical Poles');
    end
   
    % Especial Case #3: Two Full lines of zeros
    if Symmetric_Poles > 1
        disp('Routh-Hurwitz: [Warning] The system is UNSTABLE (It has more then a pair of symetrical Poles)');
    end
    %Indicates two symmetrical Poles
    % Especial Case #4: Last line is full of zeros
    %Indicates a pole in the origin

end
