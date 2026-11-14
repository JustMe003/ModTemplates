require("Visuals.Animation.Animation");
require("Visuals.Group");

---@param _ any
---@param ... VisualObject
---@return AnimationBuilder
local function create(_, ...)
    if #{...} == 1 then
        return setmetatable({Object = ...}, AnimationBuilder);
    else
        return setmetatable({Object = Group(...)}, AnimationBuilder);
    end    
end

---@class AnimationBuilder
---@field Object Group
AnimationBuilder = {};
AnimationBuilder.__index = AnimationBuilder;

setmetatable(AnimationBuilder, {
    __call = function(_, ...)
        return create(_, ...);
    end
});

---Creates an AnimationBuilder
---@param ... VisualObject
---@return AnimationBuilder
function AnimationBuilder:Create(...)
    return create(self, ...);
end

---@param t number
---@param v VertexArray
---@param c ColorArray
---@return VisualFrame
local function createFrame(t, v, c)
    return {
        t = t;
        Vertices = v;
        Colors = c;
    }
end

---@param vs VertexArray
---@return Vector4D[]
local function createVect4Array(vs)
    local l = {};
    for _, v in ipairs(vs) do
        table.insert(l, Vector4D:FromVertex(v));
    end
    return l;
end

---@param vec4s Vector4D[]
---@return VertexArray
local function createVerticeArray(vec4s)
    local l = VertexArray();
    for _, v in ipairs(vec4s) do
        l:Add(Vertex(v[1], v[2], v[3]));
    end
    return l;
end

---@class ObjectVertexData
---@field Object VisualObject
---@field Start integer
---@field End integer
---@field ID integer
---@field Children ObjectVertexData[]
---@field StartColors RGBAObject[]?

---Returns all objects in an array, and the complete vertex list
---@param builder AnimationBuilder
---@return ObjectVertexData[], Vertex[]
local function init(builder)
    local objects = {};
    local vertices = {};
    local data = {};
    
    local searchObject;
    ---@param obj VisualObject
    searchObject = function(obj)
        if not ValueInTable(objects, obj) then
            local animationData = {
                Object = obj;
                ID = obj.ID;
                Children = {};
                Start = #vertices + 1;
            }
            table.insert(objects, obj);
            if IsChildClass(obj, Group) then
                animationData.End = 0;
                for _, o in ipairs(obj.Objects) do
                    table.insert(animationData.Children, searchObject(o));
                end
            else
                animationData.End = #vertices + #obj.Vertices;
                for _, v in ipairs(obj:GetVertices()) do
                    table.insert(vertices, v);
                end
            end
            obj:ApplyTransformation();
            table.insert(data, animationData);
            return animationData;
        else
            for _, d in ipairs(data) do
                if obj.ID == d.ID then
                    return d;
                end
            end
        end 
    end

    searchObject(builder.Object);
    return data, vertices;
end

---@param data ObjectVertexData
---@param animation ColorAnimation
---@param t number
local function applyColorAnimation(data, animation, t, colors)
    local p = (t - animation.Start) / (animation.End - animation.Start);
    local obj = data.Object;
    if data.StartColors == nil then
        data.StartColors = {};
        for _, c in ipairs(obj:GetColors()) do
            table.insert(data.StartColors, RGBA(c[1], c[2], c[3], c[4]));
        end
    end
    
    local colorIndex = 1;
    ---@param o ObjectVertexData
    ---@param offset number?
    local colorObject = function(o, offset)
        offset = offset or 0;
        if IsClass(animation.Colors, RGBA) then
            local diff = o.End - o.Start + 1 + offset;
            for i = 1 + offset, diff do
                local c = RGBA(
                    data.StartColors[i][1] * (1 - p) + animation.Colors[1] * p,
                    data.StartColors[i][2] * (1 - p) + animation.Colors[2] * p,
                    data.StartColors[i][3] * (1 - p) + animation.Colors[3] * p,
                    data.StartColors[i][4] * (1 - p) + animation.Colors[4] * p
                );
                local index = i + o.Start - 1 - offset
                colors[index][1] = c[1];
                colors[index][2] = c[2];
                colors[index][3] = c[3];
                colors[index][4] = c[4];
            end
        else
            for i = 1, o.End - o.Start + 1 do
                local c = RGBA(
                    data.StartColors[i][1] * (1 - p) + animation.Colors[colorIndex][1] * p,
                    data.StartColors[i][2] * (1 - p) + animation.Colors[colorIndex][2] * p,
                    data.StartColors[i][3] * (1 - p) + animation.Colors[colorIndex][3] * p,
                    data.StartColors[i][4] * (1 - p) + animation.Colors[colorIndex][4] * p
                );
                local index = i + o.Start - 1;
                colors[index][1] = c[1];
                colors[index][2] = c[2];
                colors[index][3] = c[3];
                colors[index][4] = c[4];
                colorIndex = colorIndex + 1;
            end
        end
    end
    if IsChildClass(obj, Group) then
        local offset = 0;
        for _, child in pairs(data.Children) do
            if not IsChildClass(child, Group) then
                colorObject(child, offset);
                offset = offset + child.End - child.Start + 1;
            end
        end
    else
        colorObject(data);
    end

end

---@class AnimationData
---@field Animation Animation
---@field Data ObjectVertexData

---Builds the animation
---@return VisualFrame[]
function AnimationBuilder:Build()
    self.Animations = {};
    local objects, vertices = init(self);

    ---@type AnimationData[]
    local currentAnimations;
    local updateAnimations = function(t)
        currentAnimations = {};
        for _, data in ipairs(objects) do
            for _, animation in ipairs(data.Object.Animations) do
                if animation.Start <= t and animation.End >= t then
                    table.insert(currentAnimations, {
                        Animation = animation;
                        Data = data;
                    });
                end
            end
        end
    end

    local time = 0;
    local getNextStop = function()
        local new = 2;
        for _, data in ipairs(objects) do
            for _, animation in ipairs(data.Object.Animations) do
                if animation.Start > time then
                    new = math.min(new, animation.Start);
                elseif animation.End > time then
                    new = math.min(new, animation.End);
                end
            end
        end
        time = new;
    end
    
    local oldTime = 0;
    local frames = {};
    local colors;
    repeat
        -- print(time);
        updateAnimations(time);
        local vec4s = createVect4Array(vertices);
        colors = (colors or self.Object.Colors):Copy();
        local timeDelta = time - oldTime;
        for _, animationData in ipairs(currentAnimations) do
            if IsChildClass(animationData.Animation, ColorAnimation) then
                applyColorAnimation(animationData.Data, animationData.Animation --[[@as ColorAnimation]], time, colors);
            else
                local animation = animationData.Animation;
                local p = timeDelta / (animation.End - animation.Start);
                local transMat = animation:Interpolate(p);
                for i = animationData.Data.Start, animationData.Data.End do
                    vec4s[i] = transMat:MultVector(vec4s[i]);
                end
                for _, child in ipairs(animationData.Data.Children) do
                    for i = child.Start, child.End do
                        vec4s[i] = transMat:MultVector(vec4s[i]);
                    end
                end
            end
        end
        vertices = createVerticeArray(vec4s);
        table.insert(frames, createFrame(time, vertices, colors or self.Object.Colors));
        oldTime = time;
        getNextStop();
    until time > 1;

    return frames;
end