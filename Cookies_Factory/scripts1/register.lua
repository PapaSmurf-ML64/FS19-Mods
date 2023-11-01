print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricedonuts = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local donutsHudFile = "Paletten/hud_fill_donuts.dds"
	local donutsHudFileSmall = "Paletten/hud_fill_donuts_small.dds"
	
    local donutsFilType = g_fillTypeManager:addFillType("DONUTS", g_i18n:getText("donuts"), true, pricedonuts * 2.0, 0.00045, math.rad(10), donutsHudFile, donutsHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasdonuts=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasdonuts=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "DONUTS" then
		hasdonuts=true
	end;
		
end;

		if hasmaize and not hasdonuts then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("DONUTS")
		local price = g_fillTypeManager:getFillTypeByName("DONUTS").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("DONUTS")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)