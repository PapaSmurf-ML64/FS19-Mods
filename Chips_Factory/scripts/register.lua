print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricefries = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local friesHudFile = "Paletten/hud_fill_fries.dds"
	local friesHudFileSmall = "Paletten/hud_fill_fries_small.dds"
	
    local friesFilType = g_fillTypeManager:addFillType("FRIES", g_i18n:getText("fries"), true, pricefries * 2.0, 0.00045, math.rad(10), friesHudFile, friesHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasfries=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasfries=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "FRIES" then
		hasfries=true
	end;
		
end;

		if hasmaize and not hasfries then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("FRIES")
		local price = g_fillTypeManager:getFillTypeByName("FRIES").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("FRIES")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)