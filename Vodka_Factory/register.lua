print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricevodka = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local vodkaHudFile = "Paletten/hud_fill_vodka.dds"
	local vodkaHudFileSmall = "Paletten/hud_fill_vodka_small.dds"
	
    local vodkaFilType = g_fillTypeManager:addFillType("VODKA", g_i18n:getText("vodka"), true, pricevodka * 2.3, 0.00045, math.rad(10), vodkaHudFile, vodkaHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasvodka=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasvodka=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "VODKA" then
		hasvodka=true
	end;
		
end;

		if hasmaize and not hasvodka then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("VODKA")
		local price = g_fillTypeManager:getFillTypeByName("VODKA").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("VODKA")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)