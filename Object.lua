--default Obj to provide common de/constructor for all OOP
--not intended to be used directly

local Object = {tag="object"};

function Object:new (obj)    --constructor
  obj = obj or {}; 
  setmetatable(obj, self);
  self.__index = self;
  return obj;
end

function Object:remove()  --deconstructor
    self = nil;
end

return Object