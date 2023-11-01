print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local colzaoilHudFile = "Paletten/hud_fill_colzaoil.dds"
	local colzaoilHudFileSmall = "Paletten/hud_fill_colzaoil_smal.dds"
	
    local colzaoilFilType = g_fillTypeManager:addFillType("COLZAOIL", g_i18n:getText("colzaoil"), true, pricebeer * 1.0, 0.00045, math.rad(10), colzaoilHudFile, colzaoilHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hascolzaoil=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hascolzaoil=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "COLZAOIL" then
		hascolzaoil=true
	end;
		
end;

		if hasmaize and not hascolzaoil then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("COLZAOIL")
		local price = g_fillTypeManager:getFillTypeByName("COLZAOIL").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("COLZAOIL")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)