#! @Chapter Examples and Tests

#! @Section Adelman category theorem

#! @Example
LoadPackage( "Algebroids", false );
#! true
LoadPackage( "RingsForHomalg", false );
#! true

quiver := RightQuiver( "Q(9)[a:1->2,b:3->2]" );;
kQ := PathAlgebra( HomalgFieldOfRationals(), quiver );;
Aoid := Algebroid( kQ );;
mm := SetOfGeneratingMorphisms( Aoid );;
CapCategorySwitchLogicOff( Aoid );;
Acat := AdditiveClosure( Aoid );;
a := AsAdditiveClosureMorphism( mm[1] );;
b := AsAdditiveClosureMorphism( mm[2] );;
a := AsAdelmanCategoryMorphism( a );;
b := AsAdelmanCategoryMorphism( b );;
pi1 := ProjectionInFactorOfFiberProduct( [ a, b ], 1 );;
pi2 := ProjectionInFactorOfFiberProduct( [ a, b ], 1 );;
c := CokernelColift( pi1, PreCompose( a, CokernelProjection( b ) ) );;
IsMonomorphism( c );
#! true
#! @EndExample
