print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local priceblackbeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local blackbeerHudFile = "Paletten/hud_fill_blackbeer.dds"
	local blackbeerHudFileSmall = "Paletten/hud_fill_blackbeer_small.dds"
	
    local blackbeerFilType = g_fillTypeManager:addFillType("BLACKBEER", g_i18n:getText("blackbeer"), true, priceblackbeer * 2.1, 0.00045, math.rad(10), blackbeerHudFile, blackbeerHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasblackbeer=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasblackbeer=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "BLACKBEER" then
		hasblackbeer=true
	end;
		
end;

		if hasmaize and not hasblackbeer then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("BLACKBEER")
		local price = g_fillTypeManager:getFillTypeByName("BLACKBEER").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("BLACKBEER")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)