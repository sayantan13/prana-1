function varargout = PIVhelp(varargin)
% PIVHELP M-file for PIVhelp.fig
%      PIVHELP, by itself, creates a new PIVHELP or raises the existing
%      singleton*.
%
%      H = PIVHELP returns the handle to a new PIVHELP or the handle to
%      the existing singleton*.
%
%      PIVHELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIVHELP.M with the given input arguments.
%
%      PIVHELP('Property','Value',...) creates a new PIVHELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PIVhelp_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PIVhelp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PIVhelp

% Last Modified by GUIDE v2.5 16-Jun-2010 16:58:38

%     This file is part of prana, an open-source GUI-driven program for
%     calculating velocity fields using PIV or PTV.
%     Copyright (C) 2012  Virginia Polytechnic Institute and State
%     University
% 
%     prana is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PIVhelp_OpeningFcn, ...
                   'gui_OutputFcn',  @PIVhelp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PIVhelp is made visible.
function PIVhelp_OpeningFcn(hObject, eventdata, handles, varargin)
if ~isempty(varargin)
    set(handles.listbox1,'Value',varargin{1});
end
update_text(handles);

handles.output = hObject;
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = PIVhelp_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on selection change in topic list ---
function listbox1_Callback(hObject, eventdata, handles)
update_text(handles);
function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in textbox ---
function edit1_Callback(hObject, eventdata, handles)
update_text(handles)
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function update_text(handles)

A=get(handles.listbox1,'Value');
%prana
if A==1
    set(handles.edit1,'String',...
       {'Prana:' 'This program is designed to read in a set of single exposure images, which are then evaluated using one of the cross-correlation algorithms to estimate the displacement of local regions within the image. [1]' ''...
        'References' ... 
        '[1] J Westerweel, "Fundamentals of digital particle image velocimetry." Meas Sci Tech, 1997. 8(12): p. 1379-1392.' ''});
end
%Job Setup
if A==2
    set(handles.edit1,'String',...
       {'Job Listbox:' 'This lists the currently available PIV jobs.  To create, load, save, copy or delete jobs use the buttons below the job list or go to the file menu.  To run jobs, use the buttons below the image correlation list or go to the execute menu.  To see the different settings of each job, select between the list of jobs.  Jobs cannot have names that begin with numbers or other invalid characters, as information is stored in a structure array.' '' ...
        'Parallel Processing:' 'If your computer has multiple processor cores, each job can be split up equally and run in parallel. The ''Processors to Use'' defaults to the number processor cores detected on the machine. If an error occurs while setting up a parallel job, the program will default back to using a single processor.'});
end
%Physical Parameters
if A==3
    set(handles.edit1,'String',...
       {'General:' 'This section collects information about the experiment, some of which is used to convert the PIV results from pixel units to SI units, and some of which are optional. An experiment summary .txt file will be saved in the output folder summarizing the inputted physical parameters, as well as the processing settings.' ''...
        'Laser Pulse Separation:' 'Input the pulse separation in microseconds (positive real, us)' '' ...
        'Sampling Rate:' 'Input the sampling frequency in Hz between sequential vector fields (positive real, Hz)' ''...
        'Image Resolution:' 'Input the magnification in microns/pixel (positive real, um/pix)' '' ...
        'Additional Information:' 'Inputs to the fields in the rest of this tab are not used by the PIV program, but may be useful to record. If the proper fields are completed, the GUI will calculate the Reynolds and Stokes numbers for the flow, as well as some useful optical parameters.' ''});
end
%Load images
if A==4
    set(handles.edit1,'String',...
       {'General:' 'This section controls the image loading and processing order.  Images must be numerically indexed at end of filename and have a valid file extension.  If images do not show up in listbox, no files will process.' ''...
        'Image Directory:' 'Select the directory in which the image files are located.  Use the browse button to search for files. (string)' '' ...
        'Image Basename:' 'Input the image file basename excluding any number indicies or file extension (string)' '' ...
        'Zeros:' 'Input number of digits in the filename indexing (integer)' '' ...
        'Extension:' 'Image file extension, must be from available formats in imread.m (string)' '' ...
        'Image Correlation Step:' 'Input the separation between correlated image pair (integer)' '' ...
        'Frame Step:' 'Input the separation between velocity fields (integer)' '' ...
        'Frame Start:' 'Input start index of the PIV processing (integer)' '' ...
        'Frame End:' 'Input end index of the PIV processing (integer)' '' ...
        'Select First Image:' 'Select the first image to correlate. The image directory, basename, zeros, extension, and frame start will be set automatically.' '' ...
        'Image + Mask Preview:' 'This button shows the first image in the Correlation List with points marking the velocity grid locations. If a mask has been loaded, grid points will not show up in the masked region(s) and the image intensity in the region(s) is decreased by 50%' '' ...
        'Image Correlation Order:' 'This listbox displays the processing order of the image set using the specified input parameters.  When this listbox is red, some or all of the images cannot be found and the job will not run.' ''});
