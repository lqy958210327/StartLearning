local MatrixAbility = require("Core/Common/FrameBattle/Ability/MatrixAbility")
local AbilityLogger = require("Core/Common/FrameBattle/Ability/AbilityLogger")

local strClassName = "TheMatrix"
local TheMatrix = Class(strClassName)

function TheMatrix:ctor(initInfo, loggerConfig)
    self.logger = AbilityLogger(initInfo.matrixInit.battleId, initInfo.round, loggerConfig)
    self.curFrame = 0
    self.frameLength = 50 --单位是 每一帧经过的毫秒
    self.frameOutput = {}
    self.frameInput = {}
    self.matrixAbility = MatrixAbility(self.logger, initInfo, self.frameLength, self.frameOutput, self.frameInput)
end

function TheMatrix:destroy()
    self.matrixAbility = nil
    self.frameOutput = nil
    if self.logger then
        self.logger:close()
        self.logger = nil
    end
end

function TheMatrix:receiveInputInfo(opcode, data, frame)
    local op = {frame = frame, opcode = opcode, data = data}
    table.insert(self.frameInput, op)
end

-- 让逻辑运行一帧，先设置好inputEvents，运行结果存放在outputEvents里面。
function TheMatrix:nextFrame()
    for index = #self.frameOutput, 1, -1 do
        self.frameOutput[index] = nil
    end
    self.curFrame = self.curFrame + 1
    self.matrixAbility:pcallNextFrame(self.curFrame)
end

function TheMatrix:getFrameOutput()
    return self.frameOutput
end

function TheMatrix:snapshotAttr()
    return self.matrixAbility:snapshotAttr()
end

return TheMatrix
