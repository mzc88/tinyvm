#ifndef TINYVM_MCJITHELPER_H
#define TINYVM_MCJITHELPER_H

#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/JITEventListener.h"
#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/ExecutionEngine/SectionMemoryManager.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/Transforms/Utils/ValueMapper.h"

#include <string>
#include <vector>

#include "CustomMemoryManager.hpp"
#include "OSRLibrary.hpp"
#include "StackMap.hpp"

using namespace llvm;

class MCJITHelper {
public:
    MCJITHelper(LLVMContext &C, std::unique_ptr<Module> InitialModule) : Context(C),
                    trackAsmCode(false), asmFdStream(nullptr), asmFileName("session.asm") {
        if (InitialModule == nullptr) {
            // unfortunately we need a module for EngineBuilder (TODO: check again)
            InitialModule = llvm::make_unique<Module>("empty", Context);
        }

        Listeners.push_back(new StackMapJITEventListener(&StackMaps)); // TODO use a shared_ptr instead?

        std::unique_ptr<CustomMemoryManager> MemoryManager(new CustomMemoryManager(this));
        std::string ErrStr;
        JIT = EngineBuilder(std::move(InitialModule))
                            .setEngineKind(EngineKind::JIT)
                            .setErrorStr(&ErrStr)
                            .setMCJITMemoryManager(std::move(MemoryManager))
                            .create();

        for (JITEventListener* L: Listeners) {
            JIT->RegisterJITEventListener(L);
        }
        Builder = new IRBuilder<>(Context);
    }
    ~MCJITHelper();

    // public members
    ExecutionEngine *JIT;

    // public methods
    void addModule(std::unique_ptr<Module> M, bool OptimizeModule = false);
    void createAndAddModuleForFunction(Function* F, bool OptimizeFunction = false,
                    bool analyzeCallsToExternalFunctions = false, bool analyzeAccessesToGlobals = false);
    std::unique_ptr<Module> createModuleFromFile(const std::string &FileName);
    void* getPointerToNamedFunction(const std::string &Name);
    Function* getFunction(const std::string &Name);
    int (*createAnonymousFunctionForCall(const std::string &FunctionName, std::vector<int> &Arguments))();
    bool toggleTrackAsm();
    void showTrackedAsm();
    void addSymbols(Module* M);
    void showSymbols();
    CmpInst* generateAlwaysTrueCond();
    ValueToValueMapTy* generateIdentityMapping(Function* F);
    static void* identityGeneratorForOpenOSR(OSRLibrary::RawOpenOSRInfo *info, void* profDataAddr);

private:
    LLVMContext                     &Context;
    IRBuilder<>                     *Builder;
    std::vector<StackMap*>          StackMaps;
    std::vector<JITEventListener*>  Listeners;
    std::vector<std::pair<std::string, std::vector<std::string>>>  Symbols;
    bool            trackAsmCode;
    raw_ostream     *asmFdStream;
    const char      *asmFileName;

    raw_ostream* initializeFdStream(const char* fileName);
};

#endif
