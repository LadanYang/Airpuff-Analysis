%add puffTenBinsFR that only have firing data for the airpuff direction
for n=1:length(cell_megarat_mid)
    cell=cell_megarat_mid{1,n};
    if cell.airpuffdir=="LtoR"
        puff_length=length(cell.LtoRlaps);
        cell_megarat_mid{1,n}.puffTenBinsFR=cell.tenBin3FR(1:puff_length,:);
    end
    if cell.airpuffdir=="RtoL"
        puff_length=length(cell.LtoRlaps);
        total_length=length(cell.tenBin3FR);
        cell_megarat_mid{1,n}.puffTenBinsFR=cell.tenBin3FR(puff_length+1:total_length, :);
    end
    
end


for n=1:length(cell_megarat_mid)
end