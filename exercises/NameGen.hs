import Data.Char
import Data.String
import System.Random
import Control.Monad.IO.Class

vowels = "aeiouy"

getVowel (s, gen) = (s ++ [vowels !! index], gen') where (index, gen')= randomR (0,5) gen

getConsonant (s, gen) =
  let c = ['b'..'z'] !! index
  in if c `elem` vowels
    then getConsonant (s, gen')
    else (s ++ [c], gen')
  where (index, gen') = randomR (0,24) gen

genVowelPart (s, gen) =
  let (n, gen') = randomR ((1::Int),8) gen
      (s', gen'') = getVowel(s, gen')
  in if n == (1::Int) then getVowel(s', gen'') else (s', gen'')


genConsonantPart (s, gen) =
  let (n, gen') = randomR ((1::Int),14) gen
      (s', gen'') = getConsonant(s, gen')
  in if n == (1::Int) then getConsonant(s', gen'') else (s', gen'')

genName (s, gen) =
    let (rand,gen') = randomR (1 :: Int ,2) gen
        (name, gen'') = case rand of
           1 -> genVowelPart . genConsonantPart . genVowelPart . genConsonantPart $ genVowelPart ("", gen')
           _ -> genConsonantPart . genVowelPart . genConsonantPart . genVowelPart $ genConsonantPart ("", gen')
    in (name, gen'')


main = do
    (rand,gen) <- randomR (1 :: Int ,2) `fmap` getStdGen
    let (name, _) = genName ("", gen)
    if (length name) < (8 :: Int)
    	then putStrLn $ (name) ++ "\t" ++ (reverse name)
    	else putStrLn $ (name) ++ " " ++ (reverse name)
    


