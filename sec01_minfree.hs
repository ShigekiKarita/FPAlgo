import qualified Data.Array as A
import qualified Data.Array.ST as AST

filterList :: Eq a => [a] -> [a] -> [a]
filterList us vs = filter (`notElem` vs) us

-- minfree0 xs: founds the minimum nat not in xs O(n^2)
minfree0 :: [Int] -> Int
minfree0 xs = head (filterList [0 ..] xs)

-- 配列中の True が先端から連続して何個あるかを返す
search :: A.Array Int Bool -> Int
search = length . takeWhile id . A.elems

-- 0 .. 
checkList0 :: [Int] -> A.Array Int Bool
checkList0 xs = A.accumArray (||) False (0, n)
               (zip (filter (<= n) xs) (repeat True))
               where n = length xs

countList :: [Int] -> A.Array Int Int
countList xs = A.accumArray (+) 0 (0, n) (zip xs (repeat 1))
               where n = maximum xs

checkList :: [Int] -> A.Array Int Bool
checkList xs = AST.runSTArray (do {
                  a <- AST.newArray (0, n) False;
                  sequence [AST.writeArray a x True | x <- xs, x <= n];
                  return a })                
               where n = length xs
              
                     
minfree :: [Int] -> Int
minfree = search . checkList

main = putStrLn "OK"
