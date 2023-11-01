print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricelightbeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local lightbeerHudFile = "Paletten/hud_fill_lightbeer.dds"
	local lightbeerHudFileSmall = "Paletten/hud_fill_lightbeer_small.dds"
	
    local lightbeerFilType = g_fillTypeManager:addFillType("LIGHTBEER", g_i18n:getText("lightbeer"), true, pricelightbeer * 2.0, 0.00045, math.rad(10), lightbeerHudFile, lightbeerHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local haslightbeer=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	haslightbeer=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "LIGHTBEER" then
		haslightbeer=true
	end;
		
end;

		if hasmaize and not haslightbeer then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("LIGHTBEER")
		local price = g_fillTypeManager:getFillTypeByName("LIGHTBEER").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("LIGHTBEER")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)