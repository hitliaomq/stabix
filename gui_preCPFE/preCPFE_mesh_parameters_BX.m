% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function handles = preCPFE_mesh_parameters_BX(mesh_variables, x0, hu, wu, fem_software)
%% Function to create and fill string boxes and edit boxes to set indenter and indentation properties
% mesh_variables: Name of mesh variables from the mesh layout
% x0: origin of x coordinate
% hu: heigth unit
% wu: width unit
% fem_software: Abaqus or Mentat

% author: d.mercier@mpie.de

[handles.w_sample_str, handles.w_sample_val]       = set_inputs_boxes({'w_sample (microns)'}, [x0 hu*17.5 wu*2.8 x0/2],mesh_variables.variables.w_sample, 'preCPFE_indentation_setting_BX');
[handles.h_sample_str, handles.h_sample_val]       = set_inputs_boxes({'h_sample (microns)'}, [x0 hu*16.9 wu*2.8 x0/2],mesh_variables.variables.h_sample, 'preCPFE_indentation_setting_BX');
[handles.len_sample_str, handles.len_sample_val]   = set_inputs_boxes({'len_sample (microns)'}, [x0 hu*16.3 wu*2.8 x0/2],mesh_variables.variables.len_sample, 'preCPFE_indentation_setting_BX');
[handles.inclination_str, handles.inclination_val] = set_inputs_boxes({'Inclination (degrees)'}, [x0 hu*15.7 wu*2.8 x0/2],mesh_variables.variables.inclination, 'preCPFE_indentation_setting_BX');
[handles.ind_dist_str, handles.ind_dist_val]       = set_inputs_boxes({'Distance GB-indent (microns)'}, [x0 hu*15.1 wu*2.8 x0/2],mesh_variables.variables.ind_dist, 'preCPFE_indentation_setting_BX');
% txt boxes for subdivision
[handles.box_elm_nx_str, handles.box_elm_nx_val]   = set_inputs_boxes({'box_elm_nx'}, [x0 hu*14.5 wu*2.8 x0/2],mesh_variables.variables.box_elm_nx, 'preCPFE_indentation_setting_BX');
[handles.box_elm_nz_str, handles.box_elm_nz_val]   = set_inputs_boxes({'box_elm_nz'}, [x0 hu*13.9 wu*2.8 x0/2],mesh_variables.variables.box_elm_nz, 'preCPFE_indentation_setting_BX');
[handles.box_elm_ny1_str, handles.box_elm_ny1_val] = set_inputs_boxes({'box_elm_ny1'}, [x0 hu*13.3 wu*2.8 x0/2],mesh_variables.variables.box_elm_ny1, 'preCPFE_indentation_setting_BX');
[handles.box_elm_ny2_fac_str, handles.box_elm_ny2_val] = set_inputs_boxes({'box_elm_ny2'}, [x0 hu*12.7 wu*2.8 x0/2],mesh_variables.variables.box_elm_ny2, 'preCPFE_indentation_setting_BX');
[handles.box_elm_ny3_str, handles.box_elm_ny3_val] = set_inputs_boxes({'box_elm_ny3'}, [x0 hu*12.1 wu*2.8 x0/2],mesh_variables.variables.box_elm_ny3, 'preCPFE_indentation_setting_BX');
% txt boxes for bias
if strfind(fem_software, 'Abaqus')
    [handles.box_bias_x_str, handles.box_bias_x_val]  = set_inputs_boxes({'box_bias_x (>= 1)'}, [x0 hu*11.5 wu*2.8 x0/2],mesh_variables.variables.box_bias_x_abaqus, 'preCPFE_indentation_setting_BX');
    [handles.box_bias_z_str, handles.box_bias_z_val]  = set_inputs_boxes({'box_bias_z (>= 1)'}, [x0 hu*10.9 wu*2.8 x0/2],mesh_variables.variables.box_bias_z_abaqus, 'preCPFE_indentation_setting_BX');
    [handles.box_bias_y1_str, handles.box_bias_y1_val] = set_inputs_boxes({'box_bias_y1 (>= 1)'}, [x0 hu*10.3 wu*2.8 x0/2],mesh_variables.variables.box_bias_y1_abaqus, 'preCPFE_indentation_setting_BX');
    [handles.box_bias_y2_str, handles.box_bias_y2_val] = set_inputs_boxes({'box_bias_y2 (>= 1)'}, [x0 hu*9.7 wu*2.8 x0/2],mesh_variables.variables.box_bias_y2_abaqus, 'preCPFE_indentation_setting_BX');
    [handles.box_bias_y3_str, handles.box_bias_y3_val] = set_inputs_boxes({'box_bias_y3 (>= 1)'}, [x0 hu*9.1 wu*2.8 x0/2],mesh_variables.variables.box_bias_y3_abaqus, 'preCPFE_indentation_setting_BX');
elseif strfind(fem_software, 'Mentat')
    [handles.box_bias_x_str, handles.box_bias_x_val]  = set_inputs_boxes({'box_bias_x (-0.5 to 0.5)'}, [x0 hu*11.5 wu*2.8 x0/2],mesh_variables.variables.box_bias_x_mentat, 'preCPFE_indentation_setting_BX');
    [handles.box_bias_z_str, handles.box_bias_z_val]  = set_inputs_boxes({'box_bias_z (-0.5 to 0.5)'}, [x0 hu*10.9 wu*2.8 x0/2],mesh_variables.variables.box_bias_z_mentat, 'preCPFE_indentation_setting_BX');
    [handles.box_bias_y1_str, handles.box_bias_y1_val] = set_inputs_boxes({'box_bias_y1 (-0.5 to 0.5)'}, [x0 hu*10.3 wu*2.8 x0/2],mesh_variables.variables.box_bias_y1_mentat, 'preCPFE_indentation_setting_BX');
    [handles.box_bias_y2_str, handles.box_bias_y2_val] = set_inputs_boxes({'box_bias_y2 (-0.5 to 0.5)'}, [x0 hu*9.7 wu*2.8 x0/2],mesh_variables.variables.box_bias_y2_mentat, 'preCPFE_indentation_setting_BX');
    [handles.box_bias_y3_str, handles.box_bias_y3_val] = set_inputs_boxes({'box_bias_y3 (-0.5 to 0.5)'}, [x0 hu*9.1 wu*2.8 x0/2],mesh_variables.variables.box_bias_y3_mentat, 'preCPFE_indentation_setting_BX');
end
end