import Data.Char
import Data.String
import System.Random
import Control.Monad.IO.Class

vowels = "aeiouy"

getVowel (s, gen) = (s ++ (vowels !! index), gen') where (index, gen')= randomR (0,5) gen

getConsonant (s, gen) =
  let c = ['b'..'z'] !! index
  in if [c] `elem` vowels
    then getConsonant (s, gen')
    else (s ++ [c], gen')
  where (index, gen') = randomR (0,24) gen

genVowelPart (s, gen) =
  let (n, gen') = randomR ((1::Int),4) gen
      (s', gen'') = getVowel(s, gen')
  in if n == (1::Int) then (s', gen'') else getConsonant(s', gen'')
  
genConsonantPart (s, gen) =
  let (n, gen') = randomR ((1::Int),4) gen
      (s', gen'') = getConsonant(s, gen')
  in if n == (1::Int) then (s', gen'') else getConsonant(s', gen'')

genName (s, gen) =
    let (rand,gen') = randomR (1 :: Int ,2) gen
        (name, gen'') = case rand of
           1 -> genVowelPart . genConsonantPart . genVowelPart . genConsonantPart $ genVowelPart ("", gen')
           _ -> genConsonantPart . genVowelPart . genConsonantPart . genVowelPart $ genConsonantPart ("", gen')
    in (name, gen'')

generate gen = do
    (name, gen') <- generate ("", gen)
    putStrLn $ (name) ++ "    " ++ (reverse name)
    return gen'

main = do
    (rand,gen) <- randomR (1 :: Int ,2) `fmap` getStdGen
    generate gen


