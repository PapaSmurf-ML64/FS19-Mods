print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricecheese = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local cheeseHudFile = "Paletten/hud_fill_cheese.dds"
	local cheeseHudFileSmall = "Paletten/hud_fill_cheese_small.dds"
	
    local cheeseFilType = g_fillTypeManager:addFillType("CHEESE", g_i18n:getText("cheese"), true, pricecheese * 2.0, 0.00045, math.rad(10), cheeseHudFile, cheeseHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hascheese=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hascheese=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "CHEESE" then
		hascheese=true
	end;
		
end;

		if hasmaize and not hascheese then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("CHEESE")
		local price = g_fillTypeManager:getFillTypeByName("CHEESE").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("CHEESE")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)