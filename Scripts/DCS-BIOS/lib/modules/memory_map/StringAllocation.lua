module("StringAllocation", package.seeall)

--- @class StringAllocation A class containing a set of memory allocations which make up a string
--- @field address integer the memory address
--- @field maxLength integer the maximum length of the string
--- @field characterAllocations MemoryAllocation[] the memory allocations which make up the string
local StringAllocation = {}

--- Constructs a new StringAllocation
--- @param characterAllocations MemoryAllocation[] the memory allocations which make up the string
--- @param max_length integer the maximum length of the string
--- @return StringAllocation
function StringAllocation:new(characterAllocations, max_length)
	--- @type StringAllocation
	local o = {
		address = characterAllocations[1].address,
		maxLength = max_length,
		characterAllocations = characterAllocations,
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Updates the constituent memory allocations to store the provided string
--- @param value string the new value to store
function StringAllocation:setValue(value)
	local i = 1

	if value == nil then
		Logg:log(string.format("Util.lua: item is sending a nil value"))
		return
	end

	while i <= value:len() and i <= #self.characterAllocations do
		self.characterAllocations[i]:setValue(value:byte(i))
		i = i + 1
	end
	while i <= #self.characterAllocations do
		self.characterAllocations[i]:setValue(32) -- space
		i = i + 1
	end
end

return StringAllocation
