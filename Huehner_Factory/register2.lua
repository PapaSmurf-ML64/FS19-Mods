print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricechicken2 = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local chicken2HudFile = "hud_fill_chicken2.dds"
	local chicken2HudFileSmall = "hud_fill_chicken2_small.dds"
	
    local chicken2FilType = g_fillTypeManager:addFillType("CHICKEN2", g_i18n:getText("chicken2"), true, pricechicken2 * 0.1, 0.00045, math.rad(10), chicken2HudFile, chicken2HudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local haschicken2=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	haschicken2=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "CHICKEN2" then
		haschicken2=true
	end;
		
end;

		if hasmaize and not haschicken2 then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("CHICKEN2")
		local price = g_fillTypeManager:getFillTypeByName("CHICKEN2").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("CHICKEN2")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)