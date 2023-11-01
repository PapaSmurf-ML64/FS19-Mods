print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local flourHudFile = "Paletten/hud_fill_flour.dds"
	local flourHudFileSmall = "Paletten/hud_fill_flour_smal.dds"
	
    local flourFilType = g_fillTypeManager:addFillType("FLOUR", g_i18n:getText("flour"), true, pricebeer * 1.0, 0.00045, math.rad(10), flourHudFile, flourHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasflour=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasflour=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "FLOUR" then
		hasflour=true
	end;
		
end;

		if hasmaize and not hasflour then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("FLOUR")
		local price = g_fillTypeManager:getFillTypeByName("FLOUR").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("FLOUR")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)