function planner -d "Create planner for today, copy todos"
   set prior (find ~/agenda/*.md | tail -n1)
   set curr "$HOME/agenda/"(date +"%Y%m%d.md")
   vim -o $curr $prior
end
    
