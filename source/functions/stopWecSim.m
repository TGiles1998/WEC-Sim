%% stopWecSim
% Post processing and save functions that are performed after simulation
% has ended. These functions were pulled from the wecSim.m file, following
% the command to simulate the Simulink model.

try cd (['..' filesep parallelComputing_dir filesep '..' filesep]); end

% Clear intermediate variables and variant subsystem flags
clear nlHydro sv_linearHydro sv_nonlinearHydro ssCalc radiation_option sv_convolution sv_stateSpace sv_constantCoeff typeNum B2B sv_B2B sv_noB2B;
clear nhbod* sv_b* sv_noWave sv_regularWaves sv_irregularWaves sv_udfWaves sv_instFS sv_meanFS sv_MEOn sv_MEOff morisonElement flexHydrobody_* sv_irregularWavesNonLinYaw sv_regularWavesNonLinYaw yawNonLin numBody;
clear sv_visualizationOFF sv_visualizationON visON X Y
clear dragBodLogic hydroBodLogic nonHydroBodLogic idx it numNonHydroBodies morisonElement* nonLinearHydro*;
clear runWecSimCML

toc

tic
%% Post processing and Saving Results
postProcessWecSim
% User Defined Post-Processing
if exist('userDefinedFunctions.m','file') == 2
    userDefinedFunctions;
end

% Paraview output. Must call while output is an instance of responseClass 
paraviewVisualization

% ASCII files
if simu.saveText==1
    output.writetxt();
end
if simu.saveStructure==1
    warning('off','MATLAB:structOnObject')
    outputStructure = struct(output);
end


%% Save files
clear ans table tout;
toc
diary off

if simu.saveWorkspace==1
    try 
       cd(parallelComputing_dir);
       simu.caseDir = [simu.caseDir filesep parallelComputing_dir];
    end
    outputFile = [simu.caseDir filesep 'output' filesep simu.caseFile];
    save(outputFile,'-v7.3')
end
try 
    cd (['..' filesep parallelComputing_dir filesep '..' filesep]); 
end

%% Remove 'temp' directory

% Remove 'temp' directory from path and remove 'temp' directory
rmpath(fullfile(projectRootDir,'temp'));
try
    rmdir(fullfile(projectRootDir,'temp'),'s');
end

% Reset the loction of Simulink-generated files
Simulink.fileGenControl('reset');

clear projectRootDir
