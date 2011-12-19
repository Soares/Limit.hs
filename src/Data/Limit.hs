module Data.Limit
    ( Limit(Bounded,Unbounded)
    , isBounded
    , isUnbounded
    , fromBounded
    , fromLimit
    ) where

import Control.Monad ( liftM2 )

data Limit a = Bounded a | Unbounded
    deriving (Eq, Read, Show)

instance Ord a => Ord (Limit a) where
    x <= y = fromLimit True $ liftM2 (<=) x y

instance Functor Limit where
    fmap _ Unbounded = Unbounded
    fmap f (Bounded a) = Bounded (f a)

instance Monad Limit where
    Unbounded >>= _ = Unbounded
    (Bounded x) >>= k = k x

    Unbounded >> _ = Unbounded
    (Bounded _) >> k = k

    return = Bounded
    fail _ = Unbounded

isBounded :: Limit a -> Bool
isBounded Unbounded = False
isBounded _ = True

isUnbounded :: Limit a -> Bool
isUnbounded = not . isBounded

fromBounded :: Limit a -> a
fromBounded Unbounded = error "Limit.fromBounded: Unbounded"
fromBounded (Bounded x) = x

fromLimit :: a -> Limit a -> a
fromLimit d Unbounded = d
fromLimit _ (Bounded x) = x
