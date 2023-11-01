print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricechips = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local chipsHudFile = "Paletten/hud_fill_chips.dds"
	local chipsHudFileSmall = "Paletten/hud_fill_chips_small.dds"
	
    local chipsFilType = g_fillTypeManager:addFillType("CHIPS", g_i18n:getText("chips"), true, pricechips * 3.5, 0.00045, math.rad(10), chipsHudFile, chipsHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local haschips=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	haschips=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "CHIPS" then
		haschips=true
	end;
		
end;

		if hasmaize and not haschips then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("CHIPS")
		local price = g_fillTypeManager:getFillTypeByName("CHIPS").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("CHIPS")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)