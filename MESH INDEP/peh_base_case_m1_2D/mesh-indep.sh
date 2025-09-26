#!/encs/bin/tcsh

#SBATCH --job-name=peh_mesh_indep
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=00-12:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=d_akrivo@live.concordia.ca
#SBATCH --export=ALL,hv=100
#SBATCH --mem=75G


module load OpenFOAM/v2012/default
setenv TMPDIR /speed-scratch/$USER/tmp
setenv PATH /encs/pkg/openmpi-4.1.6/root/bin\:$PATH
setenv LD_LIBRARY_PATH $LD_LIBRARY_PATH\:/encs/pkg/openmpi-4.1.6/root/lib64
setenv CORES $SLURM_NTASKS
setenv OMP_NUM_THREADS $CORES

blockMesh
decomposePar -force
mpirun -np $CORES simpleFoam -parallel
reconstructPar

cd ../peh_base_case_m2_2D/

blockMesh
decomposePar -force
mpirun -np $CORES simpleFoam -parallel
reconstructPar

cd ../peh_base_case_m3_2D/

blockMesh
decomposePar -force
mpirun -np $CORES simpleFoam -parallel
reconstructPar