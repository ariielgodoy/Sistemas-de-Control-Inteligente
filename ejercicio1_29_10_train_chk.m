numPts=51;
x=linspace (-1,1, numPts)';
y=0.6*sin (pi*x) +0.3*sin (3*pi*x) +0.1*sin(5*pi*x);
data= [x y];
trndata= data(1:2: numPts, :);
chkdata = data(2:2: numPts, :);

plot (trndata (:,1), trndata (:,2), 'o', chkdata (:,1), chkdata (:,2), 'x')

% Número y tipo de funciones de pertenencia de entrada
numMFs = 5;
mfType = 'gbellmf';

% Generar la matriz FIS a partir de los datos de entrenamiento
fismat = genfis1(trndata, numMFs, mfType);

% Graficar las funciones de pertenencia de la primera entrada
[x, mf] = plotmf(fismat, 'input', 1);
plot(x, mf);

% Número de épocas de entrenamiento
numEpochs = 40;

% Entrenamiento del sistema ANFIS
[fismat1, trnErr, ss, fismat2, chkErr] = ...
    anfis(trndata, fismat, numEpochs, NaN, chkdata);

% Comprobar el resultado del entrenamiento
trnOut = evalfis(trndata(:,1), fismat1);

% Calcular el RMSE de entrenamiento
trnRMSE = norm(trnOut - trndata(:,2)) / sqrt(length(trnOut))

% Evaluar el modelo con los datos de comprobación
chkOut = evalfis(chkdata(:,1), fismat2);

% Calcular el RMSE de comprobación
chkRMSE = norm(chkOut - chkdata(:,2)) / sqrt(length(chkOut))

% Definir el número de épocas
epoch = 1:numEpochs;

% Graficar los errores de entrenamiento y comprobación
plot(epoch, trnErr, 'o', epoch, chkErr, 'x');
hold on;

% Graficar ambas curvas de error
plot(epoch, [trnErr chkErr]);

hold off;

% Step size during the training:
plot(epoch,ss,'-',epoch,ss,'x')

% Membership functions after training:
[x,mf] = plotmf(fismat1,'input',1);
plot(x,mf)

% Finally we can compare fuzzy system output to the training and checking data:
anfis_y = evalfis(x(:,1),fismat1);
plot(trndata(:,1),trndata(:,2),'o',chkdata(:,1),chkdata(:,2),'x',x,anfis_y,'-')

% Open the ANFIS editor:
anfisedit