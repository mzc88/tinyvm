; ModuleID = 'codeQuality.ll'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.amino_acid = type { i8, float, float }

@outStream = common global %struct._IO_FILE* null, align 8
@amino_acid_orig = global [15 x %struct.amino_acid] [%struct.amino_acid { i8 97, float 0x3FD147AE20000000, float 0.000000e+00 }, %struct.amino_acid { i8 99, float 0x3FBEB851E0000000, float 0.000000e+00 }, %struct.amino_acid { i8 103, float 0x3FBEB851E0000000, float 0.000000e+00 }, %struct.amino_acid { i8 116, float 0x3FD147AE20000000, float 0.000000e+00 }, %struct.amino_acid { i8 66, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 68, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 72, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 75, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 77, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 78, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 82, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 83, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 86, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 87, float 0x3F947AE140000000, float 0.000000e+00 }, %struct.amino_acid { i8 89, float 0x3F947AE140000000, float 0.000000e+00 }], align 16
@homo_sapiens_orig = global [4 x %struct.amino_acid] [%struct.amino_acid { i8 97, float 0x3FD3639D20000000, float 0.000000e+00 }, %struct.amino_acid { i8 99, float 0x3FC957AE40000000, float 0.000000e+00 }, %struct.amino_acid { i8 103, float 0x3FC9493AE0000000, float 0.000000e+00 }, %struct.amino_acid { i8 116, float 0x3FD34BEE40000000, float 0.000000e+00 }], align 16
@.str = private unnamed_addr constant [19 x i8] c"fasta-redux-%d.txt\00", align 1
@.str1 = private unnamed_addr constant [3 x i8] c"w+\00", align 1
@amino_acid = common global [15 x %struct.amino_acid] zeroinitializer, align 16
@homo_sapiens = common global [4 x %struct.amino_acid] zeroinitializer, align 16
@alu = internal constant [288 x i8] c"GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGGGAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGACCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAATACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCAGCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGGAGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCCAGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA\00", align 16
@.str2 = private unnamed_addr constant [23 x i8] c">ONE Homo sapiens alu\0A\00", align 1
@.str3 = private unnamed_addr constant [26 x i8] c">TWO IUB ambiguity codes\0A\00", align 1
@.str4 = private unnamed_addr constant [31 x i8] c">THREE Homo sapiens frequency\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @random_init(i32* nocapture %random) #0 {
  store i32 42, i32* %random, align 4
  ret void
}

