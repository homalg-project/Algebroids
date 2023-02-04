# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Implementations
#

##
InstallMethod( DefiningTripleOfAQuiver,
        "for a quiver",
        [ IsQuiver ],
        
  function( q )
    local vertices, arrows;
    
    vertices := Vertices( q );
    arrows := Arrows( q );
    
    return Immutable(
                   Triple( Length( vertices ),
                           Length( arrows ),
                           List( arrows, m -> Pair( -1 + SafePosition( vertices, Source( m ) ), -1 + SafePosition( vertices, Range( m ) ) ) ) ) );
    
end );

##
InstallMethod( OppositeFiniteCategory,
        "for a finite category",
        [ IsCapCategory and IsFinite ],
        
  function( C )
    local C_op, defining_triple;
    
    C_op := Opposite( C );
    
    SetIsFinite( C_op, true );
    
    SetSetOfObjects( C_op,
            List( SetOfObjects( C ), Opposite ) );
    
    SetSetOfGeneratingMorphisms( C_op,
            List( SetOfGeneratingMorphisms( C ), Opposite ) );
    
    defining_triple := DefiningTripleOfUnderlyingQuiver( C );
    
    defining_triple := Triple( defining_triple[1],
                               defining_triple[2],
                               List( defining_triple[3], a -> Pair( a[2], a[1] ) ) );
    
    SetDefiningTripleOfUnderlyingQuiver( C_op, defining_triple );
    
    return C_op;
    
end );
