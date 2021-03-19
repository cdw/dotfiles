function journal -d "Create journal page for today"
    set now (date +"%Y%m%d.md")
    set fn "$HOME/journal/j$now"
    if not test -f $fn
        echo -e "# $now\n\n" >$fn
    end
    vim -c "Goyo | norm G" $fn
end

