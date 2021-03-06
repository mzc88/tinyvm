/* ===============================================================
 * A simple memory manager for LLVM's ExecutionEngine.
 *
 * Author:      (C) 2015 Daniele Cono D'Elia
 * License:     See the end of this file for license information
 * =============================================================== */
#include "CustomMemoryManager.hpp"
#include "MCJITHelper.hpp"

#include <llvm/Support/ErrorHandling.h>

#include <iostream>
#include <string>

void* CustomMemoryManager::getPointerToNamedFunction(const std::string &Name, bool AbortOnFailure) {
    // try standard symbol resolution
    void *ptr = SectionMemoryManager::getPointerToNamedFunction(Name, false);

    #if 0
    if (ptr) return ptr;

    ptr = (void*)TheMCJITHelper->JIT->getFunctionAddress(Name);
    #endif
    if (!ptr && AbortOnFailure) {
        std::string errMsg = "Could not get pointer to named function ";
        errMsg.append(Name);
        llvm::report_fatal_error(errMsg);
    }
    #if 0
        else {
        std::cerr << "Symbol solved using CMM" << std::endl;
    }
    #endif

    return ptr;
}

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