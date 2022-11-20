#! @BeginChunk PrecompileAdditiveClosureOfAlgebroid

#! @Example

LoadPackage( "Algebroids", false );
#! true
LoadPackage( "CompilerForCAP", false );
#! true

QQ := HomalgFieldOfRationals( );;
snake_quiver := RightQuiver( "q(4)[a:1->2,b:2->3,c:3->4]" );;
A := PathAlgebra( QQ, snake_quiver );;

ReadPackage( "Algebroids", "gap/CompilerLogic.gi" );
#! true

# only valid for the construction above
# FIXME: IsInt should be IsRat, but specializations of types are not yet supported by CompilerForCAP
CapJitAddTypeSignature( "CoefficientsOfPaths", [ IsList, IsQuiverAlgebraElement ], rec( filter := IsList, element_type := rec( filter := IsInt ) ) );

# EXPERIMENTAL
Add( CAP_JIT_EXPENSIVE_FUNCTION_NAMES, "CoefficientsOfPaths" );

precompile_AdditiveClosureOfAlgebroid :=
  function( Rq, over_Z, ring )
    CapJitPrecompileCategoryAndCompareResult(
        EvalString( ReplacedString( """Rq -> AdditiveClosure( Algebroid(
            Rq, over_Z : FinalizeCategory := true
        ) )""", "over_Z", String( over_Z ) ) ),
        [ Rq ],
        "Algebroids",
        Concatenation(
            "AdditiveClosureOfAlgebroidOfFiniteDimensionalQuiverAlgebraOfRightQuiverOver",
            ring,
            "Precompiled"
        ) :
        operations := "primitive"
    ); end;;

precompile_AdditiveClosureOfAlgebroid( A, false, "Field" );
precompile_AdditiveClosureOfAlgebroid( A, true, "Z" );

AdditiveClosureOfAlgebroidOfFiniteDimensionalQuiverAlgebraOfRightQuiverOverFieldPrecompiled( A );
#! Additive closure( Algebroid( Q, FreeCategory( RightQuiver(
#! "q(4)[a:1->2,b:2->3,c:3->4]" ) ) ) )

#! @EndExample

#! Check that the compiled code is loaded automatically
#! for this, we use the name of the argument of `ZeroObject`:
#! for non-compiled code it is "cat", while for compiled code it is "cat_1"

#! @Example

AdditiveClosure( Algebroid( A, false ) )!.precompiled_functions_added;
#! true

AdditiveClosure( Algebroid( A, true ) )!.precompiled_functions_added;
#! true

#! @EndExample

#! @EndChunk