end
%Data Masking
if A==5
    set(handles.edit1,'String',...
       {'General:' 'This section controls the masking type and loads binary images to be used to mask out data.  Images must be numerically indexed at end of filename and have a valid file extension.' ''...
        'No Processing Mask:' 'All grid points will be processed, and no mask loading is required.' '' ...
        'Static Processing Mask:' 'The same mask file will be applied to every correlation. Grid points located at a zeroed pixel will not be processed. Type the file path in the Static Mask File textbox, use the browse button to search for a file, or create a mask using the Static Mask Tool.' '' ...
        'Static Mask Tool:' 'Allows the user to create a polygonal mask, which is saved to the image directory as ''staticmask.tif''. To create a mask, click on the image to specify the vertices of a polygonal region of interest. Double-click to add a final vertex to the polygon and close the polygon. Right-click to close the polygon without adding a vertex. You can adjust the position of the polygon and individual vertices in the polygon by clicking and dragging. When finished, right-click and select "Create Mask".' '',...
        'Dynamic Masking:' 'A different mask file will be applied to each correlation. The files are loaded using a process similar to that used to load images.' '' ...
        'Mask Directory:' 'Select the directory in which the mask image files are located.  Use the browse button to search for the directory. (string)' '' ...
        'Mask Basename:' 'Input the mask image file basename excluding any number indicies or file extension (string)' '' ...
        'Zeros:' 'Input number of zeros in the filename indexing (integer)' '' ...
        'Extension:' 'Mask image file extension, must be from available formats in imread.m (string)' '' ...
        'Mask Frame Start:' 'Input start index of the PIV processing (integer)' '' ...
        'Frame Step:' 'Input the separation between velocity fields (integer)' '' ...
        'Dynamic Mask Processing Order:' 'This listbox displays the processing order of the image set using the specified input parameters.  When this listbox is red, some or all of the images cannot be found and the job will not run. Unlike image loading, this list only needs the frame start and framestep as user inputs. The frame end is calculated based on the number of correlations in the Image Correlation List. If the Image Correlation List is red or there are not enough mask files in the directory, the Mask Processing Order will not load properly.' ''});
end
%Write Controls
if A==6
    set(handles.edit1,'String',...
       {'General:' 'This section sets the folder where output files will be saved, and how to format the data.' '' ...
        'Output Directory:' 'Input the directory where output files will be placed. Use the browse button to search for a folder. (string)' '' ...
        'Multiple .dat Files:' 'If this box is checked, the program will save an ASCII text file for each correlation that can be read by Tecplot 360.' '' ...
        'Multiple .mat Files:' 'If this box is checked, the program will save the results of each correlation as a separate .mat file which can be loaded into Matlab.' ''});
end
%Data Formatting
if A==7
    set(handles.edit1,'String',...
       {'General: The program will save an X and Y matrix, as well as corresponding U and V matrices and an Eval matrix. If selected in the processing ''Output'' box, information about secondary and tertiary peaks may also be saved. The meaning of values in the Eval matrix is as follows:' '' ...
        '   Eval(i,j) == -1 --- The grid point was not processed because it was covered by a mask.'...
        '   Eval(i,j) ==  0 --- The grid point was processed, and passed validation.'...
        '   Eval(i,j) == 1,2,... --- The grid point was processed, but failed UOD validation on pass 1,2,... of the UOD alogorithm.' ...
        '   Eval(i,j) == 100 --- The grid point was processed, but failed Thresholding Validation.' ...
        '   Eval(i,j) == 200 --- The grid point was processed, but failed Bootstrapping Validation.' ''...
        '.dat Files:' 'U, V, (C), and Eval are the validated results. If information about additional peaks was saved, it will be retured in the variables U1, V1, U2, V2,... C1, C2,... If it desired to black out regions that were masked using Tecplot, copy the main zone, change the new zone''s strand ID, and contour it by Eval using transparent Zebra shading, set to black where Eval=-1.' '' ...
        '.mat Files:' 'U(i,j,1), V(i,j,1), (C(i,j,1)), and Eval(i,j,1) are the validated results. If additional peak information was saved, it will be tacked onto the third dimension of the relevant variable. For example, the correlation strength of peaks 1 and 2 could be accessed at C(:,:,2:3).' ''});
