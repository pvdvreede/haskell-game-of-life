module GameSpec where

import Test.Hspec
import Game

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "pullMeWithNeighbours" $ do
    it "it returns me and my neighbours" $ do
      pullMeWithNeighbours newBoard (Cell Alive (10,10)) `shouldBe` newBoard
