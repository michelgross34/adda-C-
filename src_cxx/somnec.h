#include "ccx.h"
/* Header for calculation of Sommerfeld integrals
 *
 * Copyright (C) ADDA contributors
 * This file is part of ADDA, but can also be used separately.
 *
 * ADDA is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * ADDA is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with ADDA. If not, see
 * <http://www.gnu.org/licenses/>.
 */
#ifndef __somnec_h
#define __somnec_h

// system headers
#ifdef __STDC_NO_COMPLEX__
#	error "Support of C99-type complex numbers is strictly required."
#endif
/* ADDA uses doublecomplex macro instead of standard 'double__complex', but we use the latter in somnec.c/h to
 * keep them standalone
 */
//#include <complex.h>

void som_init(double__complex epscf);
void evlua(double zphIn,double rhoIn,double__complex *erv,double__complex *ezv,double__complex *erh,double__complex *eph,
	int mode);

#endif // __somnec_h
