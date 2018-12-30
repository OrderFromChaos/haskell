-- inspect type of something
:t "Hello"
-- should output "Hello" :: [Char]

-- NOTE: lists can only accept a single type

-- concatenating sequential things happens with ++
[1..4] ++ [8..12]
-- should output [1,2,3,4,8,9,10,11,12]
-- efficiency note: this involves running through the first list, so be careful using this on long lists.
-- the instant efficient way is to stick stuff in front:
1 : [2..5]

-- get element out of list (NOT TUPLE)
"Steve Buscemi" !! 6
-- should return 'B'

-- chars are 's'ingle quotes, strings are "double quotes."
-- this is because strings are treated as char lists

-- like Python, comparators on lists are done in lexicographic order:
[3,2,1] > [2,10,100]
-- Should return True

-- slicing should be done as mentioned at this link:
-- http://learnyouahaskell.com/starting-out
-- search for "What else can you do with lists?"

-- INFINITE LISTS
-- [1...]
-- cycle [1,2,3,4]
-- to access em, use a structure like: take 12 (cycle [1,2,3])
-- replicate 3 10 is like [10]*3 in Python

-- list comprehensions
[ x*2 | x <- [1..10], x*2 >= 12]
-- action on the left, source is middle, constraints on right
-- this can be treated like a function as well, because lazy evaluation
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x] 
boomBangs [7..13]

-- TUPLES
-- apparently have no convenient slicing syntax (fst for first, snd for second, pattern matching for others)
-- are static like Python
-- can accept multiple types on their interior
-- PATTERN MATCHING
third :: (a,b,c) -> c
third (_,_,z) = z
-- first row says what the function actually is (so the internal typing parser is happy)
-- second row says what the function does

-- CLASS RESTRICTIONS
:t (==)
-- outputs (==) :: (Eq a) => a -> a -> Bool
-- this means that the function ==
-- takes in two a such that they are in the set (Eq a)
-- (where (Eq a) is defined as things that can be equality checked - basically non IO objects)
-- and outputs a Bool (True or False)
-- here, Eq a serves as a class restriction. If a cannot have equality checks done, then Haskell will complain (rightfully so)

-- oh, btw, != is /= in Haskell

-- this converts to a string
show 5.334
-- this turns into a thing from a string (as long as it is sufficiently unambiguous)
read "True" || False

-- this is sometimes required because Haskell sometimes doesn't like implicitly adding Int and Float when Int comes from a function
fromIntegral(length [1,2,3,4]) + 3.2

-- some more nice pattern matching
lucky :: (Integral a) => a -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"   

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

-- recursive functions are very natural in Haskell
length' :: (Num b) => [a] -> b  
length' [] = 0  
length' (_:xs) = 1 + length' xs

-- guards are basically just elif groups
bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
    | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"  
    | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise                 = "You're a whale, congratulations!"  
-- here, otherwise is literally the same thing as True

-- there's a type named "Ordering" and it's either GT, LT, or EQ

-- shorthand in guards exist
bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
    | bmi <= skinny = "You're underweight, you emo, you!"  
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"  
    | otherwise     = "You're a whale, congratulations!"  
    where bmi = weight / height ^ 2  
          (skinny, normal, fat) = (18.5, 25.0, 30.0)

-- if is allowed iff you have a then and else condition
[if 5 > 3 then "Woo" else "Boo", if 'a' > 'b' then "Foo" else "Bar"]

-- for conciseness and readability, let <bindings> in <expression> is available when defining functions as follows
cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea  
-- let is pretty much analogous to lambdas, but you can define multiple expressions (functions and variables) at once
-- if you need to define multiple things inline, use semicolons instead of line breaks
(let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)

-- case is a more familiar way to express the output classes of a function
head' :: [a] -> a  
head' [] = error "No head for empty lists!"  
head' (x:_) = x  

head' :: [a] -> a  
head' xs = case xs of [] -> error "No head for empty lists!"  
                      (x:_) -> x  

-- another useful example combining with where statements
describeList :: [a] -> String  
describeList xs = "The list is " ++ what xs  
    where what [] = "empty."  
          what [x] = "a singleton list."  
          what xs = "a longer list."
