::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:
:  !!!! Do NOT edit this file directly! -- Edit devel/mkppport_fnc.pl instead. !!!!
:
:  Perl/Pollution/Portability
:
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:
:  Version 3.x, Copyright (C) 2004-2013, Marcus Holland-Moritz.
:  Version 2.x, Copyright (C) 2001, Paul Marquess.
:  Version 1.x, Copyright (C) 1999, Kenneth Albanowski.
:
:  This program is free software; you can redistribute it and/or
:  modify it under the same terms as Perl itself.
:
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:
: This file lists all API functions/macros that are provided purely
: by Devel::PPPort, or that are unXXX It is in the same format as the F<embed.fnc> that
: ships with the Perl source code.
:
: Since these are used only to provide the argument types, it's ok to have the
: return value be void for some where it's an issues

Amn|void|aTHXR
Amn|void|aTHXR_
md|int|AvFILLp|AV* av
Amn|void|DEFSV
Amn|void|dMY_CXT_SV
Amn|void|dNOOP
Amn|void|dTHXR
Amn|void|dXSTARG
Amn|void|END_EXTERN_C
Amn|void|EXTERN_C
Amn|void|GV_NOADD_MASK
Amn|void|IN_PERL_COMPILETIME
Amn|void|NOOP
Amn|void|PERL_BCDVERSION
Amn|void|PERL_LOADMOD_DENY
Amn|void|PERL_LOADMOD_IMPORT_OPS
Amn|void|PERL_LOADMOD_NOIMPORT
Amn|void|PERL_MAGIC_glob
Amn|void|PERL_MAGIC_mutex
Amn|void|PERL_MAGIC_overload
Amn|void|PERL_MAGIC_overload_elem
Amn|void|PERL_PV_PRETTY_DUMP
Amn|void|PERL_PV_PRETTY_NOCLEAR
Amn|void|PERL_PV_PRETTY_REGPROP
Amn|void|PERL_SIGNALS_UNSAFE_FLAG
Amn|void|PERL_UINT_MIN
Amn|void|PERL_UNUSED_CONTEXT
Amn|void|PERL_UNUSED_DECL
Amn|void|PERL_USE_GCC_BRACE_GROUPS
Amn|void|PL_bufend
Amn|void|PL_bufptr
Amn|void|PL_compiling
Amn|void|PL_copline
Amn|void|PL_DBsignal
mnd|SV *|PL_DBsingle
mnd|GV *|PL_DBsub
mnd|SV *|PL_DBtrace
Amn|void|PL_debstash
Amn|void|PL_diehook
Amn|void|PL_dirty
mnd|U8|PL_dowarn
Amn|void|PL_error_count
Amn|void|PL_expect
Amn|void|PL_hexdigit
Amn|void|PL_hints
Amn|void|PL_in_my
Amn|void|PL_in_my_stash
Amn|void|PL_laststatval
Amn|void|PL_lex_state
Amn|void|PL_lex_stuff
Amn|void|PL_linestr
Amn|void|PL_mess_sv
Amn|void|PL_no_modify
Amn|void|PL_perldb
Amn|void|PL_ppaddr
Amn|void|PL_rsfp
Amn|void|PL_rsfp_filters
Amn|void|PL_stack_base
Amn|void|PL_stack_sp
Amn|void|PL_statcache
Amn|void|PL_stdingv
Amn|void|PL_Sv
Amn|void|PL_sv_arenaroot
Amn|void|PL_tainted
Amn|void|PL_tainting
Amn|void|PL_tokenbuf
Amn|void|PTRV
Amn|void|SAVE_DEFSV
Amn|void|START_EXTERN_C
Amn|void|SV_CONST_RETURN
Amn|void|SV_COW_SHARED_HASH_KEYS
Amn|void|SVf
Am|void|sv_magic_portable|NN SV* sv|NULLOK SV* obj|int how|NULLOK const char* name|I32 namlen
Amn|void|SV_MUTABLE_RETURN
Amn|void|SV_UTF8_NO_ENCODING
Amn|void|WARN_ASSERTIONS
Amn|void|XSprePUSH
