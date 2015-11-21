module Game where

import qualified Data.Matrix as M

data Cell = Cell State Position

instance Show Cell where
    show (Cell Dead _) = "x"
    show (Cell Alive _) = "o"

type Me = Cell
type Neighbour = Cell
type Position = (Int, Int)
data State = Dead | Alive
type Board = M.Matrix Cell
type MeWithNeighbours = M.Matrix Cell
type Neighbours = [Neighbour]

newBoard :: Board
newBoard = M.matrix 20 20 $ \(i,j) -> if (i + j) `mod` 3 == 0
                                        then Cell Alive (i,j)
                                        else Cell Dead (i,j)

tick :: Board -> Board
tick o = M.fromList 20 20 $ map (runConversion o) $ M.toList o

runConversion :: Board -> Cell -> Cell
runConversion b m = convertMe (pullMeWithNeighbours b m) m

convertMe :: MeWithNeighbours -> Me -> Me
convertMe n (Cell Dead x)  | shouldLive $ matrixToListWithoutMe n = Cell Alive x
                           | otherwise = Cell Dead x
convertMe n (Cell Alive x) | shouldDie $ matrixToListWithoutMe n = Cell Dead x
                           | otherwise = Cell Alive x

pullMeWithNeighbours :: Board -> Me -> MeWithNeighbours
pullMeWithNeighbours b (Cell _ (x,y)) = M.submatrix startRowFromMe endRowFromMe startColFromMe endColFromMe b
    where startRowFromMe = x - 1
          endRowFromMe = x + 1
          startColFromMe = y - 1
          endColFromMe = y + 1

matrixToListWithoutMe :: MeWithNeighbours -> Neighbours
matrixToListWithoutMe x = reJoin $ splitAt 4 $ M.toList x
    where reJoin (h,y) = h ++ y

shouldDie :: Neighbours -> Bool
shouldDie x = length (filterAlive x) < 2 || length (filterAlive x) > 3

shouldLive :: Neighbours -> Bool
shouldLive x = length (filterAlive x) == 3

filterAlive :: Neighbours -> Neighbours
filterAlive = filter isAlive

isDead :: Cell -> Bool
isDead (Cell Dead _) = True
isDead _ = False

isAlive :: Cell -> Bool
isAlive x = not $ isDead x

