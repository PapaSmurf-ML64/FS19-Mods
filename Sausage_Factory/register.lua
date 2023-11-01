print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricesausage = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local sausageHudFile = "Paletten/hud_fill_sausage.dds"
	local sausageHudFileSmall = "Paletten/hud_fill_sausage_smal.dds"
	
    local sausageFilType = g_fillTypeManager:addFillType("SAUSAGE", g_i18n:getText("sausage"), true, pricesausage * 1.2, 0.00045, math.rad(10), sausageHudFile, sausageHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hassausage=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hassausage=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "SAUSAGE" then
		hassausage=true
	end;
		
end;

		if hasmaize and not hassausage then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("SAUSAGE")
		local price = g_fillTypeManager:getFillTypeByName("SAUSAGE").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("SAUSAGE")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)