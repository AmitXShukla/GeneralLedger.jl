"""
    fixColNames(str)
Call this function to update column names
remove blank spaces, dollar sign, or Hash chars
make all columns uppercase and replace hyphen with underscore
"""
function fixColNames(str)
	return uppercase(reduce(replace, ["-" => "_"," " => "_", "\$" => "_","#" => "_","%" => "_","(" => "_",")" => "_"], init=str))
end