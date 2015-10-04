module Sec21 where

-- hylomorphism : unfold して fold する計算
-- deforestation : 展開と畳込みで発生する中間データ構造を計算から除去すること
-- call-tree : あえて中間データを使い hylomorphism を高速化する技法
-- nexus : call-tree において、節点を共有している木のこと、動的計画法などに代表される。高速

data Tree a = Leaf a | Node [Tree a]

fold :: (Either a [b] -> b) -> Tree a -> b
fold f t = case t of
  Leaf x  -> f $ Left x
  Node ts -> f . Right $ map (fold f) ts

unfold :: (b -> Either a [b]) -> b -> Tree a
unfold g x = case g x of
  Left y   -> Leaf y
  Right xs -> Node $ map (unfold g) xs

-- deforestation の例 : Leaf や Node はなくなる
hylo :: (Either a [b] -> b) -> (b -> Either a [b]) -> b -> b
hylo f g x = case g x of
  Left y -> f   (Left y)
  Right xs -> f (Right (map (hylo f g) xs))


-- Either でない ver
fold' :: (a -> b) -> ([b] -> b) -> Tree a -> b
fold' f _ (Leaf x) = f x
fold' f g (Node ts) = g $ map (fold' f g) ts

unfold' :: (b -> Bool) -> (b -> a) -> (b -> [b]) -> b -> Tree a
unfold' p v h x = if p x
  then Leaf $ v x
  else Node $ map (unfold' p v h) (h x)

hylo' :: (a -> b) ->
         ([b] -> b) ->
         (a -> Bool) ->
         (a -> [a]) ->
         a -> b
hylo' f g p h x = if p x
  then f x
  else g $ map (hylo' f g p h) (h x)