end
%PIV controls
if A==8
    set(handles.edit1,'String',...
       {'PIV Method:' 'This section controls the PIV evaluation technique used to process images.  The listbox indicates the passes that will be used to process each image pair.' ''...
        'Multipass (DWO):' 'Evaluation grid is fixed for all passes.  Different Window sizes, Resolution, and Validation may be applied for each pass.  After each pass, the integer portion of the velocity field is used in a second order Discrete Window Offset (DWO) to increase the correlation strength of subsequent passes [1].  This method can be very computationally expensive, especially for initial passes, where the velocity field is highly oversampled.' '' ...
        'Multigrid (DWO):' 'Evaluation grid is variable between passes.  Different Window sizes, Resolution, and Validation may be applied for each pass.  After each pass, the velocity field is interpolated onto a new grid, which is then used in a second order Discrete Window Offset (DWO) to increase the correlation strength of subsequent passes (activates velocity interpolation function and velocity smoothing) [1].  This method greatly decreases computational costs and results in easier validation (since the velocity fields are not as oversampled).  However, the velocity estimate is limited to the accuracy of the interpolation scheme.  This error is often substantially below the pixel discretization used in the DWO.' '' ...
        'Multigrid (Deform):' 'Evaluation grid is variable between passes.  Different Window sizes, Resolution, and Validation may be applied for each pass.  After each pass, the velocity field is interpolated onto the image grid, which is then used in a second order continuous offset of each pixel.  The image is then interpolated back onto a rectilinear grid (activates velocity interpolation function, velocity smoothing, and image interpolation menu).  This method is a higher order iterative multigrid approach, where higher computational times are required to interpolate the images.  In addition, the accuracy of the interpolation scheme and velocity field plays a critical role in the success of the method.  However, this method often shows substantial increases in accuracy, especially for high shear flows [2].' '' ...
        'Multigrid (Ensemble DWO):' 'Correlates each image pair using a Multigrid DWO.  However, prior to subpixel interpolation, the correlations are averaged over the entire data set.  The subpixel estimator is then applied to the ensemble correlations to generate the ensemble averaged velocity field.  Will only output 1 file.  This method can be very useful for low SNR images, where the correlation strength is low.  Also, very high spatial resolutions can be achieved due to the increased correlation in each frame pair.  However, this will only provide an average flowfield [3].' '' ...
        'Multigrid (Multiframe):' 'Correlates each image pair using a Multigrid DWO. However, in regions with low displacements the algorithm may "step out" to obtain a larger time step / displacement (ie - correlating im1 and im4 instead of im2 and im3). The algorithm described in [4] is used to select the optimal framestep. Only images listed in the Correlation Listbox will be considered, so image pairs at the beginning and end of this list will not be able to step out to a larger framestep. This method is useful for experiments with large velocity gradients, such as a rising bubble or a jet in quiescent fluid. It is advisable to compare results from this method to a standard Multigrid processing. If there are large discrepancies, ensure that the Sampling Rate and Laser Pulse Separation are set correctly' '' ...
        'References:' ...
        '[1] J Westerweel, D Dabiri, and M Gharib, "The effect of a discrete window offset on the accuracy of cross-correlation analysis of digital PIV recordings" Exp Fluids, 1997. 23(1): p. 20-28.' ...
        '[2] F Scarano, Iterative image deformation methods in PIV" Meas Sci Tech, 2002. 13: p. R1-R19.' ...
        '[3] CD Meinhart, ST Wereley, and JG Santiago, "A PIV algorithm for estimating time-averaged velocity fields" Journal of Fluids Engineering, 2000. 122: p. 285-289.' ...
        '[4] T Persoons, TS O''Donovan, and DB Murray, "Improving the measurement accuracy of PIV in a synthetic jet flow" Proceedings of the International Symposium on Applications of Laser Techniques to Fluid Mechanics, Lisbon, Portugal, 2008.'});
