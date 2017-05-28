#
# Bialgebroids: Bialgebroids as preadditive categories generated by enhanced quivers
#
# Implementations
#

####################################
#
# representations:
#
####################################

DeclareRepresentation( "IsCapCategoryObjectInAlgebroidRep",
        IsCapCategoryObjectInAlgebroid and
        IsAttributeStoringRep,
        [ ] );

DeclareRepresentation( "IsCapCategoryMorphismInAlgebroidRep",
        IsCapCategoryMorphismInAlgebroid and
        IsAttributeStoringRep,
        [ ] );

####################################
#
# families and types:
#
####################################

# new families:
BindGlobal( "TheFamilyOfObjectsInAlgebroids",
        NewFamily( "TheFamilyOfObjectsInAlgebroids" ) );

BindGlobal( "TheFamilyOfMorphismsInAlgebroids",
        NewFamily( "TheFamilyOfMorphismsInAlgebroids" ) );

# new types:
BindGlobal( "TheTypeObjectInAlgebroid",
        NewType( TheFamilyOfObjectsInAlgebroids,
                IsCapCategoryObjectInAlgebroidRep ) );

BindGlobal( "TheTypeMorphismInAlgebroid",
        NewType( TheFamilyOfMorphismsInAlgebroids,
                IsCapCategoryMorphismInAlgebroidRep ) );

####################################
#
# methods for attributes:
#
####################################

