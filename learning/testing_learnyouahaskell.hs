initials :: String -> String -> String  
initials firstname lastname = let (f:_) = firstname in [f] ++ ". " ++ let (l:_) = lastname in [l] ++ "."

maximum' :: (Ord a) => [a] -> a -- has to be orderable to be able to run through it
maximum' [] = error "Maximum of empty list"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)
-- not sure why ' isn't a part of the function name here...

zip2 :: [a] -> [b] -> [(a,b)]
zip2 [] _ = []
zip2 _ [] = []
zip2 (x:xs) (y:ys) = (x,y):zip2 xs ys

elem2 :: (Eq a) => a -> [a] -> Bool
elem2 _ [] = False
elem2 a (x:xs)
    | a == x    = True
    | otherwise = elem2 a xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xend) = -- head is chosen here arbitrarily since it's easy to access. could be any random element
    let smaller_and_sort = quicksort [ a | a <- xend, a <= x]
        bigger_and_sort = quicksort [ a | a <- xend, a > x]
    in smaller_and_sort ++ [x] ++ bigger_and_sort

mulThree :: (Num a) => a -> a -> a -> a
mulThree x y z = x*y*z

-- take a preexisting function and apply it to everything in the list
map :: (a -> b) -> [a] -> [b]
map f x = [f(y) | y <- x]

addOne :: (Num a) => a -> a
addOne x = x + 1
