print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebutter = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local butterHudFile = "Paletten/hud_fill_butter.dds"
	local butterHudFileSmall = "Paletten/hud_fill_butter_small.dds"
	
    local butterFilType = g_fillTypeManager:addFillType("BUTTER", g_i18n:getText("butter"), true, pricebutter * 1.2, 0.00045, math.rad(10), butterHudFile, butterHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasbutter=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasbutter=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "BUTTER" then
		hasbutter=true
	end;
		
end;

		if hasmaize and not hasbutter then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("BUTTER")
		local price = g_fillTypeManager:getFillTypeByName("BUTTER").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("BUTTER")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)