function interfaceGestion

% print en mol/s 
% print en tonnes/jour
% print details
% print four
% print only input and outputs
% figure etude environnmentale

% cr�ation du cadre
handles(1)=figure('units','pixels',...
    'position',[800 500 600 500],...
    'color',[0.935 0.95 0.657],...
    'numbertitle','off',...
    'name','Outil de gestion du plan d''ammoniac',...
    'menubar','none');

% flux de NH3
uicontrol ( 'style' , ' text' , 'units',...
    'normalized', 'position', [0.1,0.8,0.35,0.05] ,...
    'backgroundcolor','g','fontsize',15,'fontname','roman',...
    'string' , 'Quantit� de NH3 [t/jour]' );
mNH3= uicontrol ( 'style' , 'edit' ,...
    'fontname','arial','fontsize',15,...
    'units','normalized', 'position', [0.5,0.8,0.2,0.06] ,...
    'string' , '0' );

%%%%%%%%%% DONNEES %%%%%%%%%%

uicontrol ( 'style' , ' text' , 'units',...
    'normalized', 'position', [0.,0.7,0.3,0.05] ,...
    'backgroundcolor','m','fontsize',15,'fontname','roman',...
    'string' , 'Reformeur primaire' );
% temperature du reformer primaire
uicontrol ( 'style' , ' text' , 'units',...
    'normalized', 'position', [0.1,0.6,0.35,0.05] ,...
    'backgroundcolor','g','fontsize',15,'fontname','roman',...
    'string' , 'Temp�rature [K]' );
tRef1= uicontrol ( 'style' , 'edit' ,...
    'fontname','arial','fontsize',15,...
    'units','normalized', 'position', [0.5,0.6,0.2,0.06] , ...
    'string' , '0' );

% pression du reformer primaire
uicontrol ( 'style' , ' text' , 'units',...
    'normalized', 'position', [0.1,0.5,0.35,0.05] ,...
    'backgroundcolor','g','fontsize',15,'fontname','roman',...
    'string' , 'Pression [bar]' );
pRef1= uicontrol ( 'style' , 'edit' ,...
    'fontname','arial','fontsize',15,...
    'units','normalized', 'position', [0.5,0.5,0.2,0.06] ,...
    'string' , '26' );

%%%%%%%%%% BOUTONS %%%%%%%%%%

% analyse parametrique
uicontrol('style','pushbutton',... 
    'units','normalized',...
    'position',[0.1 0.3 0.3 0.06],...
    'string','Analyse param�trique',...    
    'fontsize',13',...
    'callback',@analyseParam);

% analyse environnementale
uicontrol('style','pushbutton',... 
    'units','normalized',...
    'position',[0.1 0.2 0.3 0.06],...
    'string','Analyse environnementale',...    
    'fontsize',13',...
    'callback',@analyseEnv);

% simulation purge theorique
uicontrol('style','pushbutton',... 
    'units','normalized',...
    'position',[0.1 0.1 0.3 0.06],...
    'string','Simulation purge',...    
    'fontsize',13',...
    'callback',@purgeTheorique);

% printMasses
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.6 0.25 0.25 0.06],...
    'string','Print flux [tonnes/jour]',...  
    'fontsize',13',...
    'callback',@printMasses);

% printMoles
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.6 0.15 0.25 0.06],...
    'string','Print flux [moles/s]',... 
    'fontsize',13',...
    'callback',@printMoles);

% informations
action=uicontrol ( 'style' , ' text' , 'units',...
    'normalized', 'position', [0.05,0.9,0.92,0.05] ,...
    'backgroundcolor','k','foregroundcolor','w','fontsize',15,'fontname','roman',...
    'string' , 'Hello !' );

% stop
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.1 0.01 0.8 0.06],...
    'string','STOP',...  
    'fontsize',13',...
    'callback',@stopAll);

%%%%%%%%%% FONCTIONS %%%%%%%%%%

function printMoles(~,~)
    pause(3); 
    set(action,'String','Flux en moles/s : done');
end

function printMasses(~,~)
    % printAll
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.5 0.4 0.3 0.06],...
    'string','Details',...   
    'fontsize',13',...
    'callback',@printAll,...
    'tag','bouton+');
    
end

function printAll(~,~)
    m_nh3 = str2double(get(mNH3,'string'));
    T     = str2double(get(tRef1,'string'));
    p_ref1= str2double(get(pRef1,'string'));
    
    main(m_nh3,T,p_ref1);
    set(action,'String','Flux en tonnes/jour : done');
end

function analyseParam(~,~)
    analyseParametrique;
    set(action,'String','Analyse parametrique : done');
end

function analyseEnv(~,~)
    pause(3); 
    set(action,'String','Analyse environnementale :�done');
end

function purgeTheorique(~,~)
    pause(3); 
    set(action,'String','Simulation purge : done');
end

function stopAll(~,~)
    close all
end


end

