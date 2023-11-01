print();

local modDirectory = g_currentModDirectory

function onLoadMapFinished(mission, node)
	local pricepaper = g_fillTypeManager:getFillTypeByName("MAIZE").pricePerLiter
	
	
	if node ~= 0 then
	
	local paperHudFile = "Paletten/hud_fill_paper.dds"
	local paperHudFileSmall = "Paletten/hud_fill_paper_small.dds"
	
    local paperFilType = g_fillTypeManager:addFillType("PAPER", g_i18n:getText("paper"), true, pricepaper * 0.6, 0.00045, math.rad(10), paperHudFile, paperHudFileSmall,modDirectory, nil, { 1, 1, 1 }, nil, false)
	
	g_currentMission.hud.fillLevelsDisplay:refreshFillTypes(g_fillTypeManager)
	end;
end;

function load(id, xmlFile, key,customEnvironment)
	local hasmaize =false
	local haspaper=false	
	
	
	local object=id
	if object == nil then
	else
	hasmaize =false
	haspaper=false
	
	
	for i,filltype in pairs(object.acceptedFillTypes) do
	local fillname=g_fillTypeManager.indexToName[i]
		if fillname == "MAIZE" then
		hasmaize=true
	end;
		if fillname == "PAPER" then
		haspaper=true
	end;
		
end;

		if hasmaize and not haspaper then
		local filltypen = g_fillTypeManager:getFillTypeIndexByName("PAPER")
		local price = g_fillTypeManager:getFillTypeByName("PAPER").pricePerLiter
			object:addAcceptedFillType(filltypen,price,true,false)
			object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("PAPER")]=object.priceMultipliers[ g_fillTypeManager:getFillTypeIndexByName("MAIZE")]
			object:initPricingDynamics()
		end;
		
	end;
end;

FSBaseMission.loadMapFinished = Utils.prependedFunction(FSBaseMission.loadMapFinished, onLoadMapFinished)
SellingStation.load = Utils.appendedFunction(SellingStation.load, load)