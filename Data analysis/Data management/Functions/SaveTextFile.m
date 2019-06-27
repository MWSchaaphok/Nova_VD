function [] = SaveTextFile(data)
    
    % Find the name of the data file
    IndexSlash = strfind(data.DAQfile,'\');
    IndexDot = strfind(data.DAQfile,'.');
    Filename = extractBetween(data.DAQfile,IndexSlash(end)+1,IndexDot(end));
    filepath = extractBetween(data.DAQfile,1,IndexSlash(end));
    % Make a new textfile with the same name as the data file. 
    fileid = strcat(filepath{1},Filename{1},'txt');
    fileID = fopen(fileid,'w');
    
    % Enter the information about data sheet in the textf file 
    fprintf(fileID, 'Name team member: %s.\r\n',data.Name);
    datestr = strcat(num2str(data.Date(3)),'-',num2str(data.Date(2)),'-',num2str(data.Date(1)));
    fprintf(fileID, 'Test date: %s.\r\n',datestr);
    fprintf(fileID, 'File name test data: %s.\r\n',data.DAQfile);
    fprintf(fileID, 'Type of test: %s.\r\n',data.TestType);
    fprintf(fileID, 'Track: %s.\r\n',data.Track);
    fprintf(fileID, 'Number of laps: %d.\r\n',data.Laps);
    fprintf(fileID, 'Weather type: %s.\r\n',data.WeatherType);
    fprintf(fileID, 'Temperature: %4.1f.\r\n',data.Temperature);
    fprintf(fileID, 'Track conditions: %s.\r\n',data.TrackConditions);
    fprintf(fileID, 'Tire Compound: %s.\r\n',data.TireCompound);
    fprintf(fileID, 'Tire Pressure: %4.1f.\r\n',data.TirePressure);
    fprintf(fileID, 'Gear ratio: %7.5f.\r\n',data.GearRatio);
    fprintf(fileID, 'Notes: %s.\r\n',data.Notes);
    fclose(fileID);

end