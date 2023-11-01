print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local saltHudFile = "Paletten/hud_fill_salt.dds"
	local saltHudFileSmall = "Paletten/hud_fill_salt_smal.dds"
	
    local saltFilType = g_fillTypeManager:addFillType("SALT", g_i18n:getText("salt"), true, pricebeer * 0.5, 0.00045, math.rad(10), saltHudFile, saltHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hassalt=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hassalt=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "SALT" then
		hassalt=true
	end;
		
end;

		if hasmaize and not hassalt then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("SALT")
		local price = g_fillTypeManager:getFillTypeByName("SALT").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("SALT")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)