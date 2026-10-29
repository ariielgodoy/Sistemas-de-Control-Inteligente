data = [rand(10,1) 10*rand(10,1)-5 rand(10,1)];
fis = genfis1(data,[3 7],char('pimf','trimf'));
[x,mf] = plotmf(fis,'input',1);
subplot(2,1,1),     plot(x,mf);
xlabel('input 1 (pimf)');
[x,mf] = plotmf(fis,'input',2);
subplot(2,1,2), plot(x,mf);
xlabel('input 2 (trimf)');

x = (0:0.1:10)';
y = sin(2*x)./exp(x/5);
epoch_n = 20;
in_fis = genfis1([x y],5,'gbellmf');
out_fis = anfis([x y],in_fis,epoch_n);
plot(x,y,x,evalfis(x,out_fis));
legend('Training Data','ANFIS Output');