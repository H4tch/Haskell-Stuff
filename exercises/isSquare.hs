
import Data.List

-- Checks if 4 points form a square, the second one is more efficient and is based purely on distances.
  
--isSquare p q r s = and [ and . take 4 $ map (== ds!!0) ds, ds !! 9 == ds !! 10, ds !! 10 == ds !! 11 ] where
--    ds = take 12 . drop 4 $ sort [dist p1 p2 | p1 <- [p,q,r,s], p2 <- [p,q,r,s] ]
--    dist (x1,y1) (x2,y2) = (x2-x1)^2 + (y2-y1)^2 

distance (x1,y1) (x2,y2) = sqrt( (x2-x1)^2 + (y2-y1)^2 )

isSquare p q r s = result where
    -- edgeDist is the minimum a distance possible within the set of points.
    edgeDist = (\(x:y:xs) -> if x == y then Just x else Nothing) . take 2 . sort $ map (distance p) [q,r,s]
    result = case edgeDist of
               Nothing -> False
               Just dist -> and [(min (distance q r) (distance q s)) == dist, (distance s r) == dist]

main = do 
--   putStrLn "Type in 4 points: "
   putStrLn . show $ distance (0,0) (2,2)
   let res1 = isSquare (0,0) (0,1) (1,1) (1,0)
       res2 = isSquare (0,1)(1,-2)(3,2)(4,-1) -- FAIL
   case res1 of
   -- case and [res1,res2,res3] of
       True -> putStrLn "Passed Test"
       False -> putStrLn "Failed Test"
   
   -- let result2 = isSquare ((x1,y1), (x2,y2), (x3,y3), (x4,y4))
   -- putStrLn $ "isSquare = " ++ (show result2)
   
   return ()



