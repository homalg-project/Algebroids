#! @BeginChunk FpCategory

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

#! Create f.p. categories from these quivers.

#! @Example
Cl := FreeCategory( ql );
#! FreeCategory( LeftQuiver( "ql(u,v,w)[a:u->v,b:v->u,c:v->u,d:v->w]" ) )
Cr := FreeCategory( qr );
#! FreeCategory( RightQuiver( "qr(u,v,w)[a:u->v,b:v->u,c:v->u,d:v->w]" ) )
Cl.u;
#! <(u)>
Cr.u;
#! <(u)>
Cl.a;
#! (v)<-[(a)]-(u)
Cr.a;
#! (u)-[(a)]->(v)
SetOfObjects( Cl );
#! [ <(u)>, <(v)>, <(w)> ]
SetOfGeneratingMorphisms( Cl );
#! [ (v)<-[(a)]-(u), (u)<-[(b)]-(v), (u)<-[(c)]-(v), (w)<-[(d)]-(v) ]
SetOfGeneratingMorphisms( Cl, Cl.u, Cl.v );
#! [ (v)<-[(a)]-(u) ]
SetOfObjects( Cr );
#! [ <(u)>, <(v)>, <(w)> ]
SetOfGeneratingMorphisms( Cr );
#! [ (u)-[(a)]->(v), (v)-[(b)]->(u), (v)-[(c)]->(u), (v)-[(d)]->(w) ]
SetOfGeneratingMorphisms( Cr, Cr.u, Cr.v );
#! [ (u)-[(a)]->(v) ]
ObjectInFpCategory( Cl, ql.u ) = Cl.u;
#! true
Cl.u = ql.u / Cl;
#! true
MorphismInFpCategory( Cl, ql.a ) = Cl.a;
#! true
Cl.a = ql.a / Cl;
#! true
IdentityMorphism( Cl.u );
#! (u)<-[(u)]-(u)
IdentityMorphism( Cr.u );
#! (u)-[(u)]->(u)
#! @EndExample

#! We can compute in the algebroids.
#! For instance we can form compositions.

#! @Example
PreCompose( Cl.a, Cl.d );
#! (w)<-[(d*a)]-(u)
PreCompose( Cr.a, Cr.d );
#! (u)-[(a*d)]->(w)
#! @EndExample

#! We can construct quotient categories

#! @Example
q:= RightQuiver( "q(1)[a:1->1]" );
#! q(1)[a:1->1]
Fq := FreeCategory( q );
#! FreeCategory( RightQuiver( "q(1)[a:1->1]" ) )
C := Fq / [ [ Fq.a^3, Fq.a^2 ] ];
#! FreeCategory( RightQuiver( "q(1)[a:1->1]" ) ) / [ a*a*a = a*a ]
UnderlyingQuiverAlgebra( C );
#! (Q * q) / [ 1*(a*a*a) - 1*(a*a) ]
Size( C );
#! 3
D := C / [ [ C.a^9, C.1 ] ];
#! FreeCategory( RightQuiver( "q(1)[a:1->1]" ) ) /
#! [ a*a*a = a*a, a*a = 1 ]
UnderlyingQuiverAlgebra( D );
#! (Q * q) / [ 1*(a) - 1*(1) ]
Size( D );
#! 1
#! @EndExample

#! @EndChunk