####################################
#
# methods for operations:
#
####################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_ALGEBROID,
  
  function( category )
    
    ##
    AddIsWellDefinedForObjects( category,
      function( o )
        
        o := UnderlyingVertex( o );
        
        return IsVertex( o ) and IsIdenticalObj( QuiverOfPath( o ), UnderlyingQuiver( category ) );
        
      end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( m )
        
        m := UnderlyingQuiverAlgebraElement( m );
        
        return IsPath( m ) and IsIdenticalObj( QuiverOfPath( m ), UnderlyingQuiver( category ) );
        
      end );
    
    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
        
        return UnderlyingVertex( object_1 ) = UnderlyingVertex( object_2 );
        
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return UnderlyingQuiverAlgebraElement( morphism_1 ) = UnderlyingQuiverAlgebraElement( morphism_2 );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( object )
        local A, id;
        
        A := UnderlyingQuiverAlgebra( CapCategory( object ) );
        
        id := rec( );
        
        ObjectifyWithAttributes( id, TheTypeMorphismInAlgebroid,
                Source, object,
                Range, object,
                UnderlyingQuiverAlgebraElement, A.(String( UnderlyingVertex( object ) ) )
                );
        
        return id;
        
    end );
    
    ##
    AddPreCompose( category,
      function( morphism_1, morphism_2 )
        local B, quiver;
        
        B := CapCategory( morphism_1 );
        
        quiver := UnderlyingQuiver( B );
        
        if IsRightQuiver( quiver ) then
            return MorphismInAlgebroid(
                           Source( morphism_1 ),
                           UnderlyingQuiverAlgebraElement( morphism_1 ) * UnderlyingQuiverAlgebraElement( morphism_2 ),
                           Range( morphism_2 ) );
        else
            return MorphismInAlgebroid(
                           Source( morphism_1 ),
                           UnderlyingQuiverAlgebraElement( morphism_2 ) * UnderlyingQuiverAlgebraElement( morphism_1 ),
                           Range( morphism_2 ) );
        fi;
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return MorphismInAlgebroid(
                       Source( morphism_1 ),
                       UnderlyingQuiverAlgebraElement( morphism_1 ) + UnderlyingQuiverAlgebraElement( morphism_2 ),
                       Range( morphism_1 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return MorphismInAlgebroid(
                       Source( morphism ),
                       -UnderlyingQuiverAlgebraElement( morphism ),
                       Range( morphism ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( S, T )
        
        return MorphismInAlgebroid(
                       S,
                       Zero( UnderlyingQuiverAlgebra( CapCategory( S ) ) ),
                       T );
        
    end );
    
    return category;
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_BIALGEBROID,
  
  function( category )
    
    return category;
    
end );

##
InstallMethod( Algebroid_NonFinalized,
        "for a QPA quiver algebra",
        [ IsQuiverAlgebra ],
        
  function( Rq )
    local parity, quiver, A;
    
    if IsRightQuiverAlgebra( Rq ) then
        parity := "right";
    else
        parity := "left";
    fi;
    
    quiver := QuiverOfAlgebra( Rq );
    
    A := Concatenation( "Algebroid generated by the ", parity, " quiver ", String( quiver ) );
    
    A := CreateCapCategory( A );
    
    SetUnderlyingQuiver( A, quiver );
    SetUnderlyingQuiverAlgebra( A, Rq );
    
    A!.Vertices := rec( );
    A!.Arrows := rec( );
    
    return ADD_FUNCTIONS_FOR_ALGEBROID( A );
    
end );

##
InstallMethod( Algebroid_NonFinalized,
        "for a homalg ring and a QPA quiver",
        [ IsHomalgRing, IsQuiver ],
        
  function( R, quiver )
    
    return Algebroid_NonFinalized( PathAlgebra( R, quiver ) );
    
end );

##
InstallMethod( Algebroid,
        "for a homalg ring and a QPA quiver",
        [ IsHomalgRing, IsQuiver ],
        
  function( R, quiver )
    local A;
    
    A := Algebroid_NonFinalized( R, quiver );
    
    Finalize( A );
    
    return A;
    
end );

##
InstallMethod( Algebroid,
        "for a QPA quiver algebra",
        [ IsQuiverAlgebra ],
        
  function( Rq )
    local A;
    
    A := Algebroid_NonFinalized( Rq );
    
    Finalize( A );
    
    return A;
    
end );

##
InstallMethod( Bialgebroid,
        "for a homalg ring and a QPA quiver",
        [ IsHomalgRing, IsQuiver ],
        
  function( R, quiver )
    local B;
    
    B := Algebroid_NonFinalized( R, quiver );
    
    ADD_FUNCTIONS_FOR_BIALGEBROID( B );
    
    Finalize( B );
    
    return B;
    
end );

##
InstallMethod( MorphismInAlgebroid,
        "for two objects in an algebroid and an element of the quiver algebra",
        [ IsCapCategoryObjectInAlgebroidRep, IsQuiverAlgebraElement, IsCapCategoryObjectInAlgebroidRep ],
        
  function( S, path, T )
    local l, mor, A;
    
    if not IsZero( path ) then
        
        if not IsUniform( path ) then
            Error( "the path ", path, " is neither zero nor uniform\n" );
        fi;
        
        ## TODO: we are avoiding for the moment the sanity test for
        ## elements of path algebras with relations, this should be
        ## reintroduced in the future
        if IsPathAlgebraElement( path ) then
            l := LeadingPath( path );
            
            if not ( Source( l ) = UnderlyingVertex( S ) and
                     Target( l ) = UnderlyingVertex( T ) ) then
                Error( "the path ", path, " is neither zero nor does it match the given source S or target T\n" );
            fi;
        fi;
        
    fi;
    
    mor := rec( );
    
    A := CapCategory( S );
    
    ObjectifyWithAttributes( mor, TheTypeMorphismInAlgebroid,
            Source, S,
            Range, T,
            UnderlyingQuiverAlgebraElement, path
            );
    
    return mor;
    
end );

##
InstallMethod( \.,
        "for an algebroid and a positive integer",
        [ IsCapCategory, IsPosInt ],
        
  function( B, string_as_int )
    local q, name, a, b, A;
    
    q := UnderlyingQuiver( B );
    
    name := NameRNam( string_as_int );
    
    a := q.(name);
    
    b := rec( );
    
    if IsVertex( a ) then
        if IsBound( B!.Vertices.(name) ) then
            return B!.Vertices.(name);
        fi;
        ObjectifyWithAttributes( b, TheTypeObjectInAlgebroid,
                UnderlyingVertex, a
                );
        B!.Vertices.(name) := b;
    elif IsArrow( a ) then
        if IsBound( B!.Arrows.(name) ) then
            return B!.Arrows.(name);
        fi;
        A := UnderlyingQuiverAlgebra( B );
        ObjectifyWithAttributes( b, TheTypeMorphismInAlgebroid,
                Source, B.(String( Source( a ) ) ),
                Range, B.(String( Target( a ) ) ),
                UnderlyingQuiverAlgebraElement, PathAsAlgebraElement( A, a )
                );
        B!.Arrows.(name) := b;
    else
        Error( "the given component ", name, " is neither a vertex nor an arrow of the quiver q = ", q, "\n" );
    fi;
    
    Add( B, b );
    
    return b;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for an object in an algebroid",
        [ IsCapCategoryObjectInAlgebroidRep ],

  function( o )
    
    ViewObj( UnderlyingVertex( o ) );
    
end );

##
InstallMethod( ViewObj,
        "for a morphism in an algebroid",
        [ IsCapCategoryMorphismInAlgebroidRep ],

  function( o )
    
    if IsRightQuiverAlgebra( UnderlyingQuiverAlgebra( CapCategory( o ) ) ) then
        ViewObj( Source( o ) );
        Print( "-[" );
        ViewObj( UnderlyingQuiverAlgebraElement( o ) );
        Print( "]->" );
        ViewObj( Range( o ) );
    else
        ViewObj( Range( o ) );
        Print( "<-[" );
        ViewObj( UnderlyingQuiverAlgebraElement( o ) );
        Print( "]-" );
        ViewObj( Source( o ) );
    fi;
    
end );
