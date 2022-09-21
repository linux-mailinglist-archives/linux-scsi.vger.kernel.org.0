Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827FB5E5613
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Sep 2022 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIUWJw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Sep 2022 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIUWJv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Sep 2022 18:09:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014665551;
        Wed, 21 Sep 2022 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663798188; x=1695334188;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=R3CpDz+xL1Orecl3r244JO/sBWMMsfvYdEmeOk70BlE=;
  b=C12UoqBnYvsW1c/X3Rm38o8gamGjJWilueGRW2lQ4s3iYq3DtfGTCMcb
   5jftulS8M6M8zuvoelUBR76c2bejqf29Cs8e2ExNH9nETCx9WVZCX8eEV
   AvjecWChpBVXQiHHXTlK/p+y/IIk1CMIjGT+MYsnIYqk7Geq/K6NNbqmh
   Gv+RMwfgCJXU+E0z4ywA8xEnbI6PQlP9ZN8S/JosxdGr0sluw9Ws/IaZQ
   v8q4y6PwXSqfyPG7NzQ1b9cRsOKz/yk5i95pSvry2KxJTbmO5TIjD6wFC
   /9Qyk4YPZ680K9Ox1CwmLTm7u30o3tt8wpJ2jZvrfxUV7b0fca9Nz5GF0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="283185948"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="283185948"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 15:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="652717033"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2022 15:09:44 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob7ua-00041Y-0D;
        Wed, 21 Sep 2022 22:09:44 +0000
Date:   Thu, 22 Sep 2022 06:09:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 483fed3b5dc8ce3644c83d24240cf5756fb0993e
Message-ID: <632b8b99.vfbuiC8J3oDCVZh4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 483fed3b5dc8ce3644c83d24240cf5756fb0993e  Add linux-next specific files for 20220921

Error/Warning reports:

https://lore.kernel.org/linux-mm/202209042337.FQi69rLV-lkp@intel.com
https://lore.kernel.org/linux-mm/202209060229.dVuyxjBv-lkp@intel.com
https://lore.kernel.org/linux-mm/202209150141.WgbAKqmX-lkp@intel.com
https://lore.kernel.org/linux-mm/202209160607.sE3qvgTy-lkp@intel.com
https://lore.kernel.org/linux-mm/202209200603.Hpvoa8Ii-lkp@intel.com
https://lore.kernel.org/linux-mm/202209200949.Vl3xrUYD-lkp@intel.com
https://lore.kernel.org/llvm/202209220009.8nYpIPST-lkp@intel.com
https://lore.kernel.org/llvm/202209220019.Yr2VuXhg-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/clk/xilinx/clk-xlnx-clock-wizard.ko] undefined!
ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
arch/arm64/kernel/alternative.c:199:6: warning: no previous prototype for 'apply_alternatives_vdso' [-Wmissing-prototypes]
arch/arm64/kernel/alternative.c:295:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
arch/ia64/kernel/sys_ia64.c:188:17: sparse: sparse: typename in expression
arch/ia64/kernel/sys_ia64.c:188:31: sparse: sparse: Trying to use reserved word 'typeof' as identifier
arch/ia64/kernel/sys_ia64.c:188:31: sparse: sparse: Trying to use reserved word 'void' as identifier
arch/ia64/kernel/sys_ia64.c:189:60: sparse: sparse: invalid initializer
arch/ia64/kernel/sys_ia64.c:190:17: sparse: sparse: Trying to use reserved word 'return' as identifier
arch/parisc/lib/iomap.c:363:5: warning: no previous prototype for 'ioread64_lo_hi' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:373:5: warning: no previous prototype for 'ioread64_hi_lo' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:448:6: warning: no previous prototype for 'iowrite64_lo_hi' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:454:6: warning: no previous prototype for 'iowrite64_hi_lo' [-Wmissing-prototypes]
drivers/scsi/qla2xxx/qla_os.c:2854:23: warning: assignment to 'struct trace_array *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'? [-Werror=implicit-function-declaration]
drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function 'trace_array_put' [-Werror=implicit-function-declaration]
mm/hugetlb.c:5539:14: warning: variable 'reserve_alloc' set but not used [-Wunused-but-set-variable]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_get_by_name
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_put
|   `-- drivers-scsi-qla2xxx-qla_os.c:warning:assignment-to-struct-trace_array-from-int-makes-pointer-from-integer-without-a-cast
|-- alpha-randconfig-s033-20220921
|   `-- kernel-exit.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-struct-sighand_struct-sighand-got-struct-sighand_struct-noderef-__rcu-sighand
|-- arm64-allyesconfig
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|   `-- mm-hugetlb.c:warning:variable-reserve_alloc-set-but-not-used
|-- arm64-randconfig-r013-20220921
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- i386-allyesconfig
|   `-- mm-hugetlb.c:warning:variable-reserve_alloc-set-but-not-used
|-- i386-defconfig
|   `-- mm-hugetlb.c:warning:variable-reserve_alloc-set-but-not-used
|-- i386-randconfig-c021
|   `-- mm-hugetlb.c:warning:variable-reserve_alloc-set-but-not-used
|-- i386-randconfig-m021
|   `-- drivers-gpu-drm-display-drm_dp_helper.c-drm_dp_phy_name()-warn:unsigned-dp_phy-is-never-less-than-zero.
|-- i386-randconfig-s001
|   |-- arch-x86-kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__user-to-got-unsigned-long-long-usertype
|   |-- drivers-gpu-drm-tiny-simpledrm.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-vaddr-got-void-noderef-__iomem-screen_base
|   |-- drivers-gpu-drm-vkms-vkms_formats.c:sparse:sparse:cast-to-restricted-__le16
|   |-- drivers-gpu-drm-vkms-vkms_formats.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-unsigned-short-usertype-got-restricted-__le16-usertype
|   `-- kernel-exit.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-struct-sighand_struct-sighand-got-struct-sighand_struct-noderef-__rcu-sighand
|-- i386-randconfig-s002
|   |-- arch-x86-kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__user-to-got-unsigned-long-long-usertype
|   |-- drivers-gpu-drm-tiny-simpledrm.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-vaddr-got-void-noderef-__iomem-screen_base
|   |-- kernel-exit.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-struct-sighand_struct-sighand-got-struct-sighand_struct-noderef-__rcu-sighand
|   `-- mm-hugetlb.c:warning:variable-reserve_alloc-set-but-not-used
|-- i386-randconfig-s003
|   |-- arch-x86-kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__user-to-got-unsigned-long-long-usertype
|   |-- drivers-gpu-drm-tiny-simpledrm.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-vaddr-got-void-noderef-__iomem-screen_base
|   |-- kernel-exit.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-struct-sighand_struct-sighand-got-struct-sighand_struct-noderef-__rcu-sighand
|   |-- mm-hugetlb.c:warning:variable-reserve_alloc-set-but-not-used
|   `-- sound-soc-generic-simple-card-utils.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-unsigned-int-usertype-val-got-restricted-snd_pcm_format_t-usertype
|-- ia64-allmodconfig
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_get_by_name
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_put
|   |-- drivers-scsi-qla2xxx-qla_os.c:warning:assignment-to-struct-trace_array-from-int-makes-pointer-from-integer-without-a-cast
|   `-- mm-hugetlb.c:warning:variable-reserve_alloc-set-but-not-used
|-- ia64-randconfig-s052-20220921
|   |-- arch-ia64-kernel-sys_ia64.c:sparse:sparse:Trying-to-use-reserved-word-return-as-identifier
|   |-- arch-ia64-kernel-sys_ia64.c:sparse:sparse:Trying-to-use-reserved-word-typeof-as-identifier
|   |-- arch-ia64-kernel-sys_ia64.c:sparse:sparse:Trying-to-use-reserved-word-void-as-identifier
|   |-- arch-ia64-kernel-sys_ia64.c:sparse:sparse:invalid-initializer
|   |-- arch-ia64-kernel-sys_ia64.c:sparse:sparse:typename-in-expression
|   |-- kernel-bpf-hashtab.c:sparse:sparse:cast-removes-address-space-__percpu-of-expression
clang_recent_errors
|-- arm-randconfig-r014-20220921
|   `-- make:No-rule-to-make-target-drivers-crypto-aspeed-aspeed_crypto.o-needed-by-drivers-crypto-aspeed-built-in.a-.
|-- arm-randconfig-r026-20220921
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:call-to-undeclared-function-trace_array_get_by_name-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:call-to-undeclared-function-trace_array_put-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-scsi-qla2xxx-qla_os.c:error:incompatible-integer-to-pointer-conversion-assigning-to-struct-trace_array-from-int
|-- i386-randconfig-a015
|   |-- ERROR:__cpuhp_remove_state-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:__cpuhp_setup_state-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:_printk-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:boot_cpu_data-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:cpu_bit_bitmap-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:perf_msr_probe-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:perf_pmu_register-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:perf_pmu_unregister-arch-x86-events-intel-intel-cstate.ko-undefined
|   |-- ERROR:x86_match_cpu-arch-x86-events-intel-intel-cstate.ko-undefined
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- powerpc-randconfig-r006-20220921
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-virtual-virtual_link_hwss.c:warning:no-previous-prototype-for-function-virtual_disable_link_output
|   `-- ld.lld:error:undefined-symbol:__udivdi3
|-- x86_64-allyesconfig
|   |-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|   `-- mm-hugetlb.c:warning:variable-reserve_alloc-set-but-not-used
`-- x86_64-randconfig-a016
    `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead

elapsed time: 728m

configs tested: 67
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                      axs103_smp_defconfig
arc                  randconfig-r043-20220921
arc                                 defconfig
x86_64                              defconfig
m68k                             allmodconfig
powerpc                          allmodconfig
loongarch                         allnoconfig
riscv                randconfig-r042-20220921
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
s390                 randconfig-r044-20220921
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
arc                               allnoconfig
arm                           viper_defconfig
alpha                             allnoconfig
arm                          lpd270_defconfig
riscv                             allnoconfig
csky                              allnoconfig
m68k                          sun3x_defconfig
sh                          sdk7780_defconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
i386                          randconfig-a016
powerpc                      ppc6xx_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        trizeps4_defconfig
sh                        dreamcast_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                    sam440ep_defconfig
powerpc                      pcm030_defconfig
sh                           se7780_defconfig
i386                          randconfig-c001
powerpc                         wii_defconfig
powerpc                           allnoconfig
alpha                               defconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
s390                                defconfig
x86_64                           allyesconfig
s390                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
mips                             allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
arm                         hackkit_defconfig
s390                             alldefconfig
x86_64                        randconfig-a016
i386                          randconfig-a015
powerpc                      katmai_defconfig
arm                        mvebu_v5_defconfig
x86_64                        randconfig-k001
x86_64                           allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
