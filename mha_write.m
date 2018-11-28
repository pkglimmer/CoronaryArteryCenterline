function mha_write(I,info,filename)
    switch(info.ByteOrder(1))
        case ('true')
            fid=fopen(filename,'w','ieee-be');
        otherwise
            fid=fopen(filename,'w','ieee-le');
    end
    if(isfield(info,'ObjectType'))
        fprintf(fid,'%s = %s \n','ObjectType',info.ObjectType);
    end
    if(isfield(info,'NumberOfDimensions'))
        fprintf(fid,'%s = %d\n','NDims',info.NumberOfDimensions);
    end
    if(isfield(info,'BinaryData'))
        fprintf(fid,'%s = %s\n','BinaryData',info.BinaryData);
    end
    if(isfield(info,'ByteOrder'))
        fprintf(fid,'%s = %s\n','BinaryDataByteOrderMSB',info.ByteOrder);
    end
    if(isfield(info,'CompressedData'))
        fprintf(fid,'%s = %s\n','CompressedData','false');
    end
    if(isfield(info,'TransformMatrix'))
        fprintf(fid,'%s = ','TransformMatrix');
        fprintf(fid, '%d ',info.TransformMatrix);
        fprintf(fid,'\n');
    end
    if(isfield(info,'Offset'))
        fprintf(fid,'%s = ','Offset');
        fprintf(fid, '%d ',info.Offset);
        fprintf(fid,'\n');
    end
    if(isfield(info,'CenterOfRotation'))
        fprintf(fid,'%s = ','CenterOfRotation');
        fprintf(fid, '%d ',info.CenterOfRotation);
        fprintf(fid,'\n');
    end
    if(isfield(info,'AnatomicalOrientation'))
        fprintf(fid,'%s = %s\n','AnatomicalOrientation',info.AnatomicalOrientation);
    end
    if(isfield(info,'PixelDimensions'))
        fprintf(fid,'%s = ','ElementSpacing');
        fprintf(fid, '%f ',info.PixelDimensions);
        fprintf(fid,'\n');
    end
    if(isfield(info,'Dimensions'))
        fprintf(fid,'%s = ','DimSize');
        fprintf(fid, '%d ',size(I));
        fprintf(fid,'\n');
    end
    switch(info.DataType)
        case 'char'
        	I = int8(I); 
         	fprintf(fid,'%s = %s\n','ElementType','MET_CHAR');
        case 'uchar'
            I = uint8(I); 
            fprintf(fid,'%s = %s\n','ElementType','MET_UCHAR');
        case 'short'
            I = int16(I); 
            fprintf(fid,'%s = %s\n','ElementType','MET_SHORT');
        case 'ushort'
            I = uint16(I); 
            fprintf(fid,'%s = %s\n','ElementType','MET_USHORT');
        case 'int'
         	I = int32(I); 
        	fprintf(fid,'%s = %s\n','ElementType','MET_INT');
        case 'uint'
            I = uint32(I); 
         	fprintf(fid,'%s = %s\n','ElementType','MET_UINT');
        case 'float'
         	I = single(I);   
          	fprintf(fid,'%s = %s\n','ElementType','MET_FLOAT');
        case 'double'
            I = double(I);
            fprintf(fid,'%s = %s\n','ElementType','MET_DOUBLE');
    end
    if(isfield(info,'DataFile'))
        fprintf(fid,'%s = %s\n','ElementDataFile',info.DataFile);
    end
    
    fwrite(fid, reshape(I,size(I,1)*size(I,2)*size(I,3),1),info.DataType);
    fclose(fid);
end