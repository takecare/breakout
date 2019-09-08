return {
    enable = function() 
        if arg[#arg] == '-debug' then 
            require('mobdebug').start() 
        end 
    end
}
