function Fission(cell,rule)
father_path{node_num}=cell;
%Cell represents the initial value, and rule represents rules
s1 =length(rule{1});
s2 =length(rule{2});
c1 =length(cell);
%Find the value that meets the rules
value_position =strfind(cell,rule{1});
value_number =length(value_position);
if value_number>0
    %List the possible values for listing according to the rules
    for i=1:value_number
        ring=[];
        aim = value_position(i);
        %Execution rules
        re_cell = [cell(1:aim-1) rule{2} cell(aim+s1:c1)];
        %Determine whether the value after the change has a ring-that is, the value after the change is the same as in the parent node
        for j=1:length(father_path)
            ring(j) =strcmp(re_cell,father_path{j});
        end
        %If there is no loop, it will continue to recuble
        if sum(ring)==0
              %Whether the rules have changed or unchanged
              rule{1}='AB';rule{2}='BA';
              %Recursion
              Fission(re_cell,rule)
             father_path(length(father_path))=[];
        end
        
        
        
    end
else
    
    father_path(length(father_path))=[];
end

end