function [ flg ] = issameedge( lnode1,rnode1,lnode2,rnode2 )
flg = false;
if strcmp(lnode1,lnode2) && strcmp(rnode1,rnode2) 
    flg= true;
end

if strcmp(lnode1,rnode2) && strcmp(rnode1,lnode2) 
    flg= true;
end


end
