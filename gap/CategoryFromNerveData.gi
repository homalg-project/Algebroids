# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Implementations
#

##
InstallMethod( CategoryFromNerveData,
        "for a string and a list",
        [ IsStringRep, IsList, IsList, IsList ],
        
  function( name, nerve_data, indices_of_generating_morphisms, labels )
    local C, C0, V, s, t;
    
    C := CreateCapCategory( name,
                 IsCategoryFromNerveData,
                 IsObjectInCategoryFromNerveData,
                 IsMorphismInCategoryFromNerveData,
                 IsCapCategoryTwoCell );
    
    C0 := nerve_data[1][1];
    
    V := CapCategory( C0 );
    
    s := nerve_data[2][2];
    t := nerve_data[2][3];
    
    SetIsFinite( C, true );
    SetIsEquippedWithHomomorphismStructure( C, true );
    SetRangeCategoryOfHomomorphismStructure( C, V );
    SetNerveData( C, nerve_data );
    SetDefiningPairOfUnderlyingQuiver( C, Pair( Length( C0 ), List( indices_of_generating_morphisms, i -> Pair( s( i ), t( i ) ) ) ) );
    
    C!.labels := labels;
    C!.indices_of_generating_morphisms := indices_of_generating_morphisms;
    
    C!.category_as_first_argument := true;
    
    C!.compiler_hints :=
      rec( category_filter := IsCategoryFromNerveData,
           object_filter := IsObjectInCategoryFromNerveData and HasMapOfObject,
           morphism_filter := IsMorphismInCategoryFromNerveData and HasMapOfMorphism,
           category_attribute_names :=
           [ "NerveData",
             ] );
    
    ##
    AddObjectConstructor( C,
      function( C, obj_map )
        
        return CreateCapCategoryObjectWithAttributes( C,
                       MapOfObject, obj_map );
        
    end );
    
    ##
    AddObjectDatum( C,
      function( C, obj )
        
        return MapOfObject( obj );
        
    end );
    
    ##
    AddMorphismConstructor( C,
      function( C, source, mor_map, range )
        
        return CreateCapCategoryMorphismWithAttributes( C,
                       source,
                       range,
                       MapOfMorphism, mor_map );
        
    end );
    
    ##
    AddMorphismDatum( C,
      function( C, mor )
        
        return MapOfMorphism( mor );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( C,
      function( C, obj )
        local V, C0, obj_map;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        C0 := NerveData( C )[1][1];
        
        obj_map := ObjectDatum( C, obj );
        
        return IsWellDefinedForMorphisms( V, obj_map ) and
               IsTerminal( V, Source( obj_map ) ) and
               IsEqualForObjects( V, C0, Range( obj_map ) );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( C,
      function( C, mor )
        local V, C1, mor_map;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        C1 := NerveData( C )[1][2];
        
        mor_map := MorphismDatum( C, mor );
        
        return IsWellDefinedForMorphisms( V, mor_map ) and
               IsTerminal( V, Source( mor_map ) ) and
               IsEqualForObjects( V, C1, Range( mor_map ) );
        
    end );
    
    ##
    AddIsEqualForObjects( C,
      function( C, obj_1, obj_2 )
        local V;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        return IsCongruentForMorphisms( V, ObjectDatum( C, obj_1 ), ObjectDatum( C, obj_2 ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( C,
      function( C, mor_1, mor_2 )
        local V;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        return IsEqualForMorphisms( V, MorphismDatum( C, mor_1 ), MorphismDatum( C, mor_2 ) );
        
    end );
    
    ##
    AddIsCongruentForMorphisms( C,
      function( C, mor_1, mor_2 )
        local V;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        return IsCongruentForMorphisms( V, MorphismDatum( C, mor_1 ), MorphismDatum( C, mor_2 ) );
        
    end );
    
    ##
    AddIdentityMorphism( C,
      function( C, obj )
        local V, id;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        id := NerveData( C )[2][1];
        
        return MorphismConstructor( C,
                       obj,
                       PreCompose( V, ObjectDatum( C, obj ), id ),
                       obj );
        
    end );
    
    ##
    AddPreCompose( C,
      function( C, mor_1, mor_2 )
        local V, C2, s, t, ps, pt, mu, DC1xC1, C1xC1, C2_C1xC1, C1xC1_C2, mor_12;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        ## C₂
        C2 := NerveData( C )[1][3];
        
        ## s: C₁ → C₀
        s := NerveData( C )[2][2];
        
        ## t: C₁ → C₀
        t := NerveData( C )[2][3];
        
        ## pₛ: C₂ → C₁
        ps := NerveData( C )[2][6];
        
        ## pₜ: C₂ → C₁
        pt := NerveData( C )[2][7];
        
        ## pₜ: C₂ → C₁
        mu := NerveData( C )[2][8];
        
        DC1xC1 := [ t, s ];
        
        ## C₁ ×ₜₛ C₁
        C1xC1 := FiberProduct( V,
                         DC1xC1 );
        
        ## C₂ → C₁ ×ₜₛ C₁
        C2_C1xC1 := UniversalMorphismIntoFiberProductWithGivenFiberProduct( V,
                            DC1xC1,
                            C2,
                            [ ps, pt ],
                            C1xC1 );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsIsomorphism( V, C2_C1xC1 ) ); # the first condition for the simplicial set to be the nerve of a category
        
        ## C₁ ×ₜₛ C₁ → C₂
        C1xC1_C2 := InverseForMorphisms( V,
                            C2_C1xC1 );
        
        ## 1 → C₁ ×ₜₛ C₁ → C₂
        mor_12 := PreCompose( V,
                          UniversalMorphismIntoFiberProductWithGivenFiberProduct( V,
                                  DC1xC1,
                                  TerminalObject( V ),
                                  [ MorphismDatum( C, mor_1 ), MorphismDatum( C, mor_2 ) ],
                                  C1xC1 ),
                          C1xC1_C2 );
        
        return MorphismConstructor( C,
                       Source( mor_1 ),
                       PreCompose( V, mor_12, mu ),
                       Range( mor_2 ) );
        
    end );
    
    Assert( 0, IsIdenticalObj( V, RangeCategoryOfHomomorphismStructure( V ) ) );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( C,
      function( C )
        
        return DistinguishedObjectOfHomomorphismStructure( RangeCategoryOfHomomorphismStructure( C ) );
        
    end );
    
    ##
    AddHomomorphismStructureOnObjects( C,
      function( C, obj_1, obj_2 )
        local V, s, t, Hom_o1_C, Hom_C_o2;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        s := NerveData( C )[2][2];
        t := NerveData( C )[2][3];
        
        Hom_o1_C := ProjectionInFactorOfFiberProduct( V,
                            [ s, ObjectDatum( C, obj_1 ) ],
                            1 );
        
        Hom_C_o2 := ProjectionInFactorOfFiberProduct( V,
                            [ t, ObjectDatum( C, obj_2 ) ],
                            1 );
        
        return FiberProduct( V,
                       [ Hom_o1_C, Hom_C_o2 ] );
        
    end );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( C,
      function( C, source, phi_1, phi_2, range )
        local V, C2, s, t, ps, pt, mu, DC1xC1, C1xC1, C2_C1xC1, C1xC1_C2,
              DC3, C3, p12, p23, pss, ptt, mux1, mumu, Hom_r1_s2, Hom_s1_r2,
              phi_1xC2, C2xphi_2, iota;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        ## C₂
        C2 := NerveData( C )[1][3];
        
        ## s: C₁ → C₀
        s := NerveData( C )[2][2];
        
        ## t: C₁ → C₀
        t := NerveData( C )[2][3];
        
        ## pₛ: C₂ → C₁
        ps := NerveData( C )[2][6];
        
        ## pₜ: C₂ → C₁
        pt := NerveData( C )[2][7];
        
        ## pₜ: C₂ → C₁
        mu := NerveData( C )[2][8];
        
        DC1xC1 := [ t, s ];
        
        ## C₁ ×ₜₛ C₁
        C1xC1 := FiberProduct( V,
                         DC1xC1 );
        
        ## C₂ → C₁ ×ₜₛ C₁
        C2_C1xC1 := UniversalMorphismIntoFiberProductWithGivenFiberProduct( V,
                            DC1xC1,
                            C2,
                            [ ps, pt ],
                            C1xC1 );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsIsomorphism( V, C2_C1xC1 ) ); # the first condition for the simplicial set to be the nerve of a category
        
        ## C₁ ×ₜₛ C₁ → C₂
        C1xC1_C2 := InverseForMorphisms( V,
                            C2_C1xC1 );
        
        ## (pₜ, pₛ)
        DC3 := [ pt, ps ];
        
        ## C₃
        C3 := FiberProduct( V,
                      DC3 );
        
        ## p₁₂: C₃ → C₂
        p12 := ProjectionInFactorOfFiberProductWithGivenFiberProduct( V,
                       DC3,
                       1,
                       C3 );
        
        ## p₂₃: C₃ → C₂
        p23 := ProjectionInFactorOfFiberProductWithGivenFiberProduct( V,
                       DC3,
                       2,
                       C3 );
        
        ## pₛₛ: C₃ → C₂
        pss := PreCompose( V, p12, ps );
        
        ## pₜₜ: C₃ → C₂
        ptt := PreCompose( V, p23, pt );
        
        ## μ × 1: C₃ →  C₁ ×ₜₛ C₁ → C₂
        mux1 := PreCompose( V,
                        UniversalMorphismIntoFiberProductWithGivenFiberProduct( V,
                                DC1xC1,
                                C3,
                                [ PreCompose( V, p12, mu ),
                                  ptt ],
                                C1xC1 ),
                        C1xC1_C2 );
        
        ## μμ: C₃ → C₁
        mumu := PreCompose( V, mux1, mu );
        
        ## Hom(r₁,s₂) ↪ C₁
        Hom_r1_s2 := MorphismFromFiberProductToSinkWithGivenFiberProduct( V,
                             [ ProjectionInFactorOfFiberProduct( V,
                                     [ s, ObjectDatum( C, Range( phi_1 ) ) ],
                                     1 ),
                               ProjectionInFactorOfFiberProduct( V,
                                     [ t, ObjectDatum( C, Source( phi_2 ) ) ],
                                       1 ) ],
                             source );
        
        ## Hom(s₁,r₂) ↪ C₁
        Hom_s1_r2 := MorphismFromFiberProductToSinkWithGivenFiberProduct( V,
                             [ ProjectionInFactorOfFiberProduct( V,
                                     [ s, ObjectDatum( C, Source( phi_1 ) ) ],
                                     1 ),
                               ProjectionInFactorOfFiberProduct( V,
                                     [ t, ObjectDatum( C, Range( phi_2 ) ) ],
                                     1 ) ],
                             range );
        
        ## {φ₁} ×ₜₛ Hom(r₁,-) ×ₜₛ Hom(-,-) ↪ C₃
        phi_1xC2 := ProjectionInFactorOfFiberProduct( V,
                            [ pss, MorphismDatum( C, phi_1 ) ],
                            1 );
        
        ## Hom(-,-) ×ₜₛ Hom(-,s₂) ×ₜₛ {φ₂} ↪ C₃
        C2xphi_2 := ProjectionInFactorOfFiberProduct( V,
                            [ ptt, MorphismDatum( C, phi_2 ) ],
                            1 );
        
        ## ι: {φ₁} ×ₜₛ Hom(r₁,s₂) ×ₜₛ {φ₂} ↪ C₃ → C₁
        iota := PreCompose( V,
                        MorphismFromFiberProductToSink( V,
                                [ phi_1xC2, C2xphi_2 ] ),
                        mumu );
        
        ## {φ₁} ×ₜₛ Hom(r₁,s₂) ×ₜₛ {φ₂} → Hom(s₁,r₂)
        return LiftAlongMonomorphism( V,
                       Hom_s1_r2,
                       iota );
        
    end );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( C,
      function( C, mor )
        local V, s, t, Hom_o1_C, Hom_C_o2, Hom_o1_o2;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        s := NerveData( C )[2][2];
        t := NerveData( C )[2][3];
        
        Hom_o1_C := ProjectionInFactorOfFiberProduct( V,
                            [ s, ObjectDatum( C, Source( mor ) ) ],
                            1 );
        
        Hom_C_o2 := ProjectionInFactorOfFiberProduct( V,
                            [ t, ObjectDatum( C, Range( mor ) ) ],
                            1 );
        
        Hom_o1_o2 :=  MorphismFromFiberProductToSink( V,
                              [ Hom_o1_C, Hom_C_o2 ] );
        
        return LiftAlongMonomorphism( V,
                       Hom_o1_o2,
                       MorphismDatum( C, mor ) );
        
    end );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( C,
      function( C, obj_1, obj_2, mor )
        local V, s, t, Hom_o1_C, Hom_C_o2, Hom_o1_o2;
        
        V := RangeCategoryOfHomomorphismStructure( C );
        
        s := NerveData( C )[2][2];
        t := NerveData( C )[2][3];
        
        Hom_o1_C := ProjectionInFactorOfFiberProduct( V,
                            [ s, ObjectDatum( C, obj_1 ) ],
                            1 );
        
        Hom_C_o2 := ProjectionInFactorOfFiberProduct( V,
                            [ t, ObjectDatum( C, obj_2 ) ],
                            1 );
        
        Hom_o1_o2 :=  MorphismFromFiberProductToSink( V,
                              [ Hom_o1_C, Hom_C_o2 ] );
        
        return MorphismConstructor( C,
                       obj_1,
                       PreCompose( V,
                               mor,
                               Hom_o1_o2 ),
                       obj_2 );
        
    end );
    
    #if false then
    if ValueOption( "no_precompiled_code" ) <> true then
        
        ADD_FUNCTIONS_FOR_CategoryFromNerveDataPrecompiled( C );
        ADD_FUNCTIONS_FOR_CategoryFromNerveDataHomStructureOnMorphismsPrecompiled( C );
        
    fi;
    
    Finalize( C );
    
    return C;
    
end );

##
InstallMethod( CreateObject,
        "for a category from nerve data and an integer",
        [ IsCategoryFromNerveData, IsInt ],
        
  function( C, o )
    local V, C0, obj_map;
    
    V := RangeCategoryOfHomomorphismStructure( C );
    
    C0 := NerveData( C )[1][1];
    
    obj_map := MorphismConstructor( V,
                       TerminalObject( V ),
                       [ o ],
                       C0 );
    
    return ObjectConstructor( C, obj_map );
    
end );

##
InstallMethod( \/,
        "for an integer and a category from nerve data",
        [ IsInt, IsCategoryFromNerveData ],
        
  function( o, C )
    
    return CreateObject( C, o );
    
end );

##
InstallMethod( CreateMorphism,
        "for two objects in a category from nerve data and an integer",
        [ IsObjectInCategoryFromNerveData, IsInt, IsObjectInCategoryFromNerveData ],
        
  function( source, m, range )
    local C, V, mors, mor_map;
    
    C := CapCategory( source );
    
    V := RangeCategoryOfHomomorphismStructure( C );
    
    mors := NerveData( C )[1][2];
    
    mor_map := MorphismConstructor( V,
                       TerminalObject( V ),
                       [ m ],
                       mors );
    
    return MorphismConstructor( C,
                   source,
                   mor_map,
                   range );
    
end );

##
InstallMethod( CreateMorphism,
        "for a category from nerve data and an integer",
        [ IsCategoryFromNerveData, IsInt ],
        
  function( C, m )
    local nerve_data, s, t;
    
    nerve_data := NerveData( C );
    
    s := nerve_data[2][2];
    t := nerve_data[2][3];
    
    return CreateMorphism(
                   CreateObject( C, s( m ) ),
                   m,
                   CreateObject( C, t( m ) ) );
    
end );

##
InstallMethod( \.,
        "for a category from nerve data and a positive integer",
        [ IsCategoryFromNerveData, IsPosInt ],
        
  function( C, string_as_int )
    local name;
    
    name := NameRNam( string_as_int );
    
    if name in C!.labels[1] then
        return CreateObject( C, -1 + SafePosition( C!.labels[1], name ) );
    elif name in C!.labels[2] then
        return CreateMorphism( C, C!.indices_of_generating_morphisms[SafePosition( C!.labels[2], name )] );
    elif name[1] in [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ] then
        return CreateMorphism( C, Int( name ) );
    fi;
    
    Error( "no object or morphism of name ", name, "\n" );
    
end );

##
InstallOtherMethod( SetOfObjects,
        "for a category from nerve data",
        [ IsCategoryFromNerveData ],
        
  function( C )
    
    return List( [ 0 .. Length( NerveData( C )[1][1] ) - 1 ], i -> CreateObject( C, i ) );
    
end );

##
InstallOtherMethod( SetOfGeneratingMorphisms,
        "for a category from nerve data",
        [ IsCategoryFromNerveData ],
        
  function( C )
    
    return List( C!.indices_of_generating_morphisms, i -> CreateMorphism( C, i ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for an object in a category from nerve data",
        [ IsObjectInCategoryFromNerveData ],
        
  function( obj )
    
    Print( "<(", CapCategory( obj )!.labels[1][1 + MapOfObject( obj )( 0 )], ")>" );
    
end );

##
InstallMethod( ViewObj,
        "for a morphism in a category from nerve data",
        [ IsMorphismInCategoryFromNerveData ],
        
  function( mor )
    local C, i, pos;
    
    C := CapCategory( mor );
    
    i := MapOfMorphism( mor )( 0 );
    pos := Position( C!.indices_of_generating_morphisms, i);
    
    Print( "(", C!.labels[1][1 + MapOfObject( Source( mor ) )( 0 )], ")" );
    Print( "-[(" );
    if pos = fail then
        Print( i );
    else
        Print( C!.labels[2][pos] );
    fi;
    Print( ")]->" );
    Print( "(", C!.labels[1][1 + MapOfObject( Range( mor ) )( 0 )], ")" );
    
end );

##
InstallMethod( LaTeXOutput,
        "for an object in a category from nerve data",
        [ IsObjectInCategoryFromNerveData ],
        
  function( obj )
    
    return String( MapOfObject( obj )( 0 ) );
    
end );

##
InstallMethod( LaTeXOutput,
        "for a morphism in a category from nerve data",
        [ IsMorphismInCategoryFromNerveData ],
        
  function( mor )
    local s;
    
    s := String( MapOfMorphism( mor )( 0 ) );
    
    if ValueOption( "OnlyDatum" ) = true then
        
        return s;
        
    fi;
    
    return Concatenation(
                   "{", LaTeXOutput( Source( mor ) ), "}",
                   "-\\left[{", s, "}\\right]\\rightarrow",
                   "{", LaTeXOutput( Range( mor ) ), "}" );
    
end );
