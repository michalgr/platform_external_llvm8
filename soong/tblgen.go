// Copyright (C) 2016 The Android Open Source Project
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package llvm8

import (
	"path/filepath"
	"strings"

	"android/soong/android"

	"github.com/google/blueprint"
	"github.com/google/blueprint/proptools"
)

func init() {
	android.RegisterModuleType("llvm8_tblgen", llvm8TblgenFactory)
}

var (
	pctx = android.NewPackageContext("android/soong/external/llvm8")
	llvm8Tblgen = pctx.HostBinToolVariable("llvm8Tblgen", "llvm8_tblgen")
	llvm8TblgenRule = pctx.StaticRule("tblgenRule", blueprint.RuleParams{
		Depfile:     "${out}.d",
		Deps:        blueprint.DepsGCC,
		Command:     "${llvm8Tblgen} ${includes} ${genopt} -d ${depfile} -o ${out} ${in}",
		CommandDeps: []string{"${llvm8Tblgen}"},
		Description: "LLVM8 TableGen $in => $out",
	}, "includes", "depfile", "genopt")
)

type tblgenProperties struct {
	In         *string
	Out        *string
	Generators *string
}

type tblgen struct {
	android.ModuleBase
	properties tblgenProperties

        generatedHeaderDir android.Path
        generatedHeader android.Path
}

func (t *tblgen) GenerateAndroidBuildActions(ctx android.ModuleContext) {
	in := android.PathForModuleSrc(ctx, proptools.String(t.properties.In))
        out := android.PathForModuleGen(ctx, proptools.String(t.properties.Out))

	includes := []string{
		"-I external/llvm8/include",
		"-I " + filepath.Dir(in.String()),
	}

	ctx.ModuleBuild(pctx, android.ModuleBuildParams{
		Rule:   llvm8TblgenRule,
		Input:  in,
		Output: out,
		Args: map[string]string{
			"includes": strings.Join(includes, " "),
			"genopt":   proptools.String(t.properties.Generators),
		},
	})

        t.generatedHeaderDir = android.PathForModuleGen(ctx, "")
        t.generatedHeader = out
}

func (t *tblgen) DepsMutator(ctx android.BottomUpMutatorContext) {
}

func (t *tblgen) GeneratedHeaderDirs() android.Paths {
	return android.Paths {
		t.generatedHeaderDir,
	}
}

func (t *tblgen) GeneratedSourceFiles() android.Paths {
	return nil
}

func (t *tblgen) GeneratedDeps() android.Paths {
	return android.Paths {
		t.generatedHeader,
	}
}

func llvm8TblgenFactory() android.Module {
	t := &tblgen{}
	t.AddProperties(&t.properties)
	android.InitAndroidModule(t)
	return t
}
