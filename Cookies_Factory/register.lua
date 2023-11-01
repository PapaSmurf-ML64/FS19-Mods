print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local cookiesHudFile = "Paletten/hud_fill_cookies.dds"
	local cookiesHudFileSmall = "Paletten/hud_fill_cookies_smal.dds"
	
    local cookiesFilType = g_fillTypeManager:addFillType("COOKIES", g_i18n:getText("cookies"), true, pricebeer * 2.2, 0.00045, math.rad(10), cookiesHudFile, cookiesHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hascookies=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hascookies=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "COOKIES" then
		hascookies=true
	end;
		
end;

		if hasmaize and not hascookies then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("COOKIES")
		local price = g_fillTypeManager:getFillTypeByName("COOKIES").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("COOKIES")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)