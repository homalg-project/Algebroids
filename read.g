# SPDX-License-Identifier: GPL-2.0-or-later
# Algebroids: Algebroids and bialgebroids as preadditive categories generated by enhanced quivers
#
# Reading the implementation part of the package.
#

ReadPackage( "Algebroids", "gap/precompiled_categories/AdditiveClosureOfAlgebroidOfFiniteDimensionalPathAlgebraOfRightQuiverOverFieldPrecompiled.gi" );
ReadPackage( "Algebroids", "gap/precompiled_categories/AdditiveClosureOfAlgebroidOfFiniteDimensionalQuotientOfPathAlgebraOfRightQuiverOverFieldPrecompiled.gi" );
ReadPackage( "Algebroids", "gap/precompiled_categories/AdditiveClosureOfAlgebroidOfFiniteDimensionalPathAlgebraOfRightQuiverOverZPrecompiled.gi" );
ReadPackage( "Algebroids", "gap/precompiled_categories/AdditiveClosureOfAlgebroidOfFiniteDimensionalQuotientOfPathAlgebraOfRightQuiverOverZPrecompiled.gi" );

ReadPackage( "Algebroids", "gap/precompiled_categories/AdelmanCategoryOfAdditiveClosureOfAlgebroidOfFiniteDimensionalPathAlgebraOfRightQuiverOverZPrecompiled.gi" );

ReadPackage( "Algebroids", "gap/FpCategories.gi");
ReadPackage( "Algebroids", "gap/Algebroids.gi");
ReadPackage( "Algebroids", "gap/QPA2.gi");
ReadPackage( "Algebroids", "gap/Functors.gi");
ReadPackage( "Algebroids", "gap/CategoryOfAlgebroids.gi");
ReadPackage( "Algebroids", "gap/Bialgebroids.gi");
ReadPackage( "Algebroids", "gap/SimplicialCategory.gi");
ReadPackage( "Algebroids", "gap/Tools.gi");

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "Algebroids", "gap/Julia.gi" );
fi;
