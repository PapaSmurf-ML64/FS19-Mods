print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local priceemptyPallets = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local emptyPalletsHudFile = "Paletten/hud_fill_emptyPallets.dds"
	local emptyPalletsHudFileSmall = "Paletten/hud_fill_emptyPallets_small.dds"
	
    local emptyPalletsFilType = g_fillTypeManager:addFillType("EMPTYPALLETS", g_i18n:getText("emptyPallets"), true, priceemptyPallets * 0.6, 0.00045, math.rad(10), emptyPalletsHudFile, emptyPalletsHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hasemptyPallets=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hasemptyPallets=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "EMPTYPALLETS" then
		hasemptyPallets=true
	end;
		
end;

		if hasmaize and not hasemptyPallets then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("EMPTYPALLETS")
		local price = g_fillTypeManager:getFillTypeByName("EMPTYPALLETS").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("EMPTYPALLETS")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)