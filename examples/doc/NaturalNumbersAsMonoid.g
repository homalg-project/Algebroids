#! @BeginChunk NaturalNumbersAsMonoid

LoadPackage( "Algebroids" );

#! Create a right quiver $q$ with a single vertix $o$ and a single arrow $m$.

#! @Example
q := RightQuiver( "q(o)[m:o->o]" );
#! q(o)[m:o->o]
o := q.o;
#! (o)
m := q.m;
#! (m)
#! @EndExample

#! Create a monoid from $q$.

#! @Example
N := FreeCategory( q );
#! Monoid freely generated by the right quiver q(o)[m:o->o]
IsCommutative( N );
#! true
N.o;
#! <(o)>
N.m;
#! (o)-[(m)]->(o)
SetOfObjects( N );
#! [ <(o)> ]
SetOfGeneratingMorphisms( N );
#! [ (o)-[(m)]->(o) ]
SetOfGeneratingMorphisms( N, N.o, N.o );
#! [ (o)-[(m)]->(o) ]
ObjectInFpCategory( N, o ) = N.o;
#! true
N.o = o / N;
#! true
IdentityMorphism( N.o );
#! (o)-[(o)]->(o)
MorphismInFpCategory( N, m ) = N.m;
#! true
N.m = m / N;
#! true
#! @EndExample

#! We can compute in the algebroids.
#! For instance we can form compositions.

#! @Example
PreCompose( N.m, N.m );
#! (o)-[(m*m)]->(o)
unit := Unit( N );
#! Functor from Monoid freely generated by the right quiver *(1)[]
#! -> Monoid freely generated by the right quiver q(o)[m:o->o]
mul := Multiplication( N );
#! Functor from Monoid generated by the right quiver qxq(oo)[om:oo->oo,mo:oo->oo]
#! with relations -> Monoid freely generated by the right quiver q(o)[m:o->o]
#! @EndExample

#! @EndChunk
