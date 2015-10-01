module Sec22 where

-- |
-- >>> det0 [[1, 2], [3, 4]] == 1 * 4 - 2 * 3
-- True
det0 :: Num b => [[b]] -> b
det0 [[x]] = x
det0 xss = foldr1 (-) (zipWith (*) col1 (map det0 (minors cols)))
  where col1 = map head xss
        cols = map tail xss

minors :: [t] -> [[t]]
minors [] = []
minors (x:xs) = xs : map (x:) (minors xs)


-- |
-- >>> det1 [[1, 2], [3, 4]] == 1 * 4 - 2 * 3
-- True
det1 :: (Fractional a, Eq a) => [[a]] -> a
det1 [[x]] = x
det1 xss = case break ((/= 0) . head) xss of
  (_, []) -> 0
  (yss, zs:zss) ->
    let x = head zs * det1 (reduce zs (yss ++ zss)) in
    if even (length yss) then x else -x
    where
      reduce xs = map (reduce1 xs)
      reduce1 (x:xs) (y:ys) = zipWith (\a b -> b - d * a) xs ys
        where d = y / x
      reduce1 _ _ = error "empty list input: xs or ys"
