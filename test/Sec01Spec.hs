module Sec01Spec where
import Sec01

import Test.Hspec
import Test.Hspec.QuickCheck (prop)
-- import Test.QuickCheck () -- hiding ((.&.))

spec :: Spec
spec = do
  describe "+ qc" $ do
    prop "i + i = i * 2" $ \i ->
      (i :: Int) + i == i * 2
  describe "minfree" $ do
    it "founds the minimum nat not in a list" $
      minfree0 ([0 .. 512] ++ [514 .. 1000] :: [Int]) `shouldBe` 513
