print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local beerHudFile = "Paletten/hud_fill_beer.dds"
	local beerHudFileSmall = "Paletten/hud_fill_beer_small.dds"
	
    local beerFilType = g_fillTypeManager:addFillType("BEER", g_i18n:getText("beer"), true, pricebeer * 2.1, 0.00045, math.rad(10), beerHudFile, beerHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasbeer=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasbeer=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "BEER" then
		hasbeer=true
	end;
		
end;

		if hasmaize and not hasbeer then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("BEER")
		local price = g_fillTypeManager:getFillTypeByName("BEER").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("BEER")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)