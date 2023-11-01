print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricebeer = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local tissueHudFile = "Paletten/hud_fill_tissue.dds"
	local tissueHudFileSmall = "Paletten/hud_fill_tissue_smal.dds"
	
    local tissueFilType = g_fillTypeManager:addFillType("TISSUE", g_i18n:getText("tissue"), true, pricebeer * 4.5, 0.00045, math.rad(10), tissueHudFile, tissueHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hastissue=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hastissue=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "TISSUE" then
		hastissue=true
	end;
		
end;

		if hasmaize and not hastissue then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("TISSUE")
		local price = g_fillTypeManager:getFillTypeByName("TISSUE").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("TISSUE")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)