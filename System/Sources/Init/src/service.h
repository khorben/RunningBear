/* $Id: service.h,v 1.2 2008/11/09 23:13:54 khorben Exp $ */
/* Copyright (c) 2008 Pierre Pronchery <khorben@defora.org> */
/* This file is part of DeforaOS System Init */
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



#ifndef INIT_SERVICE_H
# define INIT_SERVICE_H

# include <System.h>
# include <sys/wait.h>


/* Service */
/* types */
typedef struct _Service Service;


/* functions */
Service * service_new(String const * name);
void service_delete(Service * service);

/* accessors */
String const * service_get_name(Service * service);

int service_has_pid(Service * service, pid_t pid);

/* useful */
int service_load(Service * service);
int service_restart(Service * service);
int service_start(Service * service);
int service_stop(Service * service);

#endif /* INIT_SERVICE_H */
