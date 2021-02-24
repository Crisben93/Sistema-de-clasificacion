clc
clear
close all

%% Creamos un solo dataset

ds1 = csvread('Dataset_1.csv');
ds2 = csvread('Dataset_2.csv');
ds3 = csvread('Dataset_3.csv');
ds4 = csvread('Dataset_4.csv');
ds5 = csvread('Dataset_5.csv');
ds6 = csvread('Dataset_6.csv');
ds7 = csvread('Dataset_7.csv');
ds8 = csvread('Dataset_8.csv');
ds9 = csvread('Dataset_9.csv');
ds10 = csvread('Dataset_10.csv');
de11 = csvread('Dataset_11.csv');
de12 = csvread('Dataset_12.csv');
de13 = csvread('Dataset_13.csv');
de14 = csvread('Dataset_14.csv');
de15 = csvread('Dataset_15.csv');
de16 = csvread('Dataset_16.csv');
de17 = csvread('Dataset_17.csv');
de18 = csvread('Dataset_18.csv');
de19 = csvread('Dataset_19.csv');
de20 = csvread('Dataset_20.csv');

%%
dataset = [ds1 ds2 ds3 ds4 ds5 ds6 ds7 ds8 ds9 de11 de12 de13 de14 de15 de16 de17 de18 de19 ds10 de20]
csvwrite('Dataset_Env.csv', dataset);

%%
dataset_t = dataset.'
csvwrite('Dataset_Env_T.csv', dataset_t);

%% Creacion de las etiquetas. 0=Sano y 1=Enfermo
lh = zeros(90,1)
lh2 = zeros(10,1)
le = ones(90,1) 
le2 = ones (10,1)

labels = [lh;le;lh2;le2]

%%

csvwrite('labels.csv', labels);
%%
labels_t = labels.'
csvwrite('labels_t.csv', labels_t);