end
%Interpolation
if A==9
    set(handles.edit1,'String',...
       {'General:' 'This section controls processing options for the selected processing algorithm.' '' ...      
        'Velocity Interpolation Function (Multigrid):' 'Select desired method to be used in the velocity interpolation onto new grids.' '' ...
        'Image Interpolation Method (Deform):' 'Select the image interpolation function used to interpolate the deformed image back onto a rectilinear grid. [1]' '' ...
        'PIV Error (Multiframe):' 'Input the uncertainty of the PIV algorithm. This is used in determining the optimal framestep.' '' ...
        'Maximum Framestep (Multiframe):' 'Sets the maximum number of frames to step out. For example, entering 1 will result in a max timestep of +/- 1 frame (3*dt), entering 2 will result in a max timestep of 5*dt, and so on.' '' ...
        'References:' ...
        '[1] F Scarano, Iterative image deformation methods in PIV" Meas Sci Tech, 2002. 13: p. R1-R19.' ''});
end
%Setup
if A==10
    set(handles.edit1,'String',...
       {'General:' 'This section sets the processing controls for the PIV pass displayed in the PIV controls listbox' ''...
        'Grid Resolution: "Gx,Gy"' 'Input the grid resolution in the x and y directions (pixel units)' '' ...
        'Window Overlap: "Ox,Oy"' 'If the user prefers, they can set a window overlap percentage which is used to calculate the grid resolution (instead of specifying the grid size directly). This option is not available for use with the Multipass algorithm.' '' ...
        'Grid Buffer: "Bx,By"' 'Input the buffer for the grid to be taken around the image (pixel units).  With grid buffer set to zero, buffer defaults to half the grid resolution.  General practice is to set the buffer to half the window size in order to prevent clipping of the window.' '' ...
        'Bulk Window Offset: "U0,V0"' 'Input the Bulk window offset (pixel units).  Can only be performed on the first pass.  Applies a Discrete Window Offset (DWO) [1] prior to the first pass based upon the uniform image shift given by the bulk window offset.  Use this feature to account for images with large displacement, but be cautious of any near wall or low flow regions.' '' ...
        'Window Resolution: "Rx,Ry"' 'Input the desired window resolution (pixel units).  At least 5 particles should be within this rectangular size on average.  In addition, the window size generally produces poor results when the area of this region is below 256 pixels^2.  The displacement should not exceed 1/4 of the first pass window size.  Several different resolutions should be examined for each data set.  This is the most important parameter in the processing!!' '' ...
        'Window Size: "Wx,Wy"' 'Input the window size (pixel units).  This setting is the actual rectangular window region taken from the image.  This setting, in conjunction with the window resolution controls the spatial window mask applied to each image region.  The rectangular window region is tapered with a Gaussian window, where the taper width is controlled by the spatial resolution.  The resolution is equal to the average width of the Gaussian.  Selecting "auto" will automatically select the nearest power of 2 window size that is at least a 50% Gaussian taper to minimize the effects of wraparound aliasing and spectral leakage [1].  When in doubt, leave on auto.' '' ...
        'Correlation:' 'SCC (Standard Fourier based Cross-Correlation) [2]' 'RPC (Robust Phase Correlation) [2]' '' ...
        'Diameter:' 'Input RPC diameter (pixel units).  Should be "roughly" equivalent to the particle-image diameter. [2]' '' ...
        'Subpixel Correlation Peak Locator:' 'Select the algorithm to use for interpolating the subpixel location of the correlation peak. The Three-point Gaussian is the standard locator. See [3] for a complete description of each method.' ...
        'Zero-Mean Image Windows:' 'If this box is checked, the mean of each image window will be subtracted from each pixel intensity prior to correlating. This produces a slight improvement in accuracy in many situations.' ...
        'Smoothing:' 'Input size for gaussian smoothing filter (positive real, vector units).  Smoothing is generally applied in order to remove high frequency noise that corrupts velocity interpolation.  Smoothing can be set differently for each pass. Can be useful for smoothing out noisy data between passes, but not recommended for general use or on a final pass.' '' ...
        'References:' ...
        '[1] A Eckstein, P Vlachos, 2008, �Improved DPIV Accuracy Using Advanced Windowing Techniques� Proc. ASME Fluids Engineering Conference, FEDSM2008-55152, Jacksonville, FL.' ...
        '[2] A Eckstein, P Vlachos, 2007, "A robust phase correlation DPIV processing algorithm for time resolved measurements" in PIV symposium. Rome, Italy.' ...
        '[3] M.R. Brady, 2006, "Subpixel Resolution Schemes for Multiphase Flows" Virginia Tech. M.S.' ''});
