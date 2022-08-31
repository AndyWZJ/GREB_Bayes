function Fission(cell,rule)
father_path{node_num}=cell;
%cell means initial value, rule means rule
s1 =length(rule{1});
s2 =length(rule{2});
c1 =length(cell);
%Find the value that matches the rule
value_position =strfind(cell,rule{1});
value_number =length(value_position);
if value_number>0
    %For listing all possible values according to the rule
    for i=1:value_number
        ring=[];
        aim = value_position(i);
        %Implementation rules
        re_cell = [cell(1:aim-1) rule{2} cell(aim+s1:c1)];
        %Determine whether the changed value has a ring - i.e. whether the changed value is the same as the value in the parent node
        for j=1:length(father_path)
            ring(j) =strcmp(re_cell,father_path{j});
        end
        %Recursion will only continue if there is no loop
        if sum(ring)==0
              %Are the rules changing or staying the same?
              rule{1}='AB';rule{2}='BA';
              %Recursive
              Fission(re_cell,rule)
             father_path(length(father_path))=[];
        end
        
        
        
    end
else
    
    father_path(length(father_path))=[];
end

end