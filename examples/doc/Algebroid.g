#! @BeginChunk Algebroid

LoadPackage( "Algebroids" );

#! Create a left quiver $ql$ with 3 vertices u,v,w and 4 edges a,b,c,d.

#! @Example
ql := LeftQuiver( "ql(u,v,w)[a:u->v,b:v->u,c:v->u,d:v->w]" );
#! ql(u,v,w)[a:u->v,b:v->u,c:v->u,d:v->w]
#! @EndExample

#! Create a right quiver $qr$ with 3 vertices u,v,w and 4 edges a,b,c,d.

#! @Example
qr := RightQuiver( "qr(u,v,w)[a:u->v,b:v->u,c:v->u,d:v->w]" );
#! qr(u,v,w)[a:u->v,b:v->u,c:v->u,d:v->w]
#! @EndExample

#! Create algebroids from these quivers over $\mathbb{Q}$.

#! @Example
Q := HomalgFieldOfRationals( );
#! Q
Al := Algebroid( Q, ql );
#! Algebroid( Q, FreeCategory(
#! LeftQuiver( "ql(u,v,w)[a:u->v,b:v->u,c:v->u,d:v->w]" ) ) )
algebra_Al := UnderlyingQuiverAlgebra( Al );
#! Q * ql
Ar := Algebroid( Q, qr );
#! Algebroid( Q, FreeCategory(
#! RightQuiver( "qr(u,v,w)[a:u->v,b:v->u,c:v->u,d:v->w]" ) ) )
algebra_Ar := UnderlyingQuiverAlgebra( Ar );
#! Q * qr
Al.u;
#! <(u)>
Ar.u;
#! <(u)>
Al.a;
#! (v)<-[1*(a)]-(u)
Ar.a;
#! (u)-[1*(a)]->(v)
SetOfObjects( Al );
#! [ <(u)>, <(v)>, <(w)> ]
SetOfGeneratingMorphisms( Al );
#! [ (v)<-[1*(a)]-(u), (u)<-[1*(b)]-(v), (u)<-[1*(c)]-(v), (w)<-[1*(d)]-(v) ]
SetOfGeneratingMorphisms( Al, Al.u, Al.v );
#! [ (v)<-[1*(a)]-(u) ]
SetOfObjects( Ar );
#! [ <(u)>, <(v)>, <(w)> ]
SetOfGeneratingMorphisms( Ar );
#! [ (u)-[1*(a)]->(v), (v)-[1*(b)]->(u), (v)-[1*(c)]->(u), (v)-[1*(d)]->(w) ]
SetOfGeneratingMorphisms( Ar, Ar.u, Ar.v );
#! [ (u)-[1*(a)]->(v) ]
CommutativeRingOfLinearCategory( Al ) = Q;
#! true
ObjectInAlgebroid( Al, ql.u ) = Al.u;
#! true
Al.u = ql.u / Al;
#! true
MorphismInAlgebroid( Al, algebra_Al.a ) = Al.a;
#! true
Al.a = algebra_Al.a / Al;
#! true
IdentityMorphism( Al.u ) = algebra_Al.u / Al;
#! true
#! @EndExample

#! We can compute in the algebroids.
#! For instance we can form compositions.

#! @Example
PreCompose( Al.a, Al.d );
#! (w)<-[1*(d*a)]-(u)
PreCompose( Ar.a, Ar.d );
#! (u)-[1*(a*d)]->(w)
#! @EndExample

#! We also have addition and subtraction of morphisms and scalar multiplication with elements from the ground ring $\mathbb{Q}$.

#! @Example
Al.b+Al.c;
#! (u)<-[1*(c) + 1*(b)]-(v)
Ar.b+Ar.c;
#! (v)-[1*(c) + 1*(b)]->(u)
Al.b-Al.c;
#! (u)<-[-1*(c) + 1*(b)]-(v)
Ar.b-Ar.c;
#! (v)-[-1*(c) + 1*(b)]->(u)
Al.d - Al.d;
#! (w)<-[0]-(v)
Ar.d - Ar.d;
#! (v)-[0]->(w)
1/2 * Al.d;
#! (w)<-[1/2*(d)]-(v)
1/2 * Ar.d;
#! (v)-[1/2*(d)]->(w)
#! @EndExample

#! We can construct quotient categories

#! @Example
q:= RightQuiver( "q(1)[a:1->1]" );
#! q(1)[a:1->1]
Fq := FreeCategory( q );
#! FreeCategory( RightQuiver( "q(1)[a:1->1]" ) )
Q := HomalgFieldOfRationals( );
#! Q
A := Q[Fq];
#! Algebra( Q, FreeCategory( RightQuiver( "q(1)[a:1->1]" ) ) )
UnderlyingQuiverAlgebra( A );
#! Q * q
B := A / [ 2*A.a^3 - A.a^2  ];
#! Algebra( Q, FreeCategory( RightQuiver( "q(1)[a:1->1]" ) ) ) / relations
UnderlyingQuiverAlgebra( B );
#! (Q * q) / [ 2*(a*a*a) - 1*(a*a) ]
Dimension( B );
#! 3
C := B / [ B.a^2 + 2*B.a ];
#! Algebra( Q, FreeCategory( RightQuiver( "q(1)[a:1->1]" ) ) ) / relations
UnderlyingQuiverAlgebra( C );
#! (Q * q) / [ 2*(a*a*a) - 1*(a*a), 1*(a*a) + 2*(a) ]
Dimension( C );
#! 1
#! @EndExample

#! @EndChunk
