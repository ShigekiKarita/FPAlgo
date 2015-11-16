module Sec22 where

import Data.Foldable (Foldable)

--- 余因子行列を再帰的に計算する方法 O(n!)
-- |
-- >>> det0 [[1, 2], [3, 4]] == 1 * 4 - 2 * 3
-- True
det0 :: Num b => [[b]] -> b
det0 [[x]] = x
det0 xss = foldr1 (-) (zipWith (*) col1 (map det0 (minors cols)))
  where col1 = map head xss
        cols = map tail xss

-- |
-- >>> minors [1,2,3,4]
-- [[2,3,4],[1,3,4],[1,2,4],[1,2,3]]
minors :: [t] -> [[t]]
minors [] = []
minors (x:xs) = xs : map (x:) (minors xs)

sgn :: (Num a1, Foldable t) => a1 -> t a -> a1
sgn x xss = if even (length xss) then x else -x

--- 有理数除算の使用
--  ガウスの消去法 : ある行を定数倍したものを別の行に加えても行列式の値は不変
--  によって上三角行列化した上で、その行列式は対角成分の積になることを利用
-- |
-- >>> det1 [[1, 2], [3, 4]] == 1 * 4 - 2 * 3
-- True
det1 :: (Fractional a, Eq a) => [[a]] -> a
det1 [[x]] = x
det1 xss = case break ((/= 0) . head) xss of
  (_, []) -> 0
  (yss, zs:zss) -> sgn x yss
    where x = head zs * det1 (reduce zs (yss ++ zss))



reduce :: Fractional c => [c] -> [[c]] -> [[c]]
reduce xs = map (reduce1 xs)
  where
    reduce1 (x:xs') (y:ys) = zipWith (\a b -> b - d * a) xs' ys
      where d = y / x
    reduce1 _ _ = error "empty list input: xs or ys"


--- 整数除算の使用
-- |
-- >>> det1 [[1, 2], [3, 4]] == 1 * 4 - 2 * 3
-- True
det2 :: [[Integer]] -> Integer
det2 [[x]] = x
det2 xss = case break ((/= 0) . head) xss of
  (_,[]) -> 0
  (yss,zs:zss) ->
    let x = det2 (condense (zs:yss ++ zss))
        d = head zs ^ (length xss - 2)
        y = x `div` d
    in if even (length yss) then y else -y

condense :: [[Integer]] -> [[Integer]]
condense = map (map det . pair . uncurry zip) . pair
  where pair (x:xs) = map ((,) x) xs
        pair _ = error "not implemented"
        det ((a,b),(c,d)) = a*d - b*c
