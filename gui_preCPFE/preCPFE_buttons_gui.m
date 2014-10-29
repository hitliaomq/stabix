% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function handles = preCPFE_buttons_gui(x0, hu, wu)
%% Function to create buttons for the GUI
% x0: origin of x coordinate
% hu: heigth unit
% wu: width unit

% authors: d.mercier@mpie.de

gui = guidata(gcf);

parent = gcf;

%% Pop-up menu to set the mesh quality
handles.pm_mesh_quality = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*7.3 wu*3 hu*0.9],...
    'Style', 'popup',...
    'String', {'Free mesh'; 'Coarse mesh'; 'Fine mesh'; 'Very fine mesh'; 'Ultra fine mesh'},...
    'BackgroundColor', [0.9 0.9 0.9],...
    'FontWeight', 'bold',...
    'FontSize', 10,...
    'HorizontalAlignment', 'center',...
    'Value', 2);

%% Checkbox to plot deformed indenter
handles.cb_indenter_post_indentation = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*6.5 wu*3 hu*0.9],...
    'Style', 'checkbox',...
    'String', 'Plot indenter after indentation',...
    'BackgroundColor', [0.9 0.9 0.9],...
    'FontWeight', 'bold',...
    'FontSize', 10,...
    'HorizontalAlignment', 'center');

%% Button to give picture of the mesh with names of dimensions use to describe the sample and the mesh
handles.pb_mesh_example = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*5.5 wu*3 hu*0.9],...
    'Style', 'pushbutton',...
    'String', 'Mesh layout',...
    'BackgroundColor',[0.9 0.9 0.9],...
    'FontWeight', 'bold',...
    'FontSize', 14,...
    'HorizontalAlignment', 'center');

%% Creation of string boxes and edit boxes for the calculation of the number of elements
handles.num_elem = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*4.8 wu*3 hu/2],...
    'Style', 'text',...
    'String', 'Number of elements',...
    'BackgroundColor', [0.9 0.9 0.9],...
    'HorizontalAlignment', 'center',...
    'FontWeight', 'bold',...
    'FontSize', 12);

%% Creation of string boxes and edit boxes for the calculation of the transition depth
handles.trans_depth = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*4.2 wu*3 hu/2],...
    'Style', 'text',...
    'String', 'Transition depth',...
    'BackgroundColor', [0.9 0.9 0.9],...
    'HorizontalAlignment', 'center',...
    'FontWeight', 'bold');

%% Pop-up menu to set FEM software
handles.pm_FEM_interface = preCPFE_solver_popup([2*x0 hu*2 wu*3 hu]);

if isfield(gui.config.CPFEM, 'fem_solver_used')
    preCPFE_set_cpfem_interface_pm(handles.pm_FEM_interface, ...
        gui.config.CPFEM.fem_solvers, gui.config.CPFEM.fem_solver_used);
else
    preCPFE_set_cpfem_interface_pm(handles.pm_FEM_interface, ...
        gui.config.CPFEM.fem_solvers);
end

%% Button to validate the mesh and for the creation of procedure and material files
handles.pb_CPFEM_model = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [2*x0 hu*1 wu*3 hu],...
    'Style', 'pushbutton',...
    'String', 'CPFE  model',...
    'BackgroundColor', [0.2 0.8 0],...
    'FontWeight', 'bold',...
    'FontSize', 12,...
    'HorizontalAlignment', 'center');

%% Pop-up menu to set the color of the mesh (grey or color scale)
handles.pm_mesh_color_title = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [25*x0 hu*19.2 wu*2 hu/2],...
    'Style', 'text',...
    'String', 'Color of the BX:',...
    'BackgroundColor', [0.9 0.9 0.9],...
    'HorizontalAlignment', 'center',...
    'FontSize', 10,...
    'FontWeight', 'bold');

handles.pm_mesh_color = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Position', [32*x0 hu*19.2 wu hu/2],...
    'Style', 'popup',...
    'String', {'Color'; 'Black and White'},...
    'BackgroundColor', [0.9 0.9 0.9],...
    'FontWeight', 'bold',...
    'FontSize', 10,...
    'HorizontalAlignment', 'center',...
    'Value', 1);

if strcmp(gui.GB.active_data, 'SX') == 1
    set(handles.pm_mesh_quality, 'Callback', 'preCPFE_indentation_setting_SX');
    set(handles.cb_indenter_post_indentation, 'Callback', 'preCPFE_indentation_setting_SX');
    set(handles.pb_CPFEM_model, 'Callback', 'preCPFE_indentation_setting_SX');
    set(handles.pm_mesh_color, 'Callback', 'preCPFE_indentation_setting_SX');
    set(handles.pb_mesh_example, 'Callback', 'gui = guidata(gcf); webbrowser(fullfile(gui.config.doc_path_root, gui.config.doc_path_SXind_png));');
elseif strcmp(gui.GB.active_data, 'BX') == 1
    set(handles.pm_mesh_quality, 'Callback', 'preCPFE_indentation_setting_BX');
    set(handles.cb_indenter_post_indentation, 'Callback', 'preCPFE_indentation_setting_BX');
    set(handles.pb_CPFEM_model, 'Callback', 'preCPFE_indentation_setting_BX');
    set(handles.pm_mesh_color, 'Callback', 'preCPFE_indentation_setting_BX');
    set(handles.pb_mesh_example, 'Callback', 'gui = guidata(gcf); webbrowser(fullfile(gui.config.doc_path_root, gui.config.doc_path_BXind_png));');
end

end