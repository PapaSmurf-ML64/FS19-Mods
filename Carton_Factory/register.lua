print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricecarton = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local cartonHudFile = "Paletten/hud_fill_carton.dds"
	local cartonHudFileSmall = "Paletten/hud_fill_carton_small.dds"
	
    local cartonFilType = g_fillTypeManager:addFillType("CARTON", g_i18n:getText("carton"), true, pricecarton * 0.6, 0.00045, math.rad(10), cartonHudFile, cartonHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hascarton=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hascarton=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "CARTON" then
		hascarton=true
	end;
		
end;

		if hasmaize and not hascarton then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("CARTON")
		local price = g_fillTypeManager:getFillTypeByName("CARTON").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("CARTON")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)