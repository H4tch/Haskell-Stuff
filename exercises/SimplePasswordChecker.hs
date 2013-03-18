
import Data.List
import Data.Char

strong s = all (\x -> x == True) result where
  result = [length s >= 15, any (isLower) s, any (isNumber) s, any (isUpper) s ] 


main = do
  putStrLn . show $ strong "iadb12aaaaaaaaaa"

