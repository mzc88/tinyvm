/* ===============================================================
 * A simple parser for TinyVM's command line.
 *
 * Author:      (C) 2015 Daniele Cono D'Elia
 * License:     See the end of this file for license information
 * =============================================================== */

#ifndef TINYVM_PARSER_H
#define TINYVM_PARSER_H

#include "Lexer.hpp"
#include "MCJITHelper.hpp"

class Parser {
public:
    Parser(Lexer* L, MCJITHelper* H) : TheLexer(L), TheHelper(H) {}
    void start(bool displayHelpMessage = true);

private:
    Lexer       *TheLexer;
    MCJITHelper *TheHelper;

    // simple auxiliary methods
    void handleBeginCommand();
    void handleDumpCommand();
    void handleFunctionInvocation(int iterations);
    void handleHelpCommand();
    void handleInsertOSRCommand();
    void handleLoadIRCommand();
    void handleLoadLibCommand();
    void handleRepeatCommand();
    void handleShowAddrCommand();
    void handleShowCFGCommand(bool showInstructions);
    void handleTrackAsmCommand();
    void handleInsertOpenOSRCommand();
    void handleOptCommand(bool CFGSimplificationOnly);

    void openOSRHelper(Function* src, BasicBlock* src_bb, bool update,
            std::string* F1NewName, OSRLibrary::OSRCond &cond, int branchTakenProb);
    void finalizedOSRHelper(Function* src, BasicBlock* src_bb, bool update,
            std::string* F1NewName, const std::string* F2Name, const std::string* B2Name,
            std::string* F2NewName, OSRLibrary::OSRCond &cond, int branchTakenProb);
};

#endif

/*
 * OSR library for LLVM. Copyright (C) 2015 Daniele Cono D'Elia
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 3 of the License, or (at your option) any
 * later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
*/