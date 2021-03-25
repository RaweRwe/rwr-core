Locales = {}

function _U(str, ...)  -- Translate string

	if Locales[Config.Locale] ~= nil then

		if Locales[Config.Locale][str] ~= nil then
			return string.format(Locales[Config.Locale][str], ...)
		else
			return '[' .. Config.Locale .. '][' .. str .. '] bulunamadı!'
		end

	else
		return '[' .. Config.Locale .. '] böyle bir lokal dosyası yok!'
	end

end