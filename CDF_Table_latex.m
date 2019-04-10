% out = CDF_Table_latex(title,data,N_fig,cap,label,N_line,do_full)
% May have to change the seperator in "connect_items2" depending on
% requirements
% "title" is the title of rach column

function out = CDF_Table_latex(title,data,N_fig,cap,label,N_line,do_full,septor,is_error_after)

    if ~exist('do_full','var'),  do_full = 1; end 
    if ~exist('N_line','var'),  N_line = size(data,1); end 
    if ~exist('septor','var'), septor = ',';   end
    if isempty(septor), septor = ',';   end
    if ~exist('is_error_after','var'), is_error_after = zeros(size(data)); end
    
    is_error_after
    
    out = ['\n\n\n'];
    for i = 1:ceil(size(data,1)/N_line)
        if i == 1,
            dat = data((i-1)*N_line+1 : i * N_line,:);
            temp = sub_table(title,dat,N_fig,cap,label,do_full,septor,is_error_after);
        else
            dat = data((i-1)*N_line+1 : min(i * N_line, size(data,1)),:);
            cap = ['Continue Tab.\\ref{',label,'}'];
            temp = sub_table(title,dat,N_fig,cap,'',do_full,septor,is_error_after);
        end            
        out = [out, temp, '\n\n\n'];
    end
    
    if nargout == 0,
        fprintf(out);
    end
    
end

function out = sub_table(title,data,N_fig,cap,label,do_full,septor,is_error_after)

    out = [];
    
    if do_full,
        out = [out, '\\begin{table}\n'];
        
        % inset caption here ........................
        out = [out, '\\caption{',cap,'}\n'];
        % ...........................................
        
        out = [out, '\\begin{center}\n'];
        
        % inset label here ..........................
        if ~isempty(label),
            out = [out, '\\label{',label,'}\n'];
        end
        % ...........................................
        
        out = [out, '\\begin{tabular}  {cccccccrc} \n'];
        out = [out, '\\hline\\hline\n'];
        
        % inset titles here .........................
        out = [out, connect_items(title), '\n'];
        % ...........................................
        
        out = [out, '\\hline\n'];
    end

    % inset body here ...........................
    for i = 1:size(data,1)
        out = [out, connect_items(data(i,:),N_fig,septor,is_error_after(i,:)), '\n'];
    end
    % ...........................................

    if do_full,
        out = [out, '\\hline\\hline\n'];
        out = [out, '\\end{tabular}\n'];
        out = [out, '\\end{center}\n'];
        out = [out, '\\end{table}\n'];
    end
    
end


function out = connect_items(input,N_fig,septor,is_error)
    out = [];
    if iscell(input),
        for i = 1:numel(input)-1
            if  ischar(input{i}),
                out = [out,' ',input{i},' & '];
            else
                out = [out,' ',connect_items2(input{i},N_fig,septor,is_error{i}),' & '];
            end
        end
        i = numel(input);
        if  ischar(input{i}),
            out = [out,' ',input{i},' \\\\ '];
        else
            out = [out,' ',connect_items2(input{i},N_fig,septor,is_error{i}),' \\\\ '];
        end
            
    else
        for i = 1:numel(input)-1
            out = [out,' ',table_str2num(input(i),N_fig),' & '];
        end
        i = numel(input);
        out = [out,' ',table_str2num(input(i),N_fig),' \\\\ '];
    end
end


function out = connect_items2(input,N_fig,septor,is_error)
    out = [];
    for i = 1:numel(input)
        if is_error(i) == 1,
            out = [out , table_str2num(input(i),N_fig),' $\\pm$ '];
        else
            out = [out , table_str2num(input(i),N_fig),' ',septor,' '];
        end
    end
    out(end-1:end) = [];
end


function out = table_str2num(input,N_fig)

    if input == fix(input)
        out = num2str(input,['%10.',num2str(N_fig),'f']);
    else
        out = num2str(input,['%10.',num2str(N_fig),'f']);
    end
end
            