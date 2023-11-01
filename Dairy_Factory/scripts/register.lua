print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local priceicecream = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local icecreamHudFile = "Paletten/hud_fill_icecream.dds"
	local icecreamHudFileSmall = "Paletten/hud_fill_icecream_small.dds"
	
    local icecreamFilType = g_fillTypeManager:addFillType("ICECREAM", g_i18n:getText("icecream"), true, priceicecream * 1.8, 0.00045, math.rad(10), icecreamHudFile, icecreamHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasicecream=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasicecream=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "ICECREAM" then
		hasicecream=true
	end;
		
end;

		if hasmaize and not hasicecream then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("ICECREAM")
		local price = g_fillTypeManager:getFillTypeByName("ICECREAM").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("ICECREAM")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)