Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC9669F57
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Jan 2023 18:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjAMROD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Jan 2023 12:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjAMRNo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Jan 2023 12:13:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E448B52B
        for <linux-scsi@vger.kernel.org>; Fri, 13 Jan 2023 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673629925; x=1705165925;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uaaXZV3sG79+TeMR+hrFRsa8RvzQpx4iYxOp0B1DqCM=;
  b=EHnwvVZ40mCDEOJZx1GHdm3H35Lf29ZYS1dZhFvgw9PQ8ZPBlY++KrEQ
   g/ThEgqsk2Ddi2Q0tSfzh0cAeM6TPvjj5NLCJ+hJWuFInEXTb8pHAuAI/
   C2UqTEuygBAqr7KK1Tr0IOTuS4GVYSVjzRvHvIwEVkMvuN331bQByGRad
   ghcc1g+ptKhqGDn868nC/k51W1IXDKRgexONVyMeyIhKWt2cusnh1G9ou
   8RdLZX3MmOZ+/YaFLZICbcoSTW9Anu3AHzdrCtLHufMo1qFJbnPRcAePZ
   yq9nz79E7TQXjo0AbLhoU79C/03OooCUQugRsY020hjT3mfDAQhGVG0Oe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322742861"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322742861"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:10:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="660282846"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="660282846"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2023 09:10:30 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGNZV-000BHg-2D;
        Fri, 13 Jan 2023 17:10:29 +0000
Date:   Sat, 14 Jan 2023 01:10:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 6b31ffe9c8b9947d6d3552d6e10752fd96d0f80f
Message-ID: <63c19068.KJJoDMv4WFq0GgOm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 6b31ffe9c8b9947d6d3552d6e10752fd96d0f80f  Add linux-next specific files for 20230113

Error/Warning: (recently discovered and may have been fixed)

aarch64-linux-ld: ID map text too big or misaligned
arch/arm/kernel/entry-armv.S:485:5: warning: "CONFIG_ARM_THUMB" is not defined, evaluates to 0 [-Wundef]
drivers/gpu/drm/ttm/ttm_bo_util.c:364:32: error: implicit declaration of function 'vmap'; did you mean 'kmap'? [-Werror=implicit-function-declaration]
drivers/gpu/drm/ttm/ttm_bo_util.c:429:17: error: implicit declaration of function 'vunmap'; did you mean 'kunmap'? [-Werror=implicit-function-declaration]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/nvmem/layouts/sl28vpd.c:143:21: sparse: sparse: symbol 'sl28vpd_layout' was not declared. Should it be static?
drivers/scsi/qla2xxx/qla_mid.c:1189:6: sparse: sparse: symbol 'qla_trim_buf' was not declared. Should it be static?
drivers/scsi/qla2xxx/qla_mid.c:1221:6: sparse: sparse: symbol '__qla_adjust_buf' was not declared. Should it be static?
sound/ac97/bus.c:465:1: sparse: sparse: symbol 'dev_attr_vendor_id' was not declared. Should it be static?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-buildonly-randconfig-r003-20230113
|   `-- arch-arm-kernel-entry-armv.S:warning:CONFIG_ARM_THUMB-is-not-defined-evaluates-to
|-- arm64-allyesconfig
|   `-- aarch64-linux-ld:ID-map-text-too-big-or-misaligned
|-- microblaze-randconfig-s041-20230112
|   |-- drivers-nvmem-layouts-sl28vpd.c:sparse:sparse:symbol-sl28vpd_layout-was-not-declared.-Should-it-be-static
|   `-- sound-ac97-bus.c:sparse:sparse:symbol-dev_attr_vendor_id-was-not-declared.-Should-it-be-static
|-- microblaze-randconfig-s043-20230112
|   |-- drivers-scsi-qla2xxx-qla_mid.c:sparse:sparse:symbol-__qla_adjust_buf-was-not-declared.-Should-it-be-static
|   `-- drivers-scsi-qla2xxx-qla_mid.c:sparse:sparse:symbol-qla_trim_buf-was-not-declared.-Should-it-be-static
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-ttm-ttm_bo_util.c:error:implicit-declaration-of-function-vmap
|   `-- drivers-gpu-drm-ttm-ttm_bo_util.c:error:implicit-declaration-of-function-vunmap
`-- mips-randconfig-r012-20230113
    |-- drivers-gpu-drm-ttm-ttm_bo_util.c:error:implicit-declaration-of-function-vmap
    `-- drivers-gpu-drm-ttm-ttm_bo_util.c:error:implicit-declaration-of-function-vunmap

elapsed time: 725m

configs tested: 68
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
x86_64                              defconfig
mips                             allyesconfig
x86_64                               rhel-8.3
s390                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20230112
arm                                 defconfig
x86_64                           allyesconfig
i386                                defconfig
ia64                             allmodconfig
i386                          randconfig-a001
x86_64                           rhel-8.3-bpf
i386                          randconfig-a003
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
x86_64                        randconfig-a013
i386                          randconfig-a005
arm64                            allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                        randconfig-a002
arm                              allyesconfig
i386                          randconfig-a012
x86_64                        randconfig-a015
i386                          randconfig-a016
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                        randconfig-a004
sh                          urquell_defconfig
sh                     magicpanelr2_defconfig
xtensa                       common_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a001
i386                          randconfig-a015
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a005
mips                       rbtx49xx_defconfig
s390                             alldefconfig
powerpc                      walnut_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
