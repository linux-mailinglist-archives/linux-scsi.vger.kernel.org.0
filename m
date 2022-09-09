Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F25B4164
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Sep 2022 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIIV0O (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Sep 2022 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIIV0M (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Sep 2022 17:26:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675FFE4A1;
        Fri,  9 Sep 2022 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662758771; x=1694294771;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cwQ6SCgM+Kl9Bt6tUHM6yFrYsFndLuCrr7838ehODtY=;
  b=aAYO63KRZ9oNUMHDYBtQKaZv2ToJ3RepuFG6EZIXrHe+6z8OTVo0rc9I
   A0LHCLf0SDZTIunQPmXtoTAf0O1e0kZOLxKNXD01vJo7Tz1XeLWNebDDl
   r1MBO4sRyVy+hCwO6vqxk++OXmwqxtAXLCFqchtStT3T1nfjEgWiyI/ko
   8PPgH+tWC6Y+YCj+aHyneZ31hIHaQo9WUxKIjozc7U91sBFvSGEJ1RSAN
   57LFtMKEedKN3wRQhyWiuGkkFPKN64MfhTh8xTShS1KaqS8AT/BaWCDTJ
   +7lZQBTNhMq3MGGSIFoMxZ6YFznC7rlwa2ssvKLEZ4L+i+WyYRKasLk9g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298373831"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298373831"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="592753040"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2022 14:26:08 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWlVn-0001kx-2W;
        Fri, 09 Sep 2022 21:26:07 +0000
Date:   Sat, 10 Sep 2022 05:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bpf@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        alsa-devel@alsa-project.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 9a82ccda91ed2b40619cb3c10d446ae1f97bab6e
Message-ID: <631baf4e.klxNbMailfUgOTRD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 9a82ccda91ed2b40619cb3c10d446ae1f97bab6e  Add linux-next specific files for 20220909

Error/Warning reports:

https://lore.kernel.org/linux-mm/202209042337.FQi69rLV-lkp@intel.com
https://lore.kernel.org/linux-mm/202209080718.y5QmlNKH-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

./drivers/gpu/drm/drm_atomic_helper.c:802: warning: expecting prototype for drm_atomic_helper_check_wb_connector_state(). Prototype was for drm_atomic_helper_check_wb_encoder_state() instead
ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
arm-linux-gnueabi-ld: vkms_formats.c:(.text+0x824): undefined reference to `__aeabi_ldivmod'
drivers/base/regmap/regmap-mmio.c:222:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:225:17: error: implicit declaration of function 'writesw'; did you mean 'writew'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:228:17: error: implicit declaration of function 'writesl'; did you mean 'writel'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:358:17: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:361:17: error: implicit declaration of function 'readsw'; did you mean 'readw'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:364:17: error: implicit declaration of function 'readsl'; did you mean 'readl'? [-Werror=implicit-function-declaration]
drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c:139:6: warning: no previous prototype for 'imu_v11_0_3_program_rlc_ram' [-Wmissing-prototypes]
drivers/gpu/drm/drm_atomic_helper.c:802: warning: expecting prototype for drm_atomic_helper_check_wb_connector_state(). Prototype was for drm_atomic_helper_check_wb_encoder_state() instead
drivers/gpu/drm/vkms/vkms_formats.c:259: undefined reference to `__divdi3'
drivers/gpu/drm/vkms/vkms_plane.c:110 vkms_plane_atomic_update() warn: variable dereferenced before check 'fb' (see line 108)
drivers/scsi/qla2xxx/qla_os.c:2854:23: warning: assignment to 'struct trace_array *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'? [-Werror=implicit-function-declaration]
drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function 'trace_array_put' [-Werror=implicit-function-declaration]
kernel/bpf/memalloc.c:499 bpf_mem_alloc_destroy() error: potentially dereferencing uninitialized 'c'.
ld: drivers/gpu/drm/vkms/vkms_formats.c:260: undefined reference to `__divdi3'
ld: vkms_formats.c:(.text+0x362): undefined reference to `__divdi3'
ld: vkms_formats.c:(.text+0x3b2): undefined reference to `__divdi3'
ld: vkms_formats.c:(.text+0x3ba): undefined reference to `__divdi3'
ld: vkms_formats.c:(.text+0x47f): undefined reference to `__divdi3'
microblaze-linux-ld: drivers/gpu/drm/vkms/vkms_formats.c:260: undefined reference to `__divdi3'
mips-linux-ld: vkms_formats.c:(.text+0x8b8): undefined reference to `__divdi3'
mips-linux-ld: vkms_formats.c:(.text.argb_u16_to_RGB565+0xd0): undefined reference to `__divdi3'
sound/soc/codecs/tas2562.c:442:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
vkms_formats.c:(.text+0x266): undefined reference to `__divdi3'
vkms_formats.c:(.text+0x338): undefined reference to `__divdi3'
vkms_formats.c:(.text+0x388): undefined reference to `__divdi3'
vkms_formats.c:(.text+0x390): undefined reference to `__divdi3'
vkms_formats.c:(.text+0x455): undefined reference to `__divdi3'
vkms_formats.c:(.text+0x804): undefined reference to `__aeabi_ldivmod'
vkms_formats.c:(.text+0x89c): undefined reference to `__divdi3'
vkms_formats.c:(.text.argb_u16_to_RGB565+0xb0): undefined reference to `__divdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_get_by_name
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_put
|   |-- drivers-scsi-qla2xxx-qla_os.c:warning:assignment-to-struct-trace_array-from-int-makes-pointer-from-integer-without-a-cast
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arc-randconfig-r025-20220908
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arc-randconfig-s033-20220907
|   |-- kernel-bpf-hashtab.c:sparse:sparse:cast-removes-address-space-__percpu-of-expression
|   |-- kernel-bpf-hashtab.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-void-noderef-__percpu-assigned-pptr-got-void
|   |-- kernel-bpf-hashtab.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-void-ptr_to_pptr-got-void-noderef-__percpu-assigned-pptr
|   |-- kernel-bpf-memalloc.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__percpu-__pdata-got-void
|   |-- kernel-bpf-memalloc.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__percpu-__pdata-got-void-pptr
|   |-- kernel-bpf-memalloc.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-pptr-got-void-noderef-__percpu
|   `-- kernel-exit.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-struct-sighand_struct-sighand-got-struct-sighand_struct-noderef-__rcu-sighand
|-- arm-allyesconfig
|   |-- arm-linux-gnueabi-ld:vkms_formats.c:(.text):undefined-reference-to-__aeabi_ldivmod
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   |-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|   `-- vkms_formats.c:(.text):undefined-reference-to-__aeabi_ldivmod
|-- arm-defconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm64-randconfig-r021-20220908
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm64-randconfig-r034-20220909
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   |-- ld:vkms_formats.c:(.text):undefined-reference-to-__divdi3
|   |-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|   `-- vkms_formats.c:(.text):undefined-reference-to-__divdi3
|-- i386-defconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a003
|   |-- ERROR:__divdi3-drivers-gpu-drm-vkms-vkms.ko-undefined
|   |-- ERROR:__udivdi3-drivers-gpu-drm-vkms-vkms.ko-undefined
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a012
clang_recent_errors
|-- arm64-randconfig-r006-20220908
|   `-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-function-imu_v11_0_3_program_rlc_ram
|-- i386-randconfig-a002
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- i386-randconfig-a006
|   `-- ld.lld:error:undefined-symbol:__udivdi3
|-- i386-randconfig-a013
|   `-- ld.lld:error:undefined-symbol:__udivdi3
|-- i386-randconfig-a015
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- riscv-randconfig-r001-20220908
|   `-- ld.lld:error:undefined-symbol:__udivdi3
|-- riscv-randconfig-r013-20220907
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- x86_64-randconfig-a003
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- x86_64-randconfig-a012
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
`-- x86_64-randconfig-a016
    `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead

elapsed time: 729m

configs tested: 75
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                              defconfig
i386                                defconfig
i386                          randconfig-a005
m68k                             allmodconfig
arc                              allyesconfig
i386                             allyesconfig
arm                                 defconfig
x86_64                        randconfig-a004
alpha                            allyesconfig
x86_64                        randconfig-a002
x86_64                               rhel-8.3
m68k                             allyesconfig
powerpc                           allnoconfig
x86_64                           allyesconfig
x86_64                        randconfig-a015
arm                              allyesconfig
x86_64                        randconfig-a006
arm64                            allyesconfig
x86_64                        randconfig-a013
powerpc                          allmodconfig
x86_64                        randconfig-a011
sh                               allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
mips                      loongson3_defconfig
arc                  randconfig-r043-20220907
x86_64                          rhel-8.3-func
parisc                           alldefconfig
x86_64                         rhel-8.3-kunit
sh                            migor_defconfig
powerpc                      ppc40x_defconfig
x86_64                           rhel-8.3-kvm
openrisc                            defconfig
sh                         apsh4a3a_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
alpha                             allnoconfig
i386                          randconfig-a012
riscv                             allnoconfig
sh                        edosk7705_defconfig
csky                              allnoconfig
i386                          randconfig-a016
sh                             shx3_defconfig
arc                               allnoconfig
ia64                         bigsur_defconfig
s390                       zfcpdump_defconfig
sh                          rsk7201_defconfig
powerpc                      bamboo_defconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220907
riscv                randconfig-r042-20220907
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
mips                           ip22_defconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
