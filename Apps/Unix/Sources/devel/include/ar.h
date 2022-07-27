/* $Id: ar.h,v 1.1 2008/08/28 22:17:40 khorben Exp $ */
/* Copyright (c) 2008 Pierre Pronchery <khorben@defora.org> */
/* This file is part of RunningBear Unix devel */
/* This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>. */



#ifndef AR_AR_H
# define AR_AR_H


/* types */
struct ar_hdr
{
	char ar_name[16];
	char ar_date[12];
	char ar_uid[6];
	char ar_gid[6];
	char ar_mode[8];
	char ar_size[10];
	char ar_fmag[2];
};


/* constants */
# define ARMAG		"!<arch>\n"
# define SARMAG		8
# define ARFMAG		"`\n"

#endif /* AR_AR_H */
