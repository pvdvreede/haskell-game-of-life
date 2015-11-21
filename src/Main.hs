module Main where

import Game

run :: Board -> IO ()
run b = putStrLn (show b) >> run (tick b)

main :: IO ()
main = run newBoard
