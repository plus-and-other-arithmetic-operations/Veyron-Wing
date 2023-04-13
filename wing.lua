-- Wing Behaviour:
-- 0kmh - 100kmh - Nothing is up
-- 100kmh - 200kmh - Both wing and lip are active, 14º, 24º. Airbrake active
-- 200kmh - 400kmh - Transition to small rear lip, 3º. Airbrake active

local wingModes = {
  lowSpeed = { active = true, wingActive = false, lipActive = false, airBrakeActive = false },
  medSpeed = { active = false, wingActive = true, lipActive = true, airBrakeActive = true },
  highSpeed = { active = false, wingActive = false, lipActive = true, airBrakeActive = true },
}

local currentCondition = { 
  currentWingCondition = wingModes.lowSpeed.wingActive,
  currentLipCondition = wingModes.lowSpeed.lipActive,
  currentAirBrakeCondition = wingModes.lowSpeed.airBrakeActive
}

function WingBehaviour()
  if wingModes.lowSpeed.active then
    -- ac.log("case_1 - Nothing is up")
    currentCondition = {
      currentWingCondition = wingModes.lowSpeed.wingActive,
      currentLipCondition = wingModes.lowSpeed.lipActive,
      currentAirBrakeCondition = wingModes.lowSpeed.airBrakeActive
    }
  elseif wingModes.medSpeed.active then
    -- ac.log("case_2 - Both wing and lip are active, 14º, 24º. Airbrake active")
    currentCondition = {
      currentWingCondition = wingModes.medSpeed.wingActive,
      currentLipCondition = wingModes.medSpeed.lipActive,
      currentAirBrakeCondition = wingModes.medSpeed.airBrakeActive
    }
  elseif wingModes.highSpeed.active then
    -- ac.log("case_3 - Transition to small rear lip, 3º. Airbrake active)
    currentCondition = {
      currentWingCondition = wingModes.highSpeed.wingActive,
      currentLipCondition = wingModes.highSpeed.lipActive,
      currentAirBrakeCondition = wingModes.highSpeed.airBrakeActive
    }
  end
end

-- speed thresholds (for easier debugging)
local speed1 = 100
local speed2 = 200
function GetWingMode()
  if car.speedKmh < speed1 then
    wingModes.lowSpeed.active = true
    wingModes.medSpeed.active = false
    wingModes.highSpeed.active = false
  elseif car.speedKmh >= speed1 and car.speedKmh < speed2 then
    wingModes.lowSpeed.active = false
    wingModes.medSpeed.active = true
    wingModes.highSpeed.active = false
  elseif car.speedKmh >= speed2 then
    wingModes.lowSpeed.active = false
    wingModes.medSpeed.active = false
    wingModes.highSpeed.active = true
  end
end

local carNode = ac.findNodes('carRoot:0') -- getting car node
local wingAnim = ac.getFolder(ac.FolderID.ContentCars)     .. '/' .. ac.getCarID(0) .. '/animations/WING_UP.ksanim' -- loading animations
local lipAnim = ac.getFolder(ac.FolderID.ContentCars)      .. '/' .. ac.getCarID(0) .. '/animations/WING_TURN.ksanim' -- loading animations
local airBrakeAnim = ac.getFolder(ac.FolderID.ContentCars) .. '/' .. ac.getCarID(0) .. '/animations/WING_BRAKE.ksanim'  -- loading animations

-- used to control animations
local keyframes = {
  wing = 0,
  lip = 0,
  brake = 0,
}

local wingSpeedMult = 0.5 -- multiplier for wing animation speed
local lipSpeedMult = 0.4 -- multiplier for lip wing animation speed
local airBrakeSpeedMult = 0.7-- multiplier for brake animation speed

function WingAnimationBehaviour(dt)

  carNode:setAnimation(wingAnim, keyframes.wing)
  carNode:setAnimation(lipAnim, keyframes.lip)
  carNode:setAnimation(airBrakeAnim, keyframes.brake)

  if currentCondition.currentWingCondition then
    keyframes.wing = math.min(1, keyframes.wing + (wingSpeedMult*dt))
  else
    keyframes.wing = math.max(0, keyframes.wing - (wingSpeedMult*dt))
  end

  if currentCondition.currentLipCondition then
    keyframes.lip = math.min(1, keyframes.lip + (lipSpeedMult*dt))
  else
    keyframes.lip = math.max(0.1, keyframes.lip - (lipSpeedMult*dt))
  end

  if currentCondition.currentAirBrakeCondition and car.brake > 0 then
    keyframes.brake = math.min(1, keyframes.brake + (airBrakeSpeedMult*dt))
  else
    keyframes.brake = math.max(0, keyframes.brake - (airBrakeSpeedMult*dt))
  end
end

function script.update(dt)
  -- ac.log(stringify(keyframes))
  -- ac.log(stringify(currentCondition))
  -- ac.log(stringify(wingModes))
  GetWingMode()
  WingAnimationBehaviour(dt)
  WingBehaviour()
end