print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricesmokedham = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local smokedhamHudFile = "Paletten/hud_fill_smokedham.dds"
	local smokedhamHudFileSmall = "Paletten/hud_fill_smokedham_smal.dds"
	
    local smokedhamFilType = g_fillTypeManager:addFillType("SMOKEDHAM", g_i18n:getText("smokedham"), true, pricesmokedham * 2.3, 0.00045, math.rad(10), smokedhamHudFile, smokedhamHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hassmokedham=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hassmokedham=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "SMOKEDHAM" then
		hassmokedham=true
	end;
		
end;

		if hasmaize and not hassmokedham then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("SMOKEDHAM")
		local price = g_fillTypeManager:getFillTypeByName("SMOKEDHAM").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("SMOKEDHAM")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)