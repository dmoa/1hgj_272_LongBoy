-- circle circle collision
function CC(x, y, r, x2, y2, r2)
    return ((x-x2)^2 + (y-y2)^2)^0.5 < r + r2
end