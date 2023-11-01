print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricehops = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local hopsHudFile = "Paletten/hud_fill_hops.dds"
	local hopsHudFileSmall = "Paletten/hud_fill_hops_smal.dds"
	
    local hopsFilType = g_fillTypeManager:addFillType("HOPS", g_i18n:getText("hops"), true, pricehops * 2.4, 0.00045, math.rad(10), hopsHudFile, hopsHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local hashops=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	hashops=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "HOPS" then
		hashops=true
	end;
		
end;

		if hasmaize and not hashops then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("HOPS")
		local price = g_fillTypeManager:getFillTypeByName("HOPS").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("HOPS")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)