end
%Validation
if A==11
    set(handles.edit1,'String',...
       {'General:' 'This section sets the validation controls for the PIV pass displayed in the PIV controls listbox.  If the "Validate" box is not checked, no validation will be performed.' '' ...
        'Velocity Thresholding (pix/frame):' 'Check this box to threshold the PIV results. If the velocity components at a given grid point are outside the specified threshold range, the measurements will be discarded and new values will be interpolated using the surrounding grid points.' '' ...
        'Umin,Umax and Vmin,Vmax: "Umin,Umax" and "Vmin,Vmax"' 'Input the velocity thresholds on valid measurements.  Make sure that your flow does not exceed these limits for all frames.  Improper thresholding can be hard to detect by observing the vector field alone, use Eval matrix in output plt (Eval=100 for threshold limitation).' '' ...
        'Universal Outlier Detection:' 'Check this box to validate the PIV results using UOD [1]. If the validation fails, the measurements will be discarded and new values will be interpolated using the surrounding grid points. The Eval matrix will show a value of "1" if it fails on the first UOD pass, "2" on the second, ...' '' ...
        'Validation Windows: "Wx1,Wy1;Wx2,Wy2..."' 'Input the size of the windows used to collect local statistics (vector units).  Number of passes is defined by this field and the threshold field (must be equivalent).' '' ...
        'Validation Threshold: "T1,T2..."' 'Input the threshold used in each validation pass (positive real).  The number of validation thresholds must be equivalent to number of validation windows.  Thresholds are determined using the Universal Outlier Detection criterion [1].' '' ...
        'Try additional peaks if initial validation fails:' 'Check this box to validate secondary and tertiary peaks if the maximum correlation peak fails either Thresholding or UOD validation' '' ...
        'Bootstrapping:' 'Check this box to validate the PIV results using Bootstrapping [2]. If the validation fails, the measurements will be discarded and new values will be determined as described by [2]. The Eval matrix will show a value of "200" at gridpoints where the validation fails. This method requires significantly more computation time than UOD and Thresholding.' '' ...
        'Percent Sampled (%): "P"' 'Input the percentage of the grid to sample on each bootstrapping iteration. Enter this as a percentage (default is 15, for 15% sampling), not a decimal (0.15).' '' ...
        'Iterations / Frame: "I"' 'Enter the number of iterations to be performed during each bootstrapping pass.' '' ...
        'Number of Passes: "N"' 'Enter the number of bootstrapping validation passes to perform on the current PIV pass.' '' ...
        'References:' ...
        '[1] J Westerweel, "Universal outlier detection for PIV data" Exp Fluids, 2005. 39: p. 1096-1100.' '' ...
        '[2] CS Pun, A Susanto, D Dabiri, "Mode-ratio bootstrapping method for PIV outlier correction" Meas Sci and Technol, 2007. 18: p. 3511-3522.' ''});
end
%Output
if A==12
    set(handles.edit1,'String',...
       {'General:' 'This section controls the data saved to disk after each pass is completed. If the "Write Output" box is not checked, no data will be written for the selected pass.' ''...
        'Save Additional Peak Information:' 'Checking this box allows the user to save additional information about the peaks in the correlation matrices, which can be useful when doing error analysis on PIV results. The number of peaks to record is selected from the drop-down menu. For multiframe processing, the timestep chosen for each gridpoint will be saved if this box is checked.' '' ...
        'Peak Magnitude:' 'The magnitude of the additional peaks will be saved as C (chosen peak), C1 (First Peak), C2 (Second Peak), ... in the results.' ''...
        'Resulting Velocity:' 'The subpixel location(s) of the additional peak(s) is calculated, and converted to velocity components. The output will have variables U1, V1, U2, V2, ...' '' ...
        'Output basename' 'Input the basename used to create dat files (string).  Outputs are numbered according to the number of the first image in the correlation pair.' ''});
end
