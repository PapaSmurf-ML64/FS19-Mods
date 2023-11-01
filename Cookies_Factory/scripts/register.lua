print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebread = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local breadHudFile = "Paletten/hud_fill_bread.dds"
	local breadHudFileSmall = "Paletten/hud_fill_bread_small.dds"
	
    local breadFilType = g_fillTypeManager:addFillType("BREAD", g_i18n:getText("bread"), true, pricebread * 2.0, 0.00045, math.rad(10), breadHudFile, breadHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasbread=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasbread=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "BREAD" then
		hasbread=true
	end;
		
end;

		if hasmaize and not hasbread then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("BREAD")
		local price = g_fillTypeManager:getFillTypeByName("BREAD").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("BREAD")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)