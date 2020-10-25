# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Declarations
#

#! @Chapter Algebroids as preadditive categories generated by enhanced quivers

# our info class:
DeclareInfoClass( "InfoAlgebroids" );
SetInfoLevel( InfoAlgebroids, 1 );

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of objects in an algebroid.
DeclareCategory( "IsCapCategoryObjectInAlgebroid",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in an algebroid.
DeclareCategory( "IsCapCategoryMorphismInAlgebroid",
        IsCapCategoryMorphism );

#! @Description
#!  The &GAP; category of algebroids.
DeclareCategory( "IsAlgebroid",
        IsCapCategory );

#! @Description
#!  The &GAP; category of algebras.
DeclareCategory( "IsAlgebraAsCategory",
        IsAlgebroid );

####################################
#
#! @Section Properties
#
####################################

#! @Description
#!  Is the category <A>A</A> finitely presented.
#!  This property is true by construction for algebroids generated by finite quivers.
#! @Arguments A
DeclareProperty( "IsFinitelyPresentedCategory",
        IsCapCategory );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsFinitelyPresentedCategory := Concatenation( [
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );


#! @Description
#!  Check whether the algebroid <A>A</A> is commutative.
#! @Arguments A
#! @Returns true or false
DeclareProperty( "IsCommutative",
        IsAlgebroid );

#! @Description
#!  Check whether <A>B</A> is counitary.
#! @Arguments B
#! @Returns true or false
DeclareProperty( "IsCounitary",
        IsAlgebroid );

#! @Description
#!  Check whether <A>B</A> is coassociative.
#! @Arguments B
#! @Returns true or false
DeclareProperty( "IsCoassociative",
        IsAlgebroid );

####################################
#
#! @Section Attributes
#
####################################

#! @Description
#!  The quiver underlying the algebroid <A>A</A>.
#! @Arguments A
#! @Returns a &QPA; quiver
DeclareAttribute( "UnderlyingQuiver",
        IsAlgebroid );

#! @Description
#!  The quiver algebra (=path algebra with relations) underlying the algebroid <A>A</A>.
#! @Arguments A
#! @Returns a &QPA; path algebra
DeclareAttribute( "UnderlyingQuiverAlgebra",
        IsAlgebroid );

#! @Description
#!  The finite set of objects of the finitely presented algebroid <A>A</A>.
#! @Arguments A
#! @Returns a list
DeclareAttribute( "SetOfObjects",
        IsAlgebroid );

#! @Description
#!  Assigns the objects of the finitely presented algebroid <A>A</A> to global variables.
#!  Names of the variables are the concatenation of <A>label</A> with the names of the defining vertices.
#! @Arguments A, label
#! @Returns nothing
DeclareOperation( "AssignSetOfObjects",
        [ IsAlgebroid, IsString ] );

#! @Description
#!  The finite set of morphisms generating the finitely presented algebroid <A>A</A>.
#! @Arguments A
#! @Returns a list
DeclareAttribute( "SetOfGeneratingMorphisms",
        IsAlgebroid );

#! @Description
#!  The subset of the generating morphisms that start at <A>obj_1</A> and ends at <A>obj_2</A>.
#! @Arguments A, obj_1, obj_2
#! @Returns a list
DeclareOperation( "SetOfGeneratingMorphisms",
        [ IsAlgebroid, IsCapCategoryObjectInAlgebroid, IsCapCategoryObjectInAlgebroid ] );

#! @Description
#!  The subset of the generating morphisms that start at <A>obj_1</A> and ends at <A>obj_2</A>.
#! @Arguments obj_1, obj_2
#! @Returns a list
DeclareOperation( "SetOfGeneratingMorphisms",
        [ IsCapCategoryObjectInAlgebroid, IsCapCategoryObjectInAlgebroid ] );

#! @Description
#!  Delegates to <C>SetOfGeneratingMorphisms</C>( <A>A</A>, <C>SetOfObjects</C>(<A>A</A>)[<A>i</A>], <C>SetOfObjects</C>(<A>A</A>)[<A>j</A>] ).
#! @Arguments A, i, j
#! @Returns a list
DeclareOperation( "SetOfGeneratingMorphisms",
        [ IsAlgebroid, IsInt, IsInt ] );

#! @Description
#!  Assigns the generating morphisms of the finitely presented algebroid <A>A</A> to global variables.
#!  Names of the variables are the concatenation of <A>label</A> with the names of the defining arrows.
#! @Arguments A, label
#! @Returns nothing
DeclareOperation( "AssignSetOfGeneratingMorphisms",
        [ IsAlgebroid, IsString ] );

#! @Description
#!  The relations of the algebroid <A>A</A> corresponding to
#!  <C>RelationsOfAlgebra( UnderlyingQuiverAlgebra( <A>A</A> ) )</C>.
#! @Arguments A
#! @Returns a &QPA; path algebra
DeclareAttribute( "RelationsOfAlgebroid",
        IsAlgebroid );

#! @Description
#!  The algebroid defined by the opposite of the underlying quiver algebra.
#! @Arguments A
#! @Returns a &CAP; category
DeclareAttribute( "AlgebroidOverOppositeAlgebra",
        IsAlgebroid );

DeclareAttribute( "Multiplication",
        IsAlgebraAsCategory );

DeclareAttribute( "Unit",
        IsAlgebraAsCategory );

#! @Description
#!  The antipode of the Hopf algebroid <A>B</A>.
#! @Arguments B
#! @Returns a &CAP; functor
DeclareAttribute( "Antipode",
        IsAlgebroid );

#! @Description
#!  The vertex of the quiver underlying the object <A>obj</A> in an algebroid.
#! @Arguments obj
#! @Returns a vertex in a &QPA; quiver
DeclareAttribute( "UnderlyingVertex",
        IsCapCategoryObjectInAlgebroid );

#! @Description
#!  The quiver algebra element underlying the morphism <A>mor</A> in an algebroid.
#! @Arguments mor
#! @Returns an element in a &QPA; path algebra
DeclareAttribute( "UnderlyingQuiverAlgebraElement",
        IsCapCategoryMorphismInAlgebroid );

#! @Description
#!  The underlying algebra of an algebroid.
#! @Arguments A
#! @Returns a ring
DeclareAttribute( "UnderlyingAlgebra",
        IsAlgebroid );

#! @Description
#!  The parity of an algebroid.
#! @Arguments A
#! @Returns a string ("left" or "right")
DeclareAttribute( "Parity",
        IsAlgebroid );

#! @Description
#!  The <A>n</A>-th power of the algebroid <A>A</A>.
#!  Admissible values for <A>n</A> are $0,1,2$.
#! @Arguments A, n
#! @Returns a &CAP; category
DeclareOperation( "POW",
        [ IsAlgebroid, IsInt ] );

DeclareAttribute( "BijectionBetweenPairsAndElementaryTensors",
        IsQuiverAlgebra );

DeclareAttribute( "DecompositionOfMorphismInAlgebroid",
        IsCapCategoryMorphismInAlgebroid );

DeclareAttribute( "DecompositionOfMorphismInSquareOfAlgebroid",
        IsCapCategoryMorphismInAlgebroid );

####################################
#
#! @Section Operations
#
####################################

#! @Arguments e
DeclareOperation( "DecomposeQuiverAlgebraElement",
        [ IsQuiverAlgebraElement ] );

#! @Description
#!  Apply the functor <A>F</A> (e.g., defined by the functions <A>img_of_objs_func</A> and
#!  <A>imgs_of_generating_mors_func</A>) to the quiver algebra element <A>p</A>.
#! @Arguments img_of_objs_func, imgs_of_generating_mors_func, path, covariant
#! @Returns a morphism in a &CAP; category
#! @Group ApplyToQuiverAlgebraElement
DeclareOperation( "ApplyToQuiverAlgebraElement",
        [ IsFunction, IsFunction, IsCapCategory, IsQuiverAlgebraElement, IsBool ] );

#! @Arguments F, path
#! @Group ApplyToQuiverAlgebraElement
DeclareOperation( "ApplyToQuiverAlgebraElement",
        [ IsCapFunctor, IsQuiverAlgebraElement ] );

#! @Arguments k, str
DeclareOperation( "TrivialAlgebroid",
        [ IsHomalgRing, IsString ] );

#! @Arguments A, B
DeclareOperation( "\*",
        [ IsAlgebroid, IsAlgebroid ] );

#! @Description
#!  Given an object <A>a</A> in an algebroid A and an object <A>b</A> in an algebroid B and the tensor product <A>T</A> of A and B, return the tensor product of a and b in T.
#! @Arguments a, b, T
#! @Returns a morphism in a &CAP; category
DeclareOperation( "ElementaryTensor",
        [ IsCapCategoryObjectInAlgebroid, IsCapCategoryObjectInAlgebroid, IsAlgebroid ] );

#! @Description
#!  Given an object <A>a</A> in an algebroid A and a morphism <A>g</A> in an algebroid B and the tensor product <A>T</A> of A and B, return the tensor product of a and g in T.
#! @Arguments a, g, T
#! @Returns a morphism in a &CAP; category
DeclareOperation( "ElementaryTensor",
        [ IsCapCategoryObjectInAlgebroid, IsCapCategoryMorphismInAlgebroid, IsAlgebroid ] );

#! @Description
#!  Given a morphism <A>f</A> in an algebroid A and an object <A>b</A> in an algebroid B and the tensor product <A>T</A> of A and B, return the tensor product of f and b in T.
#! @Arguments f, b, T
#! @Returns a morphism in a &CAP; category
DeclareOperation( "ElementaryTensor",
        [ IsCapCategoryMorphismInAlgebroid, IsCapCategoryObjectInAlgebroid, IsAlgebroid ] );

#! @Description
#! The ouput is the LaTeX string of the object <A>o</A>.
#! @Arguments o
#! Returns a string
DeclareOperation( "LaTeXStringOp", [ IsCapCategoryObjectInAlgebroid ] );

#! @Description
#! The ouput is the LaTeX string of the morphism <A>m</A>.
#! @Arguments m
#! Returns a string
DeclareOperation( "LaTeXStringOp", [ IsCapCategoryMorphismInAlgebroid ] );

####################################
#
#! @Section Constructors
#
####################################

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_ALGEBROID" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_HOM_STRUCTURE_OF_ALGEBROID" );

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_RANDOM_METHODS_OF_ALGEBROID" );

DeclareOperation( "Algebroid",
        [ IsQuiverAlgebra, IsBool ] );

#! @Description
#!  Construct the algebroid associated to the path $R$-algebra <A>Rq</A>
#!  of the quiver $q$ modulo the relations <A>L</A> as an $R$-linear category.
#! @Arguments Rq
#! @Returns a &CAP; category
#! @Group Algebroid
DeclareAttribute( "Algebroid",
        IsQuiverAlgebra );

#! @Arguments Rq, L
#! @Group Algebroid
DeclareOperation( "Algebroid",
        [ IsPathAlgebra, IsList ] );

#! @Arguments R, q
#! @Group Algebroid
DeclareOperation( "Algebroid",
        [ IsHomalgRing, IsQuiver ] );

#! @Description
#! The argument is an algebroid $A$ with left acting domain given by the field of rationals $\mathbb{Q}$,
#! either realized by <C>Rationals</C> or by <C>HomalgFieldOfRationals</C> (in no external CAS).
#! Futhermore, $A$ has to satisfy another technical condition that is described below.
#! The output is an algebroid $A'$ defined over $\mathbb{Z}$ such that
#! $A' \otimes_{\mathbb{Z}} \mathbb{Q} \simeq A$.
#! For the construction of $A'$, let $T$ be the multiplication table of the underlying quiver algebra of $A$
#! expressed with respect to the $\mathbb{Q}$-basis <C>BasisPaths( CanonicalBasis( A' ) )</C>, denoted by $B$.
#! Now, we expect the following technical condition to hold: $T$ should only consist of
#! integral linear combinations of paths in $B$.
#! Then $A'$ is constructed as the algebroid over $\mathbb{Z}$, realized as <C>HomalgRingOfIntegers</C>,
#! with the same vertices as $A$,
#! a $\mathbb{Z}$-basis of paths given by $B$,
#! and composition is carried out using the rules defined by $T$.
#! @Arguments A
#! @Returns a &CAP; category
DeclareAttribute( "DescentToZDefinedByBasisPaths",
        IsAlgebroid );

#! @Description
#!  Construct a functor with source the finitely presented algebroid <A>A</A> and target <A>B</A> using
#!  the two defining lists of images <A>images_of_objects</A> and <A>images_of_generating_morphisms</A>.
#!  The order of their entries must correspond to that of the vertices and arrows of the underlying quiver.
#! @Arguments A, images_of_objects, images_of_generating_morphisms, B, covariant
#! @Group CapFunctor
DeclareOperation( "CapFunctor",
        [ IsAlgebroid, IsList, IsList, IsCapCategory, IsBool ] );

#! @Arguments A, images_of_objects, images_of_generating_morphisms, B
#!  If the last boolean argument <A>covariant</A> is not specified it defaults to <C>true</C>.
#! @Group CapFunctor
DeclareOperation( "CapFunctor",
        [ IsAlgebroid, IsList, IsList, IsCapCategory ] );

#! @Description
#!  Alternatively one could specify the records of images <A>rec_images_of_objects</A> and <A>rec_images_of_generating_morphisms</A>.
#!  The record <A>rec_images_of_objects</A> is supposed to contain the images of the objects of <A>A</A>.
#!  The record <A>rec_images_of_generating_morphisms</A> is supposed to contain the images of the set of generating morphisms of <A>A</A>.
#! @Arguments A, rec_images_of_objects, rec_images_of_generating_morphisms, covariant
#! @Returns a &CAP; functor
#! @Group CapFunctor
DeclareOperation( "CapFunctor",
        [ IsAlgebroid, IsRecord, IsRecord, IsBool ] );

#! @Arguments A, rec_images_of_objects, rec_images_of_generating_morphisms
#! @Group CapFunctor
DeclareOperation( "CapFunctor",
        [ IsAlgebroid, IsRecord, IsRecord ] );

#! @Description
#!  Construct, using the record of images <A>eta</A>, a natural transformation
#!  from the functor <A>F</A> to the parallel functor <A>G</A>.
#! @Arguments eta, F, G
#! @Returns a &CAP; natural transformation
DeclareOperation( "NaturalTransformation",
        [ IsRecord, IsCapFunctor, IsCapFunctor ] );

#! @Description
#!  The constructor of objects in an algebroid <A>A</A> given a vertex <A>V</A>
#!  in the underlying quiver.
#! @Arguments A, V
#! @Returns an object in a &CAP; category
#! @Group ObjectInAlgebroid
DeclareOperation( "ObjectInAlgebroid",
        [ IsAlgebroid, IsQuiverVertex ] );

#! @Description
#!  Delegates to <C>ObjectInAlgebroid</C>( <A>A</A>,  <A>V</A> ).
#! @Arguments V, A
#! @Returns an object in a &CAP; category
DeclareOperation( "\/", [ IsQuiverVertex, IsAlgebroid ] );

#! @Description
#!  The constructor of morphisms in an algebroid <A>A</A> given the source <A>S</A>,
#!  the target <A>T</A>, and the underlying quiver algebra element <A>path</A>.
#!  If neither <A>S</A> nor <A>T</A> are provided they are read off from <A>path</A>.
#! @Arguments S, path, T
#! @Returns a morphism in a &CAP; category
#! @Group MorphismInAlgebroid
DeclareOperation( "MorphismInAlgebroid",
        [ IsCapCategoryObjectInAlgebroid, IsQuiverAlgebraElement, IsCapCategoryObjectInAlgebroid ] );

#! @Arguments A, path
#! @Group MorphismInAlgebroid
DeclareOperation( "MorphismInAlgebroid",
        [ IsAlgebroid, IsQuiverAlgebraElement ] );

#! @Description
#!  Delegates to <C>MorphismInAlgebroid</C>( <A>path</A> ).
#! @Arguments path, A
#! @Returns a morphism in a &CAP; category
DeclareOperation( "\/", [ IsQuiverAlgebraElement, IsAlgebroid ] );
