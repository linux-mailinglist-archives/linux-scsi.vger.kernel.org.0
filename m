Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9284AEDA
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 01:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfFRXtR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 19:49:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:36104 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRXtR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 19:49:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 16:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; 
   d="scan'208";a="358440750"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2019 16:49:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hdNql-0006CF-0W; Wed, 19 Jun 2019 07:49:15 +0800
Date:   Wed, 19 Jun 2019 07:48:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: Re: [PATCH 11/18] megaraid_sas: Offload Aero RAID5/6 division
 calculations to driver
Message-ID: <201906190754.nBNgVz78%lkp@intel.com>
References: <20190618093207.9939-12-chandrakanth.patil@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618093207.9939-12-chandrakanth.patil@broadcom.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Chandrakanth,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on next-20190618]
[cannot apply to v5.2-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chandrakanth-Patil/megaraid_sas-driver-updates-to-07-710-06-00-rc1/20190618-174435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/megaraid/megaraid_sas_fp.c:752:60: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [usertype] r1_alt_dev_handle @@    got short [usertype] r1_alt_dev_handle @@
   drivers/scsi/megaraid/megaraid_sas_fp.c:752:60: sparse:    expected unsigned short [usertype] r1_alt_dev_handle
   drivers/scsi/megaraid/megaraid_sas_fp.c:752:60: sparse:    got restricted __le16
   drivers/scsi/megaraid/megaraid_sas_fp.c:194:72: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:199:33: sparse: sparse: cast to restricted __le16
   drivers/scsi/megaraid/megaraid_sas_fp.c:207:25: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:208:25: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:210:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:211:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:214:79: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:215:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:223:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:224:49: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:226:49: sparse: sparse: cast to restricted __le16
   drivers/scsi/megaraid/megaraid_sas_fp.c:232:58: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:233:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:242:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:243:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_fp.c:868:60: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [usertype] r1_alt_dev_handle @@    got short [usertype] r1_alt_dev_handle @@
   drivers/scsi/megaraid/megaraid_sas_fp.c:868:60: sparse:    expected unsigned short [usertype] r1_alt_dev_handle
   drivers/scsi/megaraid/megaraid_sas_fp.c:868:60: sparse:    got restricted __le16
>> drivers/scsi/megaraid/megaraid_sas_fp.c:964:41: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned long long [usertype] reg_lock_row_lba @@    got nsigned long long [usertype] reg_lock_row_lba @@
>> drivers/scsi/megaraid/megaraid_sas_fp.c:964:41: sparse:    expected unsigned long long [usertype] reg_lock_row_lba
   drivers/scsi/megaraid/megaraid_sas_fp.c:964:41: sparse:    got restricted __le64 [usertype]
   drivers/scsi/megaraid/megaraid_sas_fp.c:1201:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_fp.c:1392:24: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [usertype] pd1_dev_handle @@    got short [usertype] pd1_dev_handle @@
   drivers/scsi/megaraid/megaraid_sas_fp.c:1392:24: sparse:    expected unsigned short [usertype] pd1_dev_handle
   drivers/scsi/megaraid/megaraid_sas_fp.c:1392:24: sparse:    got restricted __le16
   drivers/scsi/megaraid/megaraid_sas_fp.c:1361:4: sparse: sparse: symbol 'megasas_get_best_arm_pd' was not declared. Should it be static?

vim +964 drivers/scsi/megaraid/megaraid_sas_fp.c

   903	
   904	/*
   905	 * mr_get_phy_params_r56_rmw -  Calculate parameters for R56 CTIO write operation
   906	 * @instance:			Adapter soft state
   907	 * @ld:				LD index
   908	 * @stripNo:			Strip Number
   909	 * @io_info:			IO info structure pointer
   910	 * pRAID_Context:		RAID context pointer
   911	 * map:				RAID map pointer
   912	 *
   913	 * This routine calculates the logical arm, data Arm, row number and parity arm
   914	 * for R56 CTIO write operation.
   915	 */
   916	static void mr_get_phy_params_r56_rmw(struct megasas_instance *instance,
   917				    u32 ld, u64 stripNo,
   918				    struct IO_REQUEST_INFO *io_info,
   919				    struct RAID_CONTEXT_G35 *pRAID_Context,
   920				    struct MR_DRV_RAID_MAP_ALL *map)
   921	{
   922		struct MR_LD_RAID  *raid = MR_LdRaidGet(ld, map);
   923		u8          span, dataArms, arms, dataArm, logArm;
   924		s8          rightmostParityArm, PParityArm;
   925		u64         rowNum;
   926		u64 *pdBlock = &io_info->pdBlock;
   927	
   928		dataArms = raid->rowDataSize;
   929		arms = raid->rowSize;
   930	
   931		rowNum =  mega_div64_32(stripNo, dataArms);
   932		/* parity disk arm, first arm is 0 */
   933		rightmostParityArm = (arms - 1) - mega_mod64(rowNum, arms);
   934	
   935		/* logical arm within row */
   936		logArm =  mega_mod64(stripNo, dataArms);
   937		/* physical arm for data */
   938		dataArm = mega_mod64((rightmostParityArm + 1 + logArm), arms);
   939	
   940		if (raid->spanDepth == 1) {
   941			span = 0;
   942		} else {
   943			span = (u8)MR_GetSpanBlock(ld, rowNum, pdBlock, map);
   944			if (span == SPAN_INVALID)
   945				return;
   946		}
   947	
   948		if (raid->level == 6) {
   949			/* P Parity arm, note this can go negative adjust if negative */
   950			PParityArm = (arms - 2) - mega_mod64(rowNum, arms);
   951	
   952			if (PParityArm < 0)
   953				PParityArm += arms;
   954	
   955			/* rightmostParityArm is P-Parity for RAID 5 and Q-Parity for RAID */
   956			pRAID_Context->flow_specific.r56_arm_map = rightmostParityArm;
   957			pRAID_Context->flow_specific.r56_arm_map |=
   958					    (u16)(PParityArm << RAID_CTX_R56_P_ARM_SHIFT);
   959		} else {
   960			pRAID_Context->flow_specific.r56_arm_map |=
   961					    (u16)(rightmostParityArm << RAID_CTX_R56_P_ARM_SHIFT);
   962		}
   963	
 > 964		pRAID_Context->reg_lock_row_lba = cpu_to_le64(rowNum);
   965		pRAID_Context->flow_specific.r56_arm_map |=
   966					   (u16)(logArm << RAID_CTX_R56_LOG_ARM_SHIFT);
   967		cpu_to_le16s(&pRAID_Context->flow_specific.r56_arm_map);
   968		pRAID_Context->span_arm = (span << RAID_CTX_SPANARM_SPAN_SHIFT) | dataArm;
   969		pRAID_Context->raid_flags = (MR_RAID_FLAGS_IO_SUB_TYPE_R56_DIV_OFFLOAD <<
   970					    MR_RAID_CTX_RAID_FLAGS_IO_SUB_TYPE_SHIFT);
   971	
   972		return;
   973	}
   974	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
