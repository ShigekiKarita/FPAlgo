module Spec23 where

type Point = [Int]
type Simplex = ([Point], Int)

dimension :: Point -> Int
dimension ps = length ps - 1

orientation = fromIntegral . signum
