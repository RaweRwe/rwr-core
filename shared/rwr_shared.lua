RWRShared = {}

RWRShared.GetVersion = function()
	return Config.Version
end

RWRShared.GetConfigData = function(data)
	if C[data] then
		return C[data]
	else
		return "[".. data .."] isminde bir config verisi bulunamadı."
	end
end