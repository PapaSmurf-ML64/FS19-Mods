print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricejambon = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local jambonHudFile = "Paletten/hud_fill_jambon.dds"
	local jambonHudFileSmall = "Paletten/hud_fill_jambon_smal.dds"
	
    local jambonFilType = g_fillTypeManager:addFillType("JAMBON", g_i18n:getText("jambon"), true, pricejambon * 1.5, 0.00045, math.rad(10), jambonHudFile, jambonHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasjambon=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasjambon=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "JAMBON" then
		hasjambon=true
	end;
		
end;

		if hasmaize and not hasjambon then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("JAMBON")
		local price = g_fillTypeManager:getFillTypeByName("JAMBON").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("JAMBON")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)