import GHC.Base
import Data.Char

cipher :: String -> Int -> String
cipher "" _ = ""
cipher s 0 = s
cipher s n = cipher next (n-1) where
    next = map (\c -> if or [c == 'z',c=='Z'] then 'a' else succ $ toLower c ) s

main = do
   putStrLn "Enter in a message to encode:"
   message <- getLine
   putStrLn "Enter in a number to encode the string:"
   strCode <- getLine
   let code = read strCode :: Int
   putStrLn $ cipher message code

   return ()



