#   remplacer <complex.h> par <complex>
#   remplacer complex double par doublecomplex
#   remplacer Nmat par NMAT



import re
from pathlib import Path

# Macros à traiter
MACROS = [
    "GFORM_DEBUG",
    "GFORM",
    "GFORMDEF",
    "GFORM_FULL",
    "CFORM",
    "CFORM_FULL",
    "GFORM3V",
    "GFORM3L",
    "GFORM6L",
    "GFORM7L",
    "GFORM10L",
    "GFORMDEF3V",
    "CFORM3V",
    "MUEL_RMSE_FORMAT_FULL",
    "RESID_STRING",
    "F_CHP",
    "F_CHP_LOG", 
    "FFORM_PROG",
    "EFORM",
    "MUEL_HEADER",
    "RMSE_HEADER",
    "MUEL_FORMAT",
    "RMSE_FORMAT",
    "GFORMDEF",
    "F_AMPL",
    "AMPL_HEADER",
    "AMPL_FORMAT",
    "F_MUEL"
    "FFORMM",
    "F_AMPL_SG",
    "F_MUEL_SG",
    "FFORMM" ,
    "F_LOG_INT_CSCA",
    "F_LOG_INT_ASYM",
    "F_AMPL_SG",
    "PHI_HEADER",
    "ANGLE_FORMAT",
    "F_LOG_ORAVG",
    "F_CS",
    "F_MUEL",
    "ADDA_VERSION",
    "F_GRANS",
    "FD_ALLDIR_PARMS",
    "FD_CHP_DIR",
    "FD_AVG_PARMS",
    "FD_SCAT_PARMS",
    "COMPILER",
    "GFORM_RI_DIRNAME",
    "F_LOG",
    "F_LOG_ERR",
    "FFORMT",
]



# Regex précompilée pour chaque macro
patterns = {
    macro: re.compile(rf"\b{re.escape(macro)}\b")
    for macro in MACROS
}
########################################################
#      MACRO  ------->    b MACRO b    in *.cpp  and *.h
#########################################################
for cpp in Path(".").glob("*.cpp"):
    lines = cpp.read_text(encoding="utf-8", errors="ignore").splitlines(keepends=True)
    changed = False

    for i, line in enumerate(lines):
        # Ne jamais toucher aux #define
        if re.match(r"\s*#define\b", line):
            continue

        original = line
        for macro, pattern in patterns.items():
            line = pattern.sub(f" {macro} ", line)

        if line != original:
            lines[i] = line
            changed = True

    if changed:
        cpp.write_text("".join(lines), encoding="utf-8")
        print(f"modifié : {cpp.name}")



for cpp in Path(".").glob("*.h"):
    lines = cpp.read_text(encoding="utf-8", errors="ignore").splitlines(keepends=True)
    changed = False

    for i, line in enumerate(lines):
        # Ne jamais toucher aux #define
        if re.match(r"\s*#define\b", line):
            continue

        original = line
        for macro, pattern in patterns.items():
            line = pattern.sub(f" {macro} ", line)

        if line != original:
            lines[i] = line
            changed = True

    if changed:
        cpp.write_text("".join(lines), encoding="utf-8")
        print(f"modifié : {cpp.name}")



##################################################
#   add     #include "ccx.h"   in *.cpp  and *.h
###################################################


INCLUDE_LINE = '#include "ccx.h"\n'

for cpp_file in Path('.').rglob('*.cpp'):
    content = cpp_file.read_text(encoding='utf-8')

    # Évite les doublons
    if INCLUDE_LINE in content:
        continue

    cpp_file.write_text(INCLUDE_LINE + content, encoding='utf-8')
    print(f'Updated: {cpp_file}')

for cpp_file in Path('.').rglob('*.h'):
    content = cpp_file.read_text(encoding='utf-8')

    # Évite les doublons
    if INCLUDE_LINE in content:
        continue

    cpp_file.write_text(INCLUDE_LINE + content, encoding='utf-8')
    print(f'Updated: {cpp_file}')

###############################################
#   select  the doublecomplex type 
#   inhibit static keyword in array dimention 
###########################################

for cpp_file in Path(".").glob("*.cpp"):
    with open(cpp_file, "r", encoding="utf-8") as f:
        content = f.read()

    content = content.replace("#include <complex.h>", "//#include <complex.h>")  # <complex> or <complex.h> are included in cxx.h
    content = content.replace("complex double", "double__complex")  
    content = content.replace("[static ", "[STATIC ")   

    with open(cpp_file, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"Modifié : {cpp_file}")

    
for cpp_file in Path(".").glob("*.h"):
    with open(cpp_file, "r", encoding="utf-8") as f:
        content = f.read()

    # complex_.h is an empty header 
    content = content.replace("#include <complex.h>", "//#include <complex.h>")  # <complex> or <complex.h> are included in cxx.h
    
    content = content.replace("complex double", "double__complex")
    content = content.replace("[static ", "[STATIC ")

    with open(cpp_file, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"Modifié : {cpp_file}")


#####################################################################
#   parameter const must be the same in declaration and in extern  ...
########################################################################


for cpp_file in Path(".").glob("*.cpp"):
    with open(cpp_file, "r", encoding="utf-8") as f:
        content = f.read()

    # type const XXX and XXX are different type in C++

    content = content.replace("extern const double", "extern double")
    content = content.replace("extern const bool", "extern bool")
    content = content.replace("extern const int", "extern int")
    content = content.replace("extern const size_t", "extern size_t")
    content = content.replace("extern const enum", "extern enum")
     
    content = content.replace("extern const Parms_1D", "extern Parms_1D")
    content = content.replace("extern const angle_set", "extern angle_set")
    content = content.replace("extern const time_t chp_time", "extern time_t chp_time")
    content = content.replace("extern const opt_index", "extern opt_index")

    # very local correction
    content = content.replace("extern const int gr_N;", "extern size_t gr_N;")
    content = content.replace("if (ref_index[i]==1)", " if ( creal( ref_index[i])==1  &&  cimag( ref_index[i])==0)")
    #content = content.replace("   ", " ")
    content = content.replace("const char *ext;", "const char *ext=NULL; ")
    content = content.replace("const char *rf_text;", "const char *rf_text=NULL;")
    content = content.replace("double *vec;", "double *vec=NULL;")
    content = content.replace("doublecomplex vals[Nmat+1],", "doublecomplex vals[100], ")
    content = content.replace("[abs(besN)+3]", "[100]")
    content = content.replace("arg=besKt*sqrt(x*x+y*y);", "arg=creal(besKt)*sqrt(x*x+y*y);")

    content = content.replace("const char *tmp_str;", "const char *tmp_str=NULL;")
    content = content.replace("extern int gr_N;", "extern size_t gr_N;")
    content = content.replace("extern cont int gr_N;", "extern size_t gr_N;")
    content = content.replace("void propaespacelibreintadda_", "extern \"C\" void propaespacelibreintadda_ ")
    content = content.replace("void bjndd_", "extern \"C\" void bjndd_")
    content = content.replace("extern const char logfname[];", "extern char logfname[];")

    content = content.replace("fftw_plan_many_dft", "FFTW_PLAN_MANY_DFT")
    content = content.replace("fftw_plan_guru_dft", "FFTW_PLAN_GURU_DFT")
    
#content = content.replace("   ", " ")


    with open(cpp_file, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"Modifié : {cpp_file}")
