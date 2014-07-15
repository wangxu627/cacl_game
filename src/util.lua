function PrintTable(o, f, b)
    if type(f) ~= "function" and f ~= nil then
        error("expected second argument %s is a function", tostring(f))
    end
    if type(b) ~= "boolean" and b ~= nil then
        error("expected third argument %s is a boolean", tostring(b))
    end
    if type(b) ~= "boolean" and b ~= nil then
        error("expected third argument %s is a boolean", tostring(b))
    end

    p = f or io.write
    b = b or false

    print(type(o))

    if type(o) == "number" or 
        type(o) == "function" or
        type(o) == "boolean" or
        type(o) == "nil" then
        p(tostring(o))
    elseif type(o) == "string" then
        p(string.format("%q",o))
    elseif type(o) == "table" then
        p("{/n")
        for k,v in pairs(o) do
            if b then
                p("[")
            end

            PrintTable(k, p, b)

            if b then
                p("]")
            end

            p(" = ")
            PrintTable(v, p, b)
            p(",/n")
        end
        p("}")

    end
end