; Function Attrs: nounwind uwtable
define void @repeat(i8* nocapture readonly %alu, i8* %title, i32 %n) #0 {
  %1 = tail call i64 @strlen(i8* %alu) #6
  %2 = trunc i64 %1 to i32
  %3 = add i64 %1, 60
  %4 = and i64 %3, 4294967295
  %5 = alloca i8, i64 %4, align 16
  %sext = shl i64 %1, 32
  %6 = ashr exact i64 %sext, 32
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %alu, i64 %6, i32 1, i1 false)
  %7 = getelementptr inbounds i8* %5, i64 %6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* %alu, i64 60, i32 1, i1 false)
  %8 = load %struct._IO_FILE** @outStream, align 8
  %9 = tail call i32 (i8*, %struct._IO_FILE*, ...)* bitcast (i32 (...)* @fputs_unlocked to i32 (i8*, %struct._IO_FILE*, ...)*)(i8* %title, %struct._IO_FILE* %8) #2
  %10 = icmp sgt i32 %n, 0
  br i1 %10, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %pos.02 = phi i32 [ %pos.1, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %.01 = phi i32 [ %22, %.lr.ph ], [ %n, %.lr.ph.preheader ]
  %11 = icmp sgt i32 %.01, 60
  %..0 = select i1 %11, i32 60, i32 %.01
  %12 = sext i32 %pos.02 to i64
  %13 = getelementptr inbounds i8* %5, i64 %12
  %14 = sext i32 %..0 to i64
  %15 = load %struct._IO_FILE** @outStream, align 8
  %16 = call i64 @fwrite_unlocked(i8* %13, i64 %14, i64 1, %struct._IO_FILE* %15) #2
  %17 = add nsw i32 %..0, %pos.02
  %18 = icmp sgt i32 %17, %2
  %19 = select i1 %18, i32 %2, i32 0
  %pos.1 = sub nsw i32 %17, %19
  %20 = load %struct._IO_FILE** @outStream, align 8
  %21 = call i32 @fputc_unlocked(i32 10, %struct._IO_FILE* %20) #2
  %22 = sub nsw i32 %.01, %..0
  %23 = icmp sgt i32 %22, 0
  br i1 %23, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

declare i32 @fputs_unlocked(...) #3

declare i64 @fwrite_unlocked(i8*, i64, i64, %struct._IO_FILE*) #3

declare i32 @fputc_unlocked(i32, %struct._IO_FILE*) #3

; Function Attrs: nounwind uwtable
define noalias i8* @fill_lookup(%struct.amino_acid** nocapture %lookup, %struct.amino_acid* %amino_acid, i32 %amino_acid_size) #0 {
  %1 = icmp sgt i32 %amino_acid_size, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %2 = add i32 %amino_acid_size, -1
  br label %3

; <label>:3                                       ; preds = %3, %.lr.ph
  %indvars.iv7 = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next8, %3 ]
  %p.03 = phi float [ 0.000000e+00, %.lr.ph ], [ %6, %3 ]
  %4 = getelementptr inbounds %struct.amino_acid* %amino_acid, i64 %indvars.iv7, i32 1
  %5 = load float* %4, align 4
  %6 = fadd float %p.03, %5
  %7 = fmul float %6, 4.095000e+03
  %8 = getelementptr inbounds %struct.amino_acid* %amino_acid, i64 %indvars.iv7, i32 2
  store float %7, float* %8, align 4
  %indvars.iv.next8 = add nuw nsw i64 %indvars.iv7, 1
  %lftr.wideiv = trunc i64 %indvars.iv7 to i32
  %exitcond9 = icmp eq i32 %lftr.wideiv, %2
  br i1 %exitcond9, label %._crit_edge.loopexit, label %3

._crit_edge.loopexit:                             ; preds = %3
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %9 = add nsw i32 %amino_acid_size, -1
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds %struct.amino_acid* %amino_acid, i64 %10, i32 2
  store float 4.095000e+03, float* %11, align 4
  br label %.preheader

.preheader:                                       ; preds = %19, %._crit_edge
  %indvars.iv5 = phi i64 [ 0, %._crit_edge ], [ %indvars.iv.next6, %19 ]
  %j.02 = phi i64 [ 0, %._crit_edge ], [ %indvars.iv.lcssa, %19 ]
  %12 = trunc i64 %indvars.iv5 to i32
  %13 = sitofp i32 %12 to float
  %sext = shl i64 %j.02, 32
  %14 = ashr exact i64 %sext, 32
  br label %15

; <label>:15                                      ; preds = %15, %.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %15 ], [ %14, %.preheader ]
  %16 = getelementptr inbounds %struct.amino_acid* %amino_acid, i64 %indvars.iv, i32 2
  %17 = load float* %16, align 4
  %18 = fcmp olt float %17, %13
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  br i1 %18, label %15, label %19

; <label>:19                                      ; preds = %15
  %indvars.iv.lcssa = phi i64 [ %indvars.iv, %15 ]
  %20 = getelementptr inbounds %struct.amino_acid* %amino_acid, i64 %indvars.iv.lcssa
  %21 = getelementptr inbounds %struct.amino_acid** %lookup, i64 %indvars.iv5
  store %struct.amino_acid* %20, %struct.amino_acid** %21, align 8
  %indvars.iv.next6 = add nuw nsw i64 %indvars.iv5, 1
  %exitcond = icmp eq i64 %indvars.iv.next6, 4096
  br i1 %exitcond, label %22, label %.preheader

; <label>:22                                      ; preds = %19
  ret i8* null
}

; Function Attrs: nounwind uwtable
define void @randomize(%struct.amino_acid* %amino_acid, i32 %amino_acid_size, i8* %title, i32 %n, i32* nocapture %rand) #0 {
entry:
  %lookup = alloca [4096 x %struct.amino_acid*], align 16
  %line_buffer = alloca [61 x i8], align 16
  %v1 = getelementptr inbounds [61 x i8]* %line_buffer, i64 0, i64 60
  store i8 10, i8* %v1, align 4
  %v2 = getelementptr inbounds [4096 x %struct.amino_acid*]* %lookup, i64 0, i64 0
  %v3 = call i8* @fill_lookup(%struct.amino_acid** %v2, %struct.amino_acid* %amino_acid, i32 %amino_acid_size)
  %v4 = load %struct._IO_FILE** @outStream, align 8
  %v5 = tail call i32 (i8*, %struct._IO_FILE*, ...)* bitcast (i32 (...)* @fputs_unlocked to i32 (i8*, %struct._IO_FILE*, ...)*)(i8* %title, %struct._IO_FILE* %v4) #2
  %v71 = icmp sgt i32 %n, 0
  br i1 %v71, label %B8.lr.ph, label %B38

B8.lr.ph:                                         ; preds = %entry
  %v11 = getelementptr inbounds [61 x i8]* %line_buffer, i64 0, i64 0
  %0 = add i32 %n, -1
  br label %B8

B8:                                               ; preds = %B30, %B8.lr.ph
  %j.03 = phi i32 [ 0, %B8.lr.ph ], [ %v37, %B30 ]
  %i.02 = phi i32 [ 0, %B8.lr.ph ], [ %v36, %B30 ]
  %v9 = icmp eq i32 %j.03, 60
  br i1 %v9, label %B10, label %B14

B10:                                              ; preds = %B8
  %v12 = load %struct._IO_FILE** @outStream, align 8
  %v13 = call i64 @fwrite_unlocked(i8* %v11, i64 61, i64 1, %struct._IO_FILE* %v12) #2
  br label %B14

B14:                                              ; preds = %B10, %B8
  %j.1 = phi i32 [ 0, %B10 ], [ %j.03, %B8 ]
  %v15 = call fastcc float @random_next_lookup(i32* %rand)
  %v16 = fptosi float %v15 to i16
  %v17 = sext i16 %v16 to i64
  %v18 = getelementptr inbounds [4096 x %struct.amino_acid*]* %lookup, i64 0, i64 %v17
  %v19 = load %struct.amino_acid** %v18, align 8
  br label %B20

B20:                                              ; preds = %B20, %B14
  %u.0 = phi %struct.amino_acid* [ %v19, %B14 ], [ %v29, %B20 ]
  %v21 = getelementptr inbounds %struct.amino_acid* %u.0, i64 0, i32 2
  %v22 = load float* %v21, align 4
  %v23 = fcmp olt float %v22, %v15
  %v29 = getelementptr inbounds %struct.amino_acid* %u.0, i64 1
  br i1 %v23, label %B20, label %B30, !prof !1

B30:                                              ; preds = %B20
  %u.0.lcssa = phi %struct.amino_acid* [ %u.0, %B20 ]
  %v31 = getelementptr inbounds %struct.amino_acid* %u.0.lcssa, i64 0, i32 0
  %v32 = load i8* %v31, align 1
  %v33 = sext i32 %j.1 to i64
  %v34 = getelementptr inbounds [61 x i8]* %line_buffer, i64 0, i64 %v33
  store i8 %v32, i8* %v34, align 1
  %v36 = add nuw nsw i32 %i.02, 1
  %v37 = add nsw i32 %j.1, 1
  %exitcond = icmp eq i32 %i.02, %0
  br i1 %exitcond, label %B38.loopexit, label %B8

B38.loopexit:                                     ; preds = %B30
  %v37.lcssa = phi i32 [ %v37, %B30 ]
  br label %B38

B38:                                              ; preds = %B38.loopexit, %entry
  %j.0.lcssa = phi i32 [ 0, %entry ], [ %v37.lcssa, %B38.loopexit ]
  %v39 = sext i32 %j.0.lcssa to i64
  %v40 = getelementptr inbounds [61 x i8]* %line_buffer, i64 0, i64 %v39
  store i8 10, i8* %v40, align 1
  %v41 = getelementptr inbounds [61 x i8]* %line_buffer, i64 0, i64 0
  %v42 = add nsw i32 %j.0.lcssa, 1
  %v43 = sext i32 %v42 to i64
  %v44 = load %struct._IO_FILE** @outStream, align 8
  %v45 = call i64 @fwrite_unlocked(i8* %v41, i64 %v43, i64 1, %struct._IO_FILE* %v44) #2
  ret void
}

; Function Attrs: inlinehint nounwind uwtable
define internal fastcc float @random_next_lookup(i32* nocapture %random) #4 {
  %1 = load i32* %random, align 4
  %2 = mul i32 %1, 3877
  %3 = add i32 %2, 29573
  %4 = urem i32 %3, 139968
  store i32 %4, i32* %random, align 4
  %5 = uitofp i32 %4 to float
  %6 = fmul float %5, 0x3F9DF57700000000
  ret float %6
}

; Function Attrs: nounwind uwtable
define i32 @bench(i32 %inputN) #0 {
  %filename = alloca [64 x i8], align 16
  %rand = alloca i32, align 4
  %1 = icmp sgt i32 %inputN, 1
  %inputN. = select i1 %1, i32 %inputN, i32 512
  %2 = getelementptr inbounds [64 x i8]* %filename, i64 0, i64 0
  %3 = call i32 (i8*, i8*, ...)* @sprintf(i8* %2, i8* getelementptr inbounds ([19 x i8]* @.str, i64 0, i64 0), i32 %inputN.) #2
  %4 = call %struct._IO_FILE* @fopen(i8* %2, i8* getelementptr inbounds ([3 x i8]* @.str1, i64 0, i64 0)) #2
  store %struct._IO_FILE* %4, %struct._IO_FILE** @outStream, align 8
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* getelementptr inbounds ([15 x %struct.amino_acid]* @amino_acid, i64 0, i64 0, i32 0), i8* getelementptr inbounds ([15 x %struct.amino_acid]* @amino_acid_orig, i64 0, i64 0, i32 0), i64 180, i32 16, i1 false)
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* getelementptr inbounds ([4 x %struct.amino_acid]* @homo_sapiens, i64 0, i64 0, i32 0), i8* getelementptr inbounds ([4 x %struct.amino_acid]* @homo_sapiens_orig, i64 0, i64 0, i32 0), i64 48, i32 16, i1 false)
  call void @random_init(i32* %rand)
  %5 = shl nsw i32 %inputN., 1
  tail call void @repeat(i8* getelementptr inbounds ([288 x i8]* @alu, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8]* @.str2, i64 0, i64 0), i32 %5)
  %6 = mul nsw i32 %inputN., 3
  call void @randomize(%struct.amino_acid* getelementptr inbounds ([15 x %struct.amino_acid]* @amino_acid, i64 0, i64 0), i32 15, i8* getelementptr inbounds ([26 x i8]* @.str3, i64 0, i64 0), i32 %6, i32* %rand)
  %7 = mul nsw i32 %inputN., 5
  call void @randomize(%struct.amino_acid* getelementptr inbounds ([4 x %struct.amino_acid]* @homo_sapiens, i64 0, i64 0), i32 4, i8* getelementptr inbounds ([31 x i8]* @.str4, i64 0, i64 0), i32 %7, i32* %rand)
  %8 = load %struct._IO_FILE** @outStream, align 8
  %9 = tail call i32 @fclose(%struct._IO_FILE* %8) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @sprintf(i8* nocapture, i8* nocapture readonly, ...) #5

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) #5

; Function Attrs: nounwind
declare i32 @fclose(%struct._IO_FILE* nocapture) #5

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { inlinehint nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.6.2 (tags/RELEASE_362/final)"}
!1 = !{!"branch_weights", i32 4, i32 64}
