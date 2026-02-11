# =========================
# CONFIGURATION
# =========================

FC      = gfortran
AR      = ar
ARFLAGS = rcs

FFLAGS  = -O3 -fPIC

LIBNAME = adda_fortran
TARGET  = lib$(LIBNAME).a

# Répertoire des objets
BUILDDIR = build

# =========================
# SOURCES
# =========================

SRC = \
    cfft99D.f \
    d07hre.f \
    d09hre.f \
    d113re.f \
    d132re.f \
    dadhre.f \
    dchhre.f \
    dcuhre.f \
    dfshre.f \
    dinhre.f \
    drlhre.f \
    dtrhre.f \
    propaesplibreintadda.f \
    bessel.f90

# Objets dans build/
OBJ = $(addprefix $(BUILDDIR)/, $(SRC:.f=.o))
OBJ := $(OBJ:.f90=.o)

# =========================
# RÈGLES
# =========================

.PHONY: all clean

all: $(TARGET)

# Création de la librairie statique
$(TARGET): $(OBJ)
	$(AR) $(ARFLAGS) $@ $^

# Création du répertoire build si besoin
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# Fortran 77
$(BUILDDIR)/%.o: %.f | $(BUILDDIR)
	$(FC) $(FFLAGS) -c $< -o $@

# Fortran 90
$(BUILDDIR)/%.o: %.f90 | $(BUILDDIR)
	$(FC) $(FFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILDDIR) $(TARGET)




