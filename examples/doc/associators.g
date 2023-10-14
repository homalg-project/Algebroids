#! @BeginChunk associators

LoadPackage( "Algebroids" );

#! @Example
q := RightQuiver( "q(1)[t:1->1]" );
#! q(1)[t:1->1]
Q := HomalgFieldOfRationals( );
#! Q
Qq := PathAlgebra( Q, q );
#! Q * q
B := Algebroid( Qq );
#! Algebra( Q, FreeCategory( RightQuiver( "q(1)[t:1->1]" ) ) )

ass_ltr := AssociatorLeftToRightWithGivenTensorProductsAsFunctor(
                   (B*B)*B, B, B, B, B*(B*B) );;

ass_rtl := AssociatorRightToLeftWithGivenTensorProductsAsFunctor(
                   B*(B*B), B, B, B, (B*B)*B );;

Source(ass_ltr) = Target(ass_rtl);
#! true
Target(ass_ltr) = Source(ass_rtl);
#! true

# Consider B as an object in the category of algebroids over Q
BB := CategoryOfAlgebroidsObject(B);;
BB2 := TensorProductOnObjects(BB, BB);;
BB0 := TensorUnit( CapCategory( BB ) );;

ass_ltr_as_morphism := AssociatorLeftToRight(BB,BB,BB);;
ass_rtl_as_morphism := AssociatorRightToLeft(BB,BB,BB);;

IsCongruentForMorphisms(
        PreCompose( ass_ltr_as_morphism, ass_rtl_as_morphism ),
        IdentityMorphism( Source( ass_ltr_as_morphism ) ) );
#! true
IsCongruentForMorphisms(
        PreCompose( ass_rtl_as_morphism, ass_ltr_as_morphism ),
        IdentityMorphism( Source( ass_rtl_as_morphism ) ) );
#! true

#! @EndExample
#! @EndChunk
