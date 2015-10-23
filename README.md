## TinyVM

A simple VM to play with LLVM's MCJIT compiler and exercise a new OSR technique.
```diff
pctips@xubuntu64:~/OSR$ ./tinyvm
Welcome! Enter 'HELP' to show the list of available commands.
TinyVM> HELP
List of available commands:
--> BEGIN <module_name>
	Type an IR module (from stdin). Press CTRL-D when finished.
--> CFG <function_name>
	Show a compact view of the CFG of a given function.
--> CFG_FULL <function_name>
	Show the CFG (with instructions) of a given function.
--> CLONE_FUN <function_name> AS <clone_name>
	Clone a given function and generate a StateMap for the two functions.
--> DUMP [<function_name> | <module_name>]
	Show the IR code of a given function or module.
--> INSERT_OSR <...>
	Insert an OSR point in a function.
	Enter HELP INSERT_OSR to find out the syntax.
--> LOAD_IR <file_name>
	Load an IR module from a given file.
--> LOAD_LIB <file_name>
	Load the dynamic library at the given path.
--> OPT <function_name> { <opt1> ... }
	Perform optimization passes on a given function.
	Enter HELP OPT to find out which optimizations are supported.
--> OPT_CFG <function_name>
	Perform a CFG simplification pass over a given function.
--> OPT_FULL <function_name>
	Perform several optimization passes over a given function.
--> REPEAT <iterations> <function call>
	Perform a function call (see next paragraph) repeatedly.
--> SHOW_ADDR <function_name>
	Show compiled-code address for a given function symbol.
--> SHOW_ASM
	Show logged x86-64 assembly code.
--> SHOW_FUNS
	Show function symbols tracked by MCJITHelper.
--> SHOW_LINE_IDS <function_name>
	Show by-line IR identifiers for a given function.
--> SHOW_MAPS
	Show registered StateMap objects.
--> SHOW_MODS
	Show loaded modules and their symbols.
--> TRACK_ASM
	Enable/disable logging of generated x86-64 assembly code.
--> VERBOSE
	Enable/disable verbose mode.
--> QUIT
	Exits TinyVM.

The TinyVM command line supports the invocation of loaded functions. Functions
can be invoked as in C, except for the final semi-colon that must not be added.
For the time being, only functions with integer arguments and return values are
supported.
TinyVM> HELP INSERT_OSR
OSR points can be inserted with one of the following commands:
--> INSERT_OSR <PROB> <COND> OPEN UPDATE IN <F1> AT <P1> CLONE
--> INSERT_OSR <PROB> <COND> OPEN COPY IN <F1> AT <P1> AS <F1'> CLONE
--> INSERT_OSR <PROB> <COND> OPEN UPDATE IN <F1> AT <P1> DYN_INLINE <V1>
--> INSERT_OSR <PROB> <COND> OPEN COPY IN <F1> AT <P1> AS <F1'> DYN_INLINE <V1>
--> INSERT_OSR <PROB> <COND> SLVD UPDATE IN <F1> AT <P1> TO <F2> AT <P2> AS <F2'>
--> INSERT_OSR <PROB> <COND> SLVD COPY IN <F1> AT <P1> AS <F1'> TO <F2> AT <P2> AS <F2'>

where:
	PROB is either -1 (no branch weight) or an integer in {0, ..., 100}
	COND is either ALWAYS or NEVER
	F1 and F2 are existing functions
	P1 and P2 are locations in F1 and F2 respectively
	V1 is the target of one or more calls in F1

The command can either update F1 or generate a new function F1' cloning F1 such
that when P1 is reached during the execution, an OSR transition is fired.

For OPEN transitions, a continuation function C is generated at run-time.
In CLONE mode, C is generated by cloning and manipulating F1 to resume the
execution at P1. In DYN_INLINE mode, C is generated as in clone mode, then a
dynamic inliner attempts to inline calls whose target is contained in V1.

For SLVD transitions, a continuation function F2' is statically generated from
F2 to resume the execution at P2.

Program locations can be expressed using an LLVM '%name' (including numerical
IDs for anonymous values) or a line ID '$i' reported by SHOW_LINE_IDS. For basic
block locations OSR points are inserted before the first non-PHI instruction.
TinyVM> HELP OPT
Syntax:
    OPT <function_name> { <opt1> <opt2> ... << <optN> }

List of OSR-compatible implemented function passes:
--> ADCE
	Aggressive dead code elimination (assume dead unless proved otherwise).
--> ConstProp
	Simple constant propagation (for instructions with constant operands).
--> DCE
	Dead code elimination.
--> EarlyCSE
	Remove trivially redundant instructions with a dominator tree walk.
--> LCSSA
	Transform loops into loop-closed SSA form.
--> LICM
	Loop-invariant code motion (hoist & sink).
--> LoopSimplify
	Canonicalize natural loops.
--> SCCP
	Sparse conditional constant propagation.
--> Sink
	Sink instructions into successor blocks.
TinyVM>
```
