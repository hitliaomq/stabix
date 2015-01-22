% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function preCPFE_generate_material_files(CPFEM_code, CPFEM_model, varargin)
%% Generation of material config file (GENMAT OR DAMASK) for BX indentation
% CPFEM_code: GENMAT or DAMASK
% CPFEM_model: 1 for SX indentation and 2 for BX indentation

% authors: d.mercier@mpie.de / c.zambaldi@mpie.de

if nargin < 2
    CPFEM_model = 1;
end

if nargin < 1
    CPFEM_code = 'DAMASK';
end

gui = guidata(gcf);

%% Material config file for GENMAT
if strcmp(CPFEM_code, 'GENMAT') == 1
    %% Creation of the material.mpie file with Euler angles (for GENMAT)
    % Add no comment in the material.mpie file !!! ==> Error
    % You have to remove the end of the name of the material file in order to set the
    % name of this file as "material.mpie"...(only for GENMAT)
    scriptname_material = sprintf('material.mpie');
    
    fid = fopen(fullfile(gui.path_config_file, ...
        scriptname_material),'w+');
    fprintf(fid, 'material.mpie, generated by %s.m for indent %s\n', ...
        mfilename, gui.GB.Titlegbdatacompl);
    fprintf(fid, '%i,1,18\n', CPFEM_model);
    fprintf(fid, '#1 Data for Grain A (id %s)\n', num2str(gui.GB.GrainA));
    fprintf(fid, '6, 6, 18, 1, 0 \n');
    if CPFEM_model == 1 % SX model
        fprintf(fid, '1, %s, %s, %s, 0, 0.50, 1\n', ...
            num2str(gui.GB.activeGrain_eul(1)), ...
            num2str(gui.GB.activeGrain_eul(2)), ...
            num2str(gui.GB.activeGrain_eul(3)));
    elseif CPFEM_model == 2 % BX model
        fprintf(fid, '1, %s, %s, %s, 0, 0.50, 1\n', ...
            num2str(gui.GB.eulerA(1)), ...
            num2str(gui.GB.eulerA(2)), ...
            num2str(gui.GB.eulerA(3)));
        fprintf(fid, '#2 Data for Grain B (id %s)\n', num2str(gui.GB.GrainB));
        fprintf(fid, '6, 6, 18, 1, 0\n');
        fprintf(fid, '1, %s, %s, %s, 0, 0.50, 1\n', ...
            num2str(gui.GB.eulerB(1)), ...
            num2str(gui.GB.eulerB(2)), ...
            num2str(gui.GB.eulerB(3)));
    end
    fclose(fid);
    
    try
        movefile(scriptname_material, gui.path_config_file);
    catch err
        commandwindow;
        error(err.message);
    end
    
    %% Copy material_<structure>.mpie (for GENMAT)
    genmat = struct();
    genmat.material_fname = struct;
    genmat.material_fname.fcc = 'material_fcc.mpie';
    genmat.material_fname.bcc = 'material_bcc.mpie';
    genmat.material_fname.hcp = 'material_hcp.mpie';
    genmat_material_dir = fullfile(get_stabix_root,'gui_preCPFE', ...
        'genmat','');
    phaseA = gui.GB.Phase_A;
    if iscell(phaseA)
        phaseA = phaseA{1};
    end
    fnameA = fullfile(genmat_material_dir, genmat.material_fname.(phaseA));
    copyfile(fnameA, gui.path_config_file)
    phaseB = gui.GB.Phase_B;
    if iscell(phaseB)
        phaseB = phaseB{1};
    end
    fnameB = fullfile(genmat_material_dir, genmat.material_fname.(phaseB));
    copyfile(fnameB, gui.path_config_file)
    
    %% Material config file for DAMASK
elseif strcmp(CPFEM_code, 'DAMASK') == 1
    %% Creation of the material.config file with Euler angles (for DAMASK)
    scriptname_DAMASK_materialconfig = sprintf(...
        '%s_DAMASK_materialconfig.py', gui.GB.Titlegbdatacompl);
    damask_python_path = strrep(fullfile(...
        gui.config.CPFEM.python4fem_module_path, 'damask'), '\', '\\');
    
    fid = fopen(fullfile(gui.path_config_file, ...
        scriptname_DAMASK_materialconfig), 'w+');
    fprintf(fid, ['# Generated by preCPFE_generate_material_files.m ' ...
        '--- DO NOT EDIT\n']);
    fprintf(fid, 'import sys\n');
    fprintf(fid, 'p=''%s'' \n', ...
        gui.config.CPFEM.python4fem_module_path);
    fprintf(fid, 'if p not in sys.path: sys.path.insert(0,p) \n');
    fprintf(fid, 'p=''%s'' \n', damask_python_path);
    fprintf(fid, 'if p not in sys.path: sys.path.insert(0, p) \n');
    fprintf(fid, 'import scipy.io\n');
    fprintf(fid, 'gb_data = scipy.io.loadmat(''%s'')\n', ...
        gui.GB.Titlegbdata);
    fprintf(fid, 'import generate_material_config_file as damask_mat\n');
    fprintf(fid, 'damask_mat.mat_config(gb_data, proc_path=r''%s'')\n', ...
        fullfile(gui.config.CPFEM.proc_file_path, ...
        gui.GB.Titlegbdata));
    fclose(fid);
    % execute the python code that we just generated
    cmd = sprintf('%s "%s"', gui.config.CPFEM.python_executable, ...
        fullfile(gui.path_config_file, ...
        scriptname_DAMASK_materialconfig));
    commandwindow;
    system(cmd);
    
    %% Move of material.config in the corresponding modeling folder (for DAMASK)
    try
        movefile('material.config', gui.path_config_file);
    catch err
        commandwindow;
        error(err.message);
    end
    
end

end