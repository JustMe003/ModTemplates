**How to use**

Require the `Visuals.lua` file in the `Client_Visual` hook. Here is an example of how to use the library

Creates 2 half circles and 1 rectangle, all with a distinct color
```
require("Visuals.Visuals");

require("Visuals.Group");
require("Visuals.2D.Circle");
require("Visuals.2D.Rectangle");

---Client_Visual
---@param game GameClientHook
---@param order GameOrder # Currently only GameOrderEvent's are passed, but that might change
---@param visual Visual
function Client_Visual(game, order, visual)
    local c = Circle:Create(10, 50, 0.5):MoveX(50):SetColor("#FF0000");
    local r = Rectangle:Create(100):SetColor("#00FF00");

    local g = Group:Create(c, r, c:Copy():MoveX(-100):RevolveZ(180):SetColor("#0000FF"));
    
    visual.SetTriangles(g:GetTriangles())
        .SetAnchorPoint(400, 400)
        .SetVertices(g:GetVertices())
        .SetColors(g:GetColors());
end
```

Same objects, but now with a horizontal gradient applied to them
```
require("Visuals.Visuals");

require("Visuals.Group");
require("Visuals.2D.Circle");
require("Visuals.2D.Rectangle");

require("Visuals.Gradient.Horizontal");

---Client_Visual
---@param game GameClientHook
---@param order GameOrder # Currently only GameOrderEvent's are passed, but that might change
---@param visual Visual
function Client_Visual(game, order, visual)
    local c = Circle:Create(10, 50, 0.5):MoveX(50):SetColor("#FF0000");
    local r = Rectangle:Create(100):SetColor("#00FF00");

    local g = Group:Create(c, r, c:Copy():MoveX(-100):RevolveZ(180):SetColor("#0000FF"));

    GradientHorizontal:Create("#00FF00", "#0000FF"):Apply(g);
    
    visual.SetTriangles(g:GetTriangles())
        .SetAnchorPoint(400, 400)
        .SetVertices(g:GetVertices())
        .SetColors(g:GetColors());
end
```

Now with animations, moving, scaling and changing colors
```
require("Visuals.Visuals");

require("Visuals.Group");
require("Visuals.2D.Circle");
require("Visuals.2D.Rectangle");

require("Visuals.Gradient.Horizontal");

require("Visuals.Animation.AnimationBuilder");
require("Visuals.Animation.MoveAnimation");
require("Visuals.Animation.ScaleAnimation");
require("Visuals.Animation.ColorAnimation");

---Client_Visual
---@param game GameClientHook
---@param order GameOrder # Currently only GameOrderEvent's are passed, but that might change
---@param visual Visual
function Client_Visual(game, order, visual)
    local c = Circle:Create(25, 50, 0.5):MoveX(50);
    local r = Rectangle:Create(100);

    local g = Group:Create(c, r, c:Copy():MoveX(-100):RevolveZ(180));

    g:AddAnimation(
        ScaleAnimation:Create(2, 1):SetStart(0.5),
        MoveAnimation:Create(0, 200),
        ColorAnimation:Create(GradientHorizontal:Create("#00FF00", "#FF0000"):GetColors(g))
    ):SetAnimationsEnd(0.9);

    GradientHorizontal:Create("#00FF00", "#0000FF"):Apply(g);

    local frames = AnimationBuilder:Create(g):Build();
    
    visual.SetTriangles(g:GetTriangles())
        .SetAnchorPoint(400, 400)
        .SetDuration(4000)
        .SetFrames(frames)
end
```
