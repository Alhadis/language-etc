# define([def], ine)
int tab[10];
[int tab[10];]

AC_INIT ([oops], [1.0]) # incorrect
AC_INIT([hello], [1.0]) # good

AC_CHECK_HEADER([stdio.h],
	[AC_DEFINE([HAVE_STDIO_H], [1],
		[Define to 1 if you have <stdio.h>.])],
	[AC_MSG_ERROR([sorry, can't do anything for you])])

AC_CHECK_HEADER([stdio.h],
	[AC_DEFINE([HAVE_STDIO_H], 1,
		[Define to 1 if you have <stdio.h>.])],
	[AC_MSG_ERROR([sorry, can't do anything for you])])
