Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A1C5B8F5E
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Sep 2022 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiINTwe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Sep 2022 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiINTwd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Sep 2022 15:52:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE376965;
        Wed, 14 Sep 2022 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663185152; x=1694721152;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jZqDuUhr02I6XM8gbXAnzYh6mgvieDOasy2R0lTbdVk=;
  b=iTmmgsItuu4pOoiTizEQD2pA6l49rP3dDJo3qOii43Nqn1cuj82rbUzN
   m1iDA3HJrRp838wsUDgnoBOyMDVcVUZxlt+uJ9sQunvhO46b64iiBhxgU
   lZ5SQY/LlKwc6Vyw1NW7bpHp281qzT7byUn1VL4ZyajFOdEMJ9RvpFHtk
   KaraKYLi3JhNwqIdkmIca0xqeYHhgCS7Ptgo/KXicWwxXxV8TyrRlAWqR
   I+czSRzy2/FyIfzYEsd0E0TagGYtf1VHXbqFeCGWYtAVXwdQyF2eyjq2U
   vtdr/ssKv2nxLeESWgs39Q5vvuBXbRz+xDjqrjXnTGvry3J6NVanQE0xj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299887513"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="299887513"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 12:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="647527197"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2022 12:52:28 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYYQu-0000XM-0a;
        Wed, 14 Sep 2022 19:52:28 +0000
Date:   Thu, 15 Sep 2022 03:51:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-scsi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 f117c01187301a087412bd6697fcf5463cb427d8
Message-ID: <632230c0.yN3SHeeFUHUYU1ys%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: f117c01187301a087412bd6697fcf5463cb427d8  Add linux-next specific files for 20220914

Error/Warning reports:

https://lore.kernel.org/linux-mm/202209150141.WgbAKqmX-lkp@intel.com
https://lore.kernel.org/llvm/202209141913.Nxzv3hwM-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/clk/xilinx/clk-xlnx-clock-wizard.ko] undefined!
ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
arch/parisc/lib/iomap.c:363:5: warning: no previous prototype for 'ioread64_lo_hi' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:373:5: warning: no previous prototype for 'ioread64_hi_lo' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:448:6: warning: no previous prototype for 'iowrite64_lo_hi' [-Wmissing-prototypes]
arch/parisc/lib/iomap.c:454:6: warning: no previous prototype for 'iowrite64_hi_lo' [-Wmissing-prototypes]
drivers/gpu/drm/drm_atomic_helper.c:802: warning: expecting prototype for drm_atomic_helper_check_wb_connector_state(). Prototype was for drm_atomic_helper_check_wb_encoder_state() instead
drivers/scsi/qla2xxx/qla_os.c:2854:23: warning: assignment to 'struct trace_array *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'? [-Werror=implicit-function-declaration]
drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function 'trace_array_put' [-Werror=implicit-function-declaration]
sound/soc/codecs/tas2562.c:442:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_get_by_name
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_put
|   |-- drivers-scsi-qla2xxx-qla_os.c:warning:assignment-to-struct-trace_array-from-int-makes-pointer-from-integer-without-a-cast
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arc-randconfig-r043-20220914
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm-buildonly-randconfig-r003-20220914
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm-defconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm64-randconfig-r036-20220914
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- i386-defconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a003
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a012
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a014
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- i386-randconfig-a016
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- ia64-allmodconfig
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_get_by_name
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_put
|   `-- drivers-scsi-qla2xxx-qla_os.c:warning:assignment-to-struct-trace_array-from-int-makes-pointer-from-integer-without-a-cast
|-- ia64-randconfig-r013-20220914
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- loongarch-randconfig-r026-20220914
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- m68k-allmodconfig
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- m68k-allyesconfig
clang_recent_errors
|-- arm-randconfig-r032-20220914
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- arm64-randconfig-r021-20220914
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-function-apply_alternatives_vdso
|-- i386-randconfig-a002
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- i386-randconfig-a015
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- powerpc-randconfig-r022-20220914
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- riscv-randconfig-r042-20220914
|   |-- arch-riscv-errata-thead-errata.c:error:use-of-undeclared-identifier-riscv_cbom_block_size
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- s390-randconfig-r044-20220914
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- x86_64-randconfig-a003
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- x86_64-randconfig-a012
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
`-- x86_64-randconfig-a016
    `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead

elapsed time: 726m

configs tested: 62
configs skipped: 2

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a004
um                             i386_defconfig
x86_64                        randconfig-a002
i386                          randconfig-a005
arc                                 defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a006
s390                             allmodconfig
i386                                defconfig
powerpc                          allmodconfig
alpha                               defconfig
s390                                defconfig
mips                             allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
arc                  randconfig-r043-20220914
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a005
riscv                randconfig-r042-20220914
hexagon              randconfig-r045-20220914
hexagon              randconfig-r041-20220914
i386                          randconfig-a013
x86_64                        randconfig-a016
s390                 randconfig-r044-20220914
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
