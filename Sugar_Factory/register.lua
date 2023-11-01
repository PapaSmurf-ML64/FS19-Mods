print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricesugar = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local sugarHudFile = "Paletten/hud_fill_sugar.dds"
	local sugarHudFileSmall = "Paletten/hud_fill_sugar_small.dds"
	
    local sugarFilType = g_fillTypeManager:addFillType("SUGAR", g_i18n:getText("sugar"), true, pricesugar * 2.5, 0.00045, math.rad(10), sugarHudFile, sugarHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hassugar=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hassugar=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "SUGAR" then
		hassugar=true
	end;
		
end;

		if hasmaize and not hassugar then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("SUGAR")
		local price = g_fillTypeManager:getFillTypeByName("SUGAR").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("SUGAR")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)