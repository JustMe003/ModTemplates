require("Visuals.Math.Vector4D");

---@class Matrix4D
Matrix4D = {};
Matrix4D.__index = Matrix4D;
Matrix4D.__tostring = function(t)
        return string.format("{ %.2f, %.2f, %.2f, %.2f\n %.2f, %.2f, %.2f, %.2f\n %.2f, %.2f, %.2f, %.2f\n %.2f, %.2f, %.2f, %.2f }", table.unpack(t));
    end;

setmetatable(Matrix4D, {
    __call = function(_, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p)
        return setmetatable({
            a or 1, b or 0, c or 0, d or 0,
            e or 0, f or 1, g or 0, h or 0,
            i or 0, j or 0, k or 1, l or 0,
            m or 0, n or 0, o or 0, p or 1
        }, Matrix4D);
    end
});

---Multiplies the matrix with a number
---@param n number
---@return self
function Matrix4D:MultNumber(n)
    for i, v in ipairs(self) do
        self[i] = v * n;
    end
    return self;
end

---Multiplies a matrix by a vector
---@param v Vector4D
---@return Vector4D
function Matrix4D:MultVector(v)
    return Vector4D(
        self[1] * v[1] + self[2] * v[2] + self[3] * v[3] + self[4] * v[4],
        self[5] * v[1] + self[6] * v[2] + self[7] * v[3] + self[8] * v[4],
        self[9] * v[1] + self[10] * v[2] + self[11] * v[3] + self[12] * v[4],
        self[13] * v[1] + self[14] * v[2] + self[15] * v[3] + self[16] * v[4]
    );
end

---Multiplies a matrix by another matrix
---@param mat Matrix4D
---@return self
function Matrix4D:MultMatrix(mat)
    local new = Matrix4D(
        self[1]*mat[1] + self[2]*mat[5] + self[3]*mat[9] + self[4]*mat[13],
        self[1]*mat[2] + self[2]*mat[6] + self[3]*mat[10] + self[4]*mat[14],
        self[1]*mat[3] + self[2]*mat[7] + self[3]*mat[11] + self[4]*mat[15],
        self[1]*mat[4] + self[2]*mat[8] + self[3]*mat[12] + self[4]*mat[16],
        
        self[5]*mat[1] + self[6]*mat[5] + self[7]*mat[9] + self[8]*mat[13],
        self[5]*mat[2] + self[6]*mat[6] + self[7]*mat[10] + self[8]*mat[14],
        self[5]*mat[3] + self[6]*mat[7] + self[7]*mat[11] + self[8]*mat[15],
        self[5]*mat[4] + self[6]*mat[8] + self[7]*mat[12] + self[8]*mat[16],
        
        self[9]*mat[1] + self[10]*mat[5] + self[11]*mat[9] + self[12]*mat[13],
        self[9]*mat[2] + self[10]*mat[6] + self[11]*mat[10] + self[12]*mat[14],
        self[9]*mat[3] + self[10]*mat[7] + self[11]*mat[11] + self[12]*mat[15],
        self[9]*mat[4] + self[10]*mat[8] + self[11]*mat[12] + self[12]*mat[16],
        
        self[13]*mat[1] + self[14]*mat[5] + self[15]*mat[9] + self[16]*mat[13],
        self[13]*mat[2] + self[14]*mat[6] + self[15]*mat[10] + self[16]*mat[14],
        self[13]*mat[3] + self[14]*mat[7] + self[15]*mat[11] + self[16]*mat[15],
        self[13]*mat[4] + self[14]*mat[8] + self[15]*mat[12] + self[16]*mat[16]
    );

    for i, v in ipairs(new) do
        self[i] = v;
    end
    return self;
end

---Subtracts the passed the matrix from itself
---@param mat Matrix4D
---@return self
function Matrix4D:SubtractMatrix(mat)
    for i, v in ipairs(self) do
        self[i] = v - mat[i];
    end
    return self;
end

---Adds the passed matrix to itself
---@param mat Matrix4D
---@return Matrix4D
function Matrix4D:AddMatrix(mat)
    for i, v in ipairs(self) do
        self[i] = v + mat[i];
    end
    return self;
end

---Returns a copy of the matrix object
---@return Matrix4D # Copy of the matrix object
function Matrix4D:Copy()
    return Matrix4D(table.unpack(self));
end
