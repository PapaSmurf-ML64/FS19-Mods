print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricepuree = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local pureeHudFile = "Paletten/hud_fill_puree.dds"
	local pureeHudFileSmall = "Paletten/hud_fill_puree_small.dds"
	
    local pureeFilType = g_fillTypeManager:addFillType("PUREE", g_i18n:getText("puree"), true, pricepuree * 2.1, 0.00045, math.rad(10), pureeHudFile, pureeHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local haspuree=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	haspuree=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "PUREE" then
		haspuree=true
	end;
		
end;

		if hasmaize and not haspuree then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("PUREE")
		local price = g_fillTypeManager:getFillTypeByName("PUREE").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("PUREE")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)