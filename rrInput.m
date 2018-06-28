icell = 1;
trials = size(dat.Fcell,2);

%% Determine size to preallocate matrix
sizeF = nan(1,trials);

for n = 1:trials
    Fcell = cell2mat(dat.Fcell(n));
    sizeF(1,n) = size(Fcell,2);
    maxF = max(sizeF);
end

%% Generate matrices for signed and absolute fluorescence 
Ficell = nan(trials, maxF);
Fabs_icell = nan(trials, maxF);

for n = 1:trials
    Fcell = cell2mat(dat.Fcell(n));
    FcellNeu = cell2mat(dat.FcellNeu(n));
    F = Fcell(icell,:) - FcellNeu(icell,:);
    F(1,maxF) = 0;
    Ficell(n,:) = F;
    Fabs = abs(F);
    Fabs_icell(n,:) = Fabs(icell,:);
end

predX = [Ficell Fabs_icell]; %input matrix for ridge regression

%% First response value after stim onset 
spikes = nan(trials, 1);

for m = 1:trials
    s = cell2mat(dat.sp(m));
    spikes(m,1) = s(icell,1);
end

cellResps = spikes;