import Graphics.Gloss.Geometry.Line
main = do
  putStrLn $  show $ intersectSegLine (0,0) (1,1) (-1,1) (1,0)
