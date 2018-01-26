includes = []
excludes = [:skip]

# Uncomment the line below to enable focus mode
includes = [:focus | includes]; excludes = [:test]

ExUnit.start(include: includes, exclude: excludes